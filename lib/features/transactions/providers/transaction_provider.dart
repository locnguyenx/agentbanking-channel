import 'package:decimal/decimal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/hardware/hardware_interfaces.dart';
import 'package:agentbanking_channel/features/hardware/mock_hardware_impl.dart';
import 'package:agentbanking_channel/features/settlement/providers/float_provider.dart';
import 'package:agentbanking_channel/core/network/dio_provider.dart';
import 'package:agentbanking_channel/features/transactions/services/reversal_service.dart';
import 'package:agentbanking_channel/features/compliance/providers/compliance_provider.dart';

enum TransactionStatus {
  idle,
  quoting,
  waitingConsent,
  validatingService,   // NEW: Ref-1/phone check before card
  waitingCard,
  waitingPin,
  waitingMyKadScan,    // NEW: large cash AML check
  processing,
  processingDuitNow,
  reversalQueued,
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
  final ReversalService reversalService;
  final IMyKadScanner myKadScanner;
  final ComplianceNotifier complianceNotifier;
  final Duration pollingInterval;

  TransactionNotifier({
    required this.repository,
    required this.cardReader,
    required this.pinPad,
    required this.floatNotifier,
    required this.reversalService,
    required this.myKadScanner,
    required this.complianceNotifier,
    this.pollingInterval = const Duration(seconds: 5),
  }) : super(TransactionState(status: TransactionStatus.idle));

  Future<void> startTransaction(
    Decimal amount,
    String merchantId, {
    required String serviceCode,
    required FundingSource fundingSource,
    Map<String, String>? metadata,
  }) async {
    // Check Compliance Freeze (Task 4)
    if (complianceNotifier.state.isFrozen) {
      state = state.copyWith(
        status: TransactionStatus.failed,
        error: 'ERR_COMPLIANCE_FROZEN: Terminal is locked for review.',
      );
      return;
    }

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
        agentId: merchantId,
        fundingSource: fundingSource,
      ));
      state = state.copyWith(status: TransactionStatus.waitingConsent, quote: quote);
    } catch (e) {
      state = state.copyWith(status: TransactionStatus.failed, error: e.toString());
    }
  }

  Future<void> confirmConsent({String? duitNowProxyId}) async {
    if (state.quote == null) return;

    // FR-CA-4.7: Card-funded generic validation (e.g. Ref-1 check)
    if (state.fundingSource == FundingSource.CARD_EMV) {
      state = state.copyWith(status: TransactionStatus.validatingService);
      // Simulate backend validation (Ref-1, biller availability)
      await Future.delayed(const Duration(seconds: 1));
    }

    if (state.fundingSource == FundingSource.DUITNOW_MOBILE || 
        state.fundingSource == FundingSource.DUITNOW_MYKAD ||
        state.fundingSource == FundingSource.DUITNOW_BRN) {
      await _handleDuitNowTransaction(duitNowProxyId);
    } else if (state.fundingSource == FundingSource.CASH) {
      await _handleCashTransaction();
    } else {
      await _handleCardTransaction();
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
    // BRD FR-CA-4.8: MyKad required if cash collected > RM 3,000
    final amount = state.quote!.amount;
    if (amount > Decimal.parse('3000.00')) {
      state = state.copyWith(status: TransactionStatus.waitingMyKadScan);
      try {
        final myKadData = await myKadScanner.scanMyKad();
        if (myKadData == null) {
          state = state.copyWith(status: TransactionStatus.failed, error: 'MyKad scan required for AML');
          return;
        }
        // Include MyKad reference in API call
        state = state.copyWith(metadata: {
          ...?state.metadata, 
          'myKadRef': myKadData.icNumber,
          'complianceType': 'AML_LARGE_CASH'
        });
      } catch (e) {
        state = state.copyWith(status: TransactionStatus.failed, error: 'MyKad Scanner Error: $e');
        return;
      }
    }

    state = state.copyWith(status: TransactionStatus.processing);
    try {
      final result = await repository.executeTransaction(TransactionExecutionRequest(
        quoteId: state.quote!.quoteId,
        fundingSource: FundingSource.CASH,
      ));
      
      if (result.status == 'SUCCESS') {
        await floatNotifier.fetchLatestBalance();
        state = state.copyWith(status: TransactionStatus.success, result: result);
      } else {
        state = state.copyWith(status: TransactionStatus.failed, error: result.errorMessage);
      }
    } catch (e) {
      state = state.copyWith(status: TransactionStatus.failed, error: e.toString());
    }
  }

  Future<void> _handleDuitNowTransaction(String? proxyId) async {
    if (proxyId == null) {
      state = state.copyWith(status: TransactionStatus.failed, error: 'Proxy ID required');
      return;
    }
    state = state.copyWith(status: TransactionStatus.processing);
    try {
      final initResult = await repository.initiateDuitNow(
        quoteId: state.quote!.quoteId,
        proxyId: proxyId,
        proxyType: _proxyTypeFromFundingSource(state.fundingSource!),
      );
      state = state.copyWith(status: TransactionStatus.processingDuitNow);
      await _pollDuitNowStatus(initResult.referenceId);
    } catch (e) {
      await _queueReversal();
      state = state.copyWith(status: TransactionStatus.reversalQueued, error: e.toString());
    }
  }

  String _proxyTypeFromFundingSource(FundingSource fs) {
    switch (fs) {
      case FundingSource.DUITNOW_MOBILE: return 'MOBILE';
      case FundingSource.DUITNOW_MYKAD: return 'NRIC';
      case FundingSource.DUITNOW_BRN:   return 'BRN';
      default: throw ArgumentError('Not a DuitNow funding source: $fs');
    }
  }

  Future<void> _pollDuitNowStatus(String referenceId) async {
    // BDD Feature 4 S4.4: poll every 5s for max 3 minutes (36 attempts)
    for (int i = 0; i < 36; i++) {
      await Future.delayed(pollingInterval);
      try {
        final status = await repository.getDuitNowStatus(referenceId);
        if (status == 'COMPLETED') {
          state = state.copyWith(status: TransactionStatus.success);
          await floatNotifier.fetchLatestBalance();
          return;
        } else if (status == 'DECLINED') {
          state = state.copyWith(status: TransactionStatus.failed, error: 'Customer declined');
          return;
        }
      } catch (e) {
        // Continue polling on transient errors
      }
    }
    // Timeout after 3 min — treat as unknown, queue reversal
    await _queueReversal();
    state = state.copyWith(
      status: TransactionStatus.reversalQueued, 
      error: 'DuitNow confirmation timed out. A reversal has been queued.'
    );
  }

  Future<void> _queueReversal() async {
    if (state.quote == null) return;
    
    final originalRequest = {
      'quoteId': state.quote!.quoteId,
      'amount': state.quote!.amount.toString(),
      'serviceCode': state.metadata?['serviceCode'] ?? 'DUITNOW_TRANSFER',
      'idempotencyKey': state.metadata?['idempotencyKey'] ?? state.quote!.quoteId,
      'fundingSource': state.fundingSource?.name,
    };
    
    await reversalService.queueReversal(originalRequest);
  }

  Future<void> balanceInquiry(String agentId, {
    FundingSource fundingSource = FundingSource.CARD_EMV,
  }) async {
    state = state.copyWith(
      status: TransactionStatus.quoting, 
      fundingSource: fundingSource,
      error: null,
    );
    try {
      final quote = await repository.getQuote(TransactionQuoteRequest(
        amount: Decimal.zero,
        serviceCode: 'BALANCE_INQUIRY',
        agentId: agentId,
        fundingSource: fundingSource,
      ));
      state = state.copyWith(status: TransactionStatus.waitingConsent, quote: quote);
      
      // Auto-confirm for balance inquiry if it's card-based
      if (fundingSource == FundingSource.CARD_EMV) {
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
        final result = await repository.balanceInquiry(TransactionExecutionRequest(
          quoteId: quote.quoteId,
          fundingSource: FundingSource.CARD_EMV,
          pinBlock: pinBlock,
          cardToken: cardData.cardToken,
        ));
        
        if (result.status == 'SUCCESS') {
          state = state.copyWith(status: TransactionStatus.success, result: result);
          await floatNotifier.fetchLatestBalance();
        } else {
          state = state.copyWith(status: TransactionStatus.failed, error: result.errorMessage);
        }
      }
    } catch (e) {
      state = state.copyWith(status: TransactionStatus.failed, error: e.toString());
    }
  }

  Future<void> _execute(TransactionExecutionRequest request) async {
    try {
      final result = await repository.executeTransaction(request);
      if (result.status == 'SUCCESS') {
        state = state.copyWith(status: TransactionStatus.success, result: result);
        // Refresh float balance from backend
        await floatNotifier.fetchLatestBalance();
      } else {
        state = state.copyWith(status: TransactionStatus.failed, error: result.errorMessage);
      }
    } catch (e) {
      if (e is DioException && (e.type == DioExceptionType.receiveTimeout || e.type == DioExceptionType.connectionTimeout)) {
        await _queueReversal();
        state = state.copyWith(
          status: TransactionStatus.reversalQueued,
          error: 'Connection Timeout. A reversal has been queued. Please check status later.',
        );
      } else {
        state = state.copyWith(status: TransactionStatus.failed, error: e.toString());
      }
    }
  }

  void reset() {
    state = TransactionState(status: TransactionStatus.idle);
  }
}

final transactionRepositoryProvider = Provider<TransactionRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return TransactionRepository(dio);
});

final transactionProvider = StateNotifierProvider<TransactionNotifier, TransactionState>((ref) {
  final repository = ref.watch(transactionRepositoryProvider);
  final floatNotifier = ref.watch(floatProvider.notifier);
  final reversalService = ref.watch(reversalServiceProvider);
  final myKadScanner = MockMyKadScanner();
  final compliance = ref.watch(complianceProvider.notifier);

  return TransactionNotifier(
    repository: repository,
    cardReader: MockCardReader(),
    pinPad: MockPinPad(),
    floatNotifier: floatNotifier,
    reversalService: reversalService,
    myKadScanner: myKadScanner,
    complianceNotifier: compliance,
  );
});
