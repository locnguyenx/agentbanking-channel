import 'dart:async';
import 'package:uuid/uuid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agentbanking_channel/features/hardware/hardware_providers.dart';
import 'package:agentbanking_channel/features/merchant/models/merchant_models.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:agentbanking_channel/features/hardware/hardware_interfaces.dart';
import 'package:agentbanking_channel/features/settlement/providers/float_provider.dart';
import 'package:agentbanking_channel/features/compliance/providers/compliance_provider.dart';
import 'package:agentbanking_channel/features/auth/providers/auth_provider.dart';

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
  final Decimal? purchaseAmount;
  final Decimal? cashbackAmount;
  final Decimal? mdr;
  final dynamic result;
  final String? error;

  final String? idempotencyKey;

  MerchantState({
    required this.status,
    this.type,
    this.amount,
    this.purchaseAmount,
    this.cashbackAmount,
    this.mdr,
    this.result,
    this.error,
    this.idempotencyKey,
  });

  MerchantState copyWith({
    MerchantStatus? status,
    MerchantTransactionType? type,
    Decimal? amount,
    Decimal? purchaseAmount,
    Decimal? cashbackAmount,
    Decimal? mdr,
    dynamic result,
    String? error,
    String? idempotencyKey,
  }) {
    return MerchantState(
      status: status ?? this.status,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      purchaseAmount: purchaseAmount ?? this.purchaseAmount,
      cashbackAmount: cashbackAmount ?? this.cashbackAmount,
      mdr: mdr ?? this.mdr,
      result: result ?? this.result,
      error: error ?? this.error,
      idempotencyKey: idempotencyKey ?? this.idempotencyKey,
    );
  }
}

class MerchantNotifier extends StateNotifier<MerchantState> {
  final Ref ref;
  final TransactionRepository repository;
  final ICardReader cardReader;
  final IPinPad pinPad;
  final IMerchantTerminal merchantTerminal;
  final FloatNotifier floatNotifier;
  final ComplianceNotifier complianceNotifier;
  final String agentId;
  final Duration pollingInterval;
  bool _mounted = true;
  bool _isPolling = false;
  Timer? _pollingTimer;
  Completer<void>? _pollingCompleter;

  MerchantNotifier({
    required this.ref,
    required this.repository,
    required this.cardReader,
    required this.pinPad,
    required this.merchantTerminal,
    required this.floatNotifier,
    required this.complianceNotifier,
    required this.agentId,
    this.pollingInterval = const Duration(seconds: 5),
  }) : super(MerchantState(status: MerchantStatus.idle));

  Future<void> startRetailSale(Decimal amount, FundingSource funding) async {
    if (complianceNotifier.state.isFrozen) {
      state = state.copyWith(status: MerchantStatus.failed, error: 'ERR_COMPLIANCE_FROZEN');
      return;
    }
    
    final idempotencyKey = Uuid().v4();
    state = state.copyWith(
      type: MerchantTransactionType.RETAIL_SALE,
      amount: amount,
      idempotencyKey: idempotencyKey,
    );

    if (funding == FundingSource.DUITNOW_QR) {
      await _executeQrSale(amount);
    } else {
      state = state.copyWith(status: MerchantStatus.waitingCard);
    }
  }

  Future<void> _executeQrSale(Decimal amount) async {
    if (!_mounted) return;
    state = state.copyWith(status: MerchantStatus.displayingQr);
    try {
      // 1. Request QR from Backend
      _isPolling = true;
      final qrData = await repository.generateQrSale(amount, agentId);
      if (!_mounted) return;
      final refId = qrData['referenceId']!;
      final qrPayload = qrData['qrPayload']!;

      // 2. Display on Terminal
      await merchantTerminal.displayQrCode(qrPayload);
      if (!_mounted) return;

      // 3. Start Polling for Payment Confirmation (PayNet notification)
      await _pollForQrPayment(refId);
    } catch (e) {
      if (_mounted) {
        state = state.copyWith(status: MerchantStatus.failed, error: e.toString());
      }
    }
  }

  Future<void> _pollForQrPayment(String refId) async {
    bool isApproved = false;
    Map<String, dynamic>? finalStatus;
    int retries = 0;
    while (_isPolling && !isApproved && retries < 36) { // 3 minutes max (36 * 5s)
      if (!_mounted) return;
      if (pollingInterval == Duration.zero) {
        await Future.microtask(() {});
      } else {
        _pollingCompleter = Completer<void>();
        _pollingTimer = Timer(pollingInterval, () {
          if (_pollingCompleter != null && !_pollingCompleter!.isCompleted) {
            _pollingCompleter!.complete();
          }
        });
        await _pollingCompleter!.future;
        _pollingTimer = null;
      }
      if (!_mounted) return;
      try {
        final data = await repository.getDuitNowStatus(refId);
        if (!_mounted) return;
        final status = data['status'] as String;
        if (status == 'SUCCESS' || status == 'COMPLETED') {
          isApproved = true;
          finalStatus = data;
          break;
        } else if (status == 'FAILED' || status == 'EXPIRED') {
          if (_mounted) {
            state = state.copyWith(status: MerchantStatus.failed, error: 'QR_$status');
          }
          break;
        }
      } catch (e) {
        // Continue polling on transient errors
      }
      retries++;
    }

    if (!_mounted) return;
    if (isApproved && finalStatus != null) {
      await merchantTerminal.clearDisplay();
      if (!_mounted) return;
      await floatNotifier.fetchLatestBalance();
      if (!_mounted) return;
      
      // Atomic Success: Data is already in the status response
      final result = RetailSaleResponse(
        floatCreditAmount: Decimal.parse(finalStatus['netToMerchant']?.toString() ?? '0'),
        mdrAmount: Decimal.parse(finalStatus['mdrAmount']?.toString() ?? '0'),
        receiptReference: finalStatus['transactionId'] ?? finalStatus['referenceId'],
      );
      
      if (_mounted) {
        state = state.copyWith(status: MerchantStatus.success, result: result);
      }
    } else if (state.status != MerchantStatus.failed) {
      await merchantTerminal.clearDisplay();
      if (_mounted) {
        state = state.copyWith(status: MerchantStatus.failed, error: 'QR_PAYMENT_TIMEOUT');
      }
    }
  }

  Future<void> processCardSale() async {
    if (!_mounted) return;
    state = state.copyWith(status: MerchantStatus.waitingCard);
    try {
      final card = await cardReader.readCard();
      if (!_mounted) return;
      if (card == null) {
        if (_mounted) {
          state = state.copyWith(status: MerchantStatus.failed, error: 'Card read failed');
        }
        return;
      }

      if (_mounted) {
        state = state.copyWith(status: MerchantStatus.waitingPin);
      }
      final pin = await pinPad.capturePin();
      if (!_mounted) return;
      if (pin == null) {
        if (_mounted) {
          state = state.copyWith(status: MerchantStatus.failed, error: 'PIN entry failed');
        }
        return;
      }

      if (_mounted) {
        state = state.copyWith(status: MerchantStatus.processing);
      }
      
      final result = await repository.executeRetailSale(
        state.amount!,
        agentId,
        pinBlock: pin,
        cardToken: card.cardToken,
      );
      if (!_mounted) return;

      await floatNotifier.fetchLatestBalance();
      if (!_mounted) return;
      if (_mounted) {
        state = state.copyWith(status: MerchantStatus.success, result: result);
      }
    } catch (e) {
      if (_mounted) {
        state = state.copyWith(status: MerchantStatus.failed, error: e.toString());
      }
    }
  }

  Future<void> startCashback(Decimal purchaseAmount, Decimal cashbackAmount) async {
    if (complianceNotifier.state.isFrozen) {
      state = state.copyWith(status: MerchantStatus.failed, error: 'ERR_COMPLIANCE_FROZEN');
      return;
    }
    state = state.copyWith(
      status: MerchantStatus.waitingCard,
      type: MerchantTransactionType.CASHBACK_HYBRID,
      amount: purchaseAmount + cashbackAmount,
      purchaseAmount: purchaseAmount,
      cashbackAmount: cashbackAmount,
    );
  }

  Future<void> processCashbackHandshake() async {
    if (!_mounted) return;
    try {
      final card = await cardReader.readCard();
      if (!_mounted) return;
      if (card == null) throw 'Card fail';
      
      if (_mounted) {
        state = state.copyWith(status: MerchantStatus.waitingPin);
      }
      final pin = await pinPad.capturePin();
      if (!_mounted) return;
      if (pin == null) throw 'PIN fail';

      if (_mounted) {
        state = state.copyWith(status: MerchantStatus.processing);
      }
      
      final result = await repository.executeCashback(
        state.purchaseAmount!,
        state.cashbackAmount!,
        agentId,
        pinBlock: pin,
        cardToken: card.cardToken,
      );
      if (!_mounted) return;

      await floatNotifier.fetchLatestBalance();
      if (!_mounted) return;
      if (_mounted) {
        state = state.copyWith(status: MerchantStatus.success, result: result);
      }
    } catch (e) {
      if (_mounted) {
        state = state.copyWith(status: MerchantStatus.failed, error: e.toString());
      }
    }
  }

  void reset() {
    state = MerchantState(status: MerchantStatus.idle);
  }

  @override
  void dispose() {
    print('BDD_DEBUG: MerchantNotifier disposing...');
    _mounted = false;
    _isPolling = false;
    _pollingTimer?.cancel();
    if (_pollingCompleter != null && !_pollingCompleter!.isCompleted) {
      _pollingCompleter!.complete();
    }
    super.dispose();
  }
}

final merchantProvider = StateNotifierProvider<MerchantNotifier, MerchantState>((ref) {
  final repository = ref.watch(transactionRepositoryProvider);
  final floatNotifier = ref.watch(floatProvider.notifier);
  final compliance = ref.watch(complianceProvider.notifier);
  final auth = ref.watch(authProvider);
  final agentId = auth.user?.agentId ?? 'AGENT_UNKNOWN';
  
  // Use providers so BDD tests can override them
  final cardReader = ref.watch(cardReaderProvider);
  final pinPad = ref.watch(pinPadProvider);
  final merchantTerminal = ref.watch(merchantTerminalProvider);
  
  return MerchantNotifier(
    ref: ref,
    repository: repository,
    cardReader: cardReader,
    pinPad: pinPad,
    merchantTerminal: merchantTerminal,
    floatNotifier: floatNotifier,
    complianceNotifier: compliance,
    agentId: agentId,
  );
});
