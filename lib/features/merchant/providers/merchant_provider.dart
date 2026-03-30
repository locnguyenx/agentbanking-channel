import 'package:decimal/decimal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agentbanking_channel/features/merchant/models/merchant_models.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:agentbanking_channel/features/hardware/hardware_interfaces.dart';
import 'package:agentbanking_channel/features/hardware/mock_hardware_impl.dart';
import 'package:agentbanking_channel/features/settlement/providers/float_provider.dart';
import 'package:agentbanking_channel/features/compliance/providers/compliance_provider.dart';

enum MerchantStatus {
  idle,
  quoting,
  waitingCard,
  waitingPin,
  processing,
  displayingQr,      // NEW: for DuitNow QR
  success,
  failed,
}

class MerchantState {
  final MerchantStatus status;
  final MerchantTransactionType? type;
  final Decimal? amount;
  final Decimal? mdr;
  final dynamic result;
  final String? error;

  MerchantState({
    required this.status,
    this.type,
    this.amount,
    this.mdr,
    this.result,
    this.error,
  });

  MerchantState copyWith({
    MerchantStatus? status,
    MerchantTransactionType? type,
    Decimal? amount,
    Decimal? mdr,
    dynamic result,
    String? error,
  }) {
    return MerchantState(
      status: status ?? this.status,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      mdr: mdr ?? this.mdr,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}

class MerchantNotifier extends StateNotifier<MerchantState> {
  final TransactionRepository repository;
  final ICardReader cardReader;
  final IPinPad pinPad;
  final IMerchantTerminal merchantTerminal; // NEW: for QR display
  final FloatNotifier floatNotifier;
  final ComplianceNotifier complianceNotifier;

  MerchantNotifier({
    required this.repository,
    required this.cardReader,
    required this.pinPad,
    required this.merchantTerminal,
    required this.floatNotifier,
    required this.complianceNotifier,
  }) : super(MerchantState(status: MerchantStatus.idle));

  Future<void> startRetailSale(Decimal amount, FundingSource funding) async {
    if (complianceNotifier.state.isFrozen) {
      state = state.copyWith(status: MerchantStatus.failed, error: 'ERR_COMPLIANCE_FROZEN');
      return;
    }
    state = state.copyWith(
      status: MerchantStatus.quoting,
      type: MerchantTransactionType.RETAIL_SALE,
      amount: amount,
    );

    // Simulate MDR quoting (usually 1% for credit cards, 0.5% for QR)
    await Future.delayed(const Duration(seconds: 1));
    final mdrRate = funding == FundingSource.DUITNOW_QR ? '0.005' : '0.01';
    final mdr = amount * Decimal.parse(mdrRate);
    
    if (funding == FundingSource.DUITNOW_QR) {
      await _executeQrSale(amount);
    } else {
      state = state.copyWith(status: MerchantStatus.waitingCard, mdr: mdr);
    }
  }

  Future<void> _executeQrSale(Decimal amount) async {
    state = state.copyWith(status: MerchantStatus.displayingQr);
    try {
      // 1. Request QR from Backend
      // Mocking the referenceId and payload for now
      final refId = 'QR_${DateTime.now().millisecondsSinceEpoch}';
      final qrPayload = 'duitnow-qr-payload-for-$refId';

      // 2. Display on Terminal
      await merchantTerminal.displayQrCode(qrPayload);

      // 3. Start Polling for Payment Confirmation (PayNet notification)
      await _pollForQrPayment(refId);
    } catch (e) {
      state = state.copyWith(status: MerchantStatus.failed, error: e.toString());
    }
  }

  Future<void> _pollForQrPayment(String refId) async {
    bool isApproved = false;
    int retries = 0;
    while (!isApproved && retries < 36) { // 3 minutes max (36 * 5s)
      await Future.delayed(const Duration(seconds: 5));
      try {
        final status = await repository.getDuitNowStatus(refId);
        if (status == 'SUCCESS' || status == 'COMPLETED') {
          isApproved = true;
          break;
        } else if (status == 'FAILED' || status == 'EXPIRED') {
          state = state.copyWith(status: MerchantStatus.failed, error: 'QR_$status');
          break;
        }
      } catch (e) {
        // Continue polling on transient errors
      }
      retries++;
    }

    if (isApproved) {
      await merchantTerminal.clearDisplay();
      await floatNotifier.fetchLatestBalance();
      
      // Get the final result
      final result = await repository.executeRetailSale(
        state.amount!,
        'DUITNOW_QR',
      );
      
      state = state.copyWith(status: MerchantStatus.success, result: result);
    } else {
      await merchantTerminal.clearDisplay();
      state = state.copyWith(status: MerchantStatus.failed, error: 'QR_PAYMENT_TIMEOUT');
    }
  }

  Future<void> processCardSale() async {
    state = state.copyWith(status: MerchantStatus.waitingCard);
    try {
      final card = await cardReader.readCard();
      if (card == null) {
        state = state.copyWith(status: MerchantStatus.failed, error: 'Card read failed');
        return;
      }

      state = state.copyWith(status: MerchantStatus.waitingPin);
      final pin = await pinPad.capturePin();
      if (pin == null) {
        state = state.copyWith(status: MerchantStatus.failed, error: 'PIN entry failed');
        return;
      }

      state = state.copyWith(status: MerchantStatus.processing);
      
      final result = await repository.executeRetailSale(
        state.amount!,
        'CARD_EMV', // Explicit card funding
        pinBlock: pin,
        cardToken: card.cardToken,
      );

      await floatNotifier.fetchLatestBalance();
      state = state.copyWith(status: MerchantStatus.success, result: result);
    } catch (e) {
      state = state.copyWith(status: MerchantStatus.failed, error: e.toString());
    }
  }

  Future<void> startCashback(Decimal purchaseAmount, Decimal cashbackAmount) async {
    if (complianceNotifier.state.isFrozen) {
      state = state.copyWith(status: MerchantStatus.failed, error: 'ERR_COMPLIANCE_FROZEN');
      return;
    }
    state = state.copyWith(
      status: MerchantStatus.quoting,
      type: MerchantTransactionType.CASHBACK_HYBRID,
      amount: purchaseAmount + cashbackAmount,
    );

    await Future.delayed(const Duration(milliseconds: 500));
    state = state.copyWith(status: MerchantStatus.waitingCard);
  }

  Future<void> processCashbackHandshake() async {
    try {
      final card = await cardReader.readCard();
      if (card == null) throw 'Card fail';
      state = state.copyWith(status: MerchantStatus.waitingPin);
      final pin = await pinPad.capturePin();
      if (pin == null) throw 'PIN fail';

      state = state.copyWith(status: MerchantStatus.processing);
      
      final result = await repository.executeCashback(
        state.amount! - Decimal.parse('50.0'), // Again, split logic should be in repository/backend if possible, 
        Decimal.parse('50.0'),                 // but following the BDD S9.4 mock split for now with a real API call.
        'CARD_EMV',
        pinBlock: pin,
        cardToken: card.cardToken,
      );

      await floatNotifier.fetchLatestBalance();
      state = state.copyWith(status: MerchantStatus.success, result: result);
    } catch (e) {
      state = state.copyWith(status: MerchantStatus.failed, error: e.toString());
    }
  }

  void reset() {
    state = MerchantState(status: MerchantStatus.idle);
  }
}

final merchantProvider = StateNotifierProvider<MerchantNotifier, MerchantState>((ref) {
  final repository = ref.watch(transactionRepositoryProvider);
  final floatNotifier = ref.watch(floatProvider.notifier);
  final compliance = ref.watch(complianceProvider.notifier);
  return MerchantNotifier(
    repository: repository,
    cardReader: MockCardReader(),
    pinPad: MockPinPad(),
    merchantTerminal: MockMerchantTerminal(),
    floatNotifier: floatNotifier,
    complianceNotifier: compliance,
  );
});
