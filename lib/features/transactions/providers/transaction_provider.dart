import 'package:decimal/decimal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/hardware/hardware_interfaces.dart';
import 'package:agentbanking_channel/features/hardware/mock_hardware_impl.dart';
import 'package:agentbanking_channel/features/settlement/providers/float_provider.dart';

enum TransactionStatus {
  idle,
  quoting,
  waitingConsent,
  waitingCard,
  waitingPin,
  processing,
  success,
  failed,
}

class TransactionState {
  final TransactionStatus status;
  final FundingSource? fundingSource;
  final TransactionQuoteResponse? quote;
  final TransactionExecutionResponse? result;
  final String? error;
  final Map<String, dynamic>? metadata;

  TransactionState({
    required this.status,
    this.fundingSource,
    this.quote,
    this.result,
    this.error,
    this.metadata,
  });

  TransactionState copyWith({
    TransactionStatus? status,
    FundingSource? fundingSource,
    TransactionQuoteResponse? quote,
    TransactionExecutionResponse? result,
    String? error,
    Map<String, dynamic>? metadata,
  }) {
    return TransactionState(
      status: status ?? this.status,
      fundingSource: fundingSource ?? this.fundingSource,
      quote: quote ?? this.quote,
      result: result ?? this.result,
      error: error ?? this.error,
      metadata: metadata ?? this.metadata,
    );
  }
}

class TransactionNotifier extends StateNotifier<TransactionState> {
  final TransactionRepository repository;
  final ICardReader cardReader;
  final IPinPad pinPad;
  final FloatNotifier floatNotifier;

  TransactionNotifier({
    required this.repository,
    required this.cardReader,
    required this.pinPad,
    required this.floatNotifier,
  }) : super(TransactionState(status: TransactionStatus.idle));

  Future<void> startTransaction(Decimal amount, String agentId, {
    String serviceCode = 'CASH_WDL',
    FundingSource fundingSource = FundingSource.CARD_EMV,
    Map<String, dynamic>? metadata,
  }) async {
    state = state.copyWith(
      status: TransactionStatus.quoting, 
      fundingSource: fundingSource,
      error: null,
      metadata: metadata,
    );
    try {
      final quote = await repository.getQuote(TransactionQuoteRequest(
        amount: amount,
        serviceCode: serviceCode,
        agentId: agentId,
        fundingSource: fundingSource,
      ));
      state = state.copyWith(status: TransactionStatus.waitingConsent, quote: quote);
    } catch (e) {
      state = state.copyWith(status: TransactionStatus.failed, error: e.toString());
    }
  }

  Future<void> confirmConsent({String? duitNowProxyId}) async {
    if (state.quote == null || state.fundingSource == null) return;
    
    switch (state.fundingSource!) {
      case FundingSource.CARD_EMV:
        await _handleCardTransaction();
        break;
      case FundingSource.CASH:
        await _handleCashTransaction();
        break;
      case FundingSource.DUITNOW_MOBILE:
      case FundingSource.DUITNOW_MYKAD:
      case FundingSource.DUITNOW_BRN:
        await _handleDuitNowTransaction(duitNowProxyId, state.fundingSource!);
        break;
      case FundingSource.MYKAD_BIOMETRIC:
        // TODO: Implement MyKad Biometric withdrawal flow in Phase 2
        state = state.copyWith(status: TransactionStatus.failed, error: 'MyKad Biometric not yet implemented');
        break;
    }
  }

  Future<void> _handleCardTransaction() async {
    state = state.copyWith(status: TransactionStatus.waitingCard);
    final cardData = await cardReader.readCard();
    if (cardData == null) {
      state = state.copyWith(status: TransactionStatus.failed, error: 'Card Read Failed');
      return;
    }

    state = state.copyWith(status: TransactionStatus.waitingPin);
    final pinBlock = await pinPad.capturePin();
    if (pinBlock == null) {
      state = state.copyWith(status: TransactionStatus.failed, error: 'PIN Capture Failed');
      return;
    }

    state = state.copyWith(status: TransactionStatus.processing);
    await _execute(TransactionExecutionRequest(
      quoteId: state.quote!.quoteId,
      fundingSource: FundingSource.CARD_EMV,
      pinBlock: pinBlock,
      cardToken: cardData.cardToken,
    ));
  }

  Future<void> _handleCashTransaction() async {
    state = state.copyWith(status: TransactionStatus.processing);
    await _execute(TransactionExecutionRequest(
      quoteId: state.quote!.quoteId,
      fundingSource: FundingSource.CASH,
    ));
  }

  Future<void> _handleDuitNowTransaction(String? proxyId, FundingSource source) async {
    if (proxyId == null) {
      state = state.copyWith(status: TransactionStatus.failed, error: 'Proxy ID required for DuitNow');
      return;
    }
    state = state.copyWith(status: TransactionStatus.processing);
    
    // Trigger Request for Payment (RTP)
    final result = await repository.executeTransaction(TransactionExecutionRequest(
      quoteId: state.quote!.quoteId,
      fundingSource: source,
      duitNowProxyId: proxyId,
    ));

    if (result.status == 'SUCCESS') {
      // Begin polling for final status
      await _pollDuitNowStatus(result.referenceId);
    } else {
      state = state.copyWith(status: TransactionStatus.failed, error: result.errorMessage);
    }
  }

  Future<void> _pollDuitNowStatus(String referenceId) async {
    // Simulated polling logic
    for (int i = 0; i < 5; i++) {
      await Future.delayed(const Duration(seconds: 2));
      // In real implementation, call repository.getTransactionStatus(referenceId)
    }
    state = state.copyWith(status: TransactionStatus.success);
  }

  Future<void> _execute(TransactionExecutionRequest request) async {
    try {
      final result = await repository.executeTransaction(request);
      if (result.status == 'SUCCESS') {
        _updateFloat(request);
        state = state.copyWith(status: TransactionStatus.success, result: result);
      } else {
        state = state.copyWith(status: TransactionStatus.failed, error: result.errorMessage);
      }
    } catch (e) {
      state = state.copyWith(status: TransactionStatus.failed, error: e.toString());
    }
  }

  void _updateFloat(TransactionExecutionRequest request) {
    // Logic: In agent banking, "Cash-In" (client gives agent cash, agent gives client float/digital money)
    // means Agent's float is DEBITED (decreased).
    // "Cash-Out" (Withdrawal) means Agent's float is CREDITED (increased).
    
    final quote = state.quote;
    if (quote == null) return;

    if (request.fundingSource == FundingSource.CASH) {
      // Typically Cash-In or Bill Payment
      floatNotifier.debitFloat(quote.amount, request.quoteId);
    } else if (request.fundingSource == FundingSource.CARD_EMV) {
      // Typically Cash Withdrawal
      floatNotifier.creditFloat(quote.amount, request.quoteId);
    }
  }

  void reset() {
    state = TransactionState(status: TransactionStatus.idle);
  }
}

final transactionRepositoryProvider = Provider<TransactionRepository>((ref) => TransactionRepository(Dio()));

final transactionProvider = StateNotifierProvider<TransactionNotifier, TransactionState>((ref) {
  final repository = ref.watch(transactionRepositoryProvider);
  final floatNotifier = ref.watch(floatProvider.notifier);
  return TransactionNotifier(
    repository: repository,
    cardReader: MockCardReader(),
    pinPad: MockPinPad(),
    floatNotifier: floatNotifier,
  );
});
