import 'package:decimal/decimal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agentbanking_channel/features/merchant/models/merchant_models.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:agentbanking_channel/features/hardware/hardware_interfaces.dart';
import 'package:agentbanking_channel/features/hardware/mock_hardware_impl.dart';
import 'package:agentbanking_channel/features/settlement/providers/float_provider.dart';

enum MerchantStatus {
  idle,
  quoting,
  waitingCard,
  waitingPin,
  processing,
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
  final FloatNotifier floatNotifier;

  MerchantNotifier({
    required this.repository,
    required this.cardReader,
    required this.pinPad,
    required this.floatNotifier,
  }) : super(MerchantState(status: MerchantStatus.idle));

  Future<void> startRetailSale(Decimal amount, FundingSource funding) async {
    state = state.copyWith(
      status: MerchantStatus.quoting,
      type: MerchantTransactionType.RETAIL_SALE,
      amount: amount,
    );

    // Simulate MDR quoting (usually 1% for credit cards)
    await Future.delayed(const Duration(seconds: 1));
    final mdr = amount * Decimal.parse('0.01');
    state = state.copyWith(status: MerchantStatus.waitingCard, mdr: mdr);
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
      // In a real app, this would be a dedicated repository call for Merchant Retail Sale
      // For Phase 2 demo, we simulate success response matching BDD S9.1
      await Future.delayed(const Duration(seconds: 2));
      
      final result = RetailSaleResponse(
        floatCreditAmount: state.amount! - state.mdr!,
        mdrAmount: state.mdr!,
        receiptReference: 'RETAIL-${DateTime.now().millisecondsSinceEpoch}',
      );

      await floatNotifier.fetchLatestBalance();
      state = state.copyWith(status: MerchantStatus.success, result: result);
    } catch (e) {
      state = state.copyWith(status: MerchantStatus.failed, error: e.toString());
    }
  }

  Future<void> startCashback(Decimal purchaseAmount, Decimal cashbackAmount) async {
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
      await Future.delayed(const Duration(seconds: 2));

      // BDD S9.4: return split amounts
      final total = state.amount!;
      final result = CashbackResponse(
        purchaseAmount: total - Decimal.parse('50.0'), // Mocked split
        cashBackAmount: Decimal.parse('50.0'),
        receiptReference: 'CSHBK-${DateTime.now().millisecondsSinceEpoch}',
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
  return MerchantNotifier(
    repository: repository,
    cardReader: MockCardReader(),
    pinPad: MockPinPad(),
    floatNotifier: floatNotifier,
  );
});
