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
import 'package:agentbanking_channel/api/api_providers.dart';

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
  final String? serviceCode;
  final Decimal? amount;

  TransactionState({
    required this.status,
    this.fundingSource,
    this.quote,
    this.result,
    this.error,
    this.metadata,
    this.serviceCode,
    this.amount,
  });

  TransactionState copyWith({
    TransactionStatus? status,
    FundingSource? fundingSource,
    TransactionQuoteResponse? quote,
    TransactionExecutionResponse? result,
    String? error,
    Map<String, dynamic>? metadata,
    String? serviceCode,
    Decimal? amount,
  }) {
    return TransactionState(
      status: status ?? this.status,
      fundingSource: fundingSource ?? this.fundingSource,
      quote: quote ?? this.quote,
      result: result ?? this.result,
      error: error ?? this.error,
      metadata: metadata ?? this.metadata,
      serviceCode: serviceCode ?? this.serviceCode,
      amount: amount ?? this.amount,
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
  final Duration validationDelay;

  TransactionNotifier({
    required this.repository,
    required this.cardReader,
    required this.pinPad,
    required this.floatNotifier,
    required this.reversalService,
    required this.myKadScanner,
    required this.complianceNotifier,
    this.pollingInterval = const Duration(seconds: 5),
    this.validationDelay = const Duration(seconds: 1),
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
      state = state.copyWith(status: TransactionStatus.failed, error: 'ERR_COMPLIANCE_FROZEN');
      return;
    }

    state = TransactionState(
      status: TransactionStatus.quoting,
      amount: amount,
      serviceCode: serviceCode,
      fundingSource: fundingSource,
      metadata: metadata,
    );

    try {
      final quote = await repository.getQuote(TransactionQuoteRequest(
        serviceCode: serviceCode,
        amount: amount,
        agentId: merchantId,
        fundingSource: fundingSource,
      ));
      
      state = state.copyWith(status: TransactionStatus.waitingConsent, quote: quote);
    } catch (e) {
      state = state.copyWith(status: TransactionStatus.failed, error: e.toString());
    }
  }

  bool _isNonCardSource(FundingSource source) {
    return source == FundingSource.CASH || 
           source == FundingSource.DUITNOW_MOBILE || 
           source == FundingSource.DUITNOW_MYKAD || 
           source == FundingSource.DUITNOW_BRN;
  }

  Future<void> confirmConsent({String? duitNowProxyId}) async {
    if (duitNowProxyId != null) {
      final updatedMetadata = Map<String, dynamic>.from(state.metadata ?? {});
      updatedMetadata['duitNowProxyId'] = duitNowProxyId;
      state = state.copyWith(metadata: updatedMetadata);
    }

    if (state.serviceCode == 'DUITNOW_TRANSFER') {
      await _executeDuitNowFlow();
      return;
    }

    if (_isNonCardSource(state.fundingSource!)) {
      // Large Cash AML Check (Phase 2 Rule)
      if (state.fundingSource == FundingSource.CASH && state.amount != null && state.amount! >= Decimal.parse('3000')) {
        state = state.copyWith(status: TransactionStatus.waitingMyKadScan);
        return;
      }
      await _executeFinal();
    } else {
      state = state.copyWith(status: TransactionStatus.validatingService);
      // Simulate backend validation before card insertion
      await Future.delayed(validationDelay);
      state = state.copyWith(status: TransactionStatus.waitingCard);
    }
  }

  Future<void> scanMyKadForAml() async {
    final myKad = await myKadScanner.scanMyKad();
    if (myKad != null) {
      await _executeFinal();
    } else {
      state = state.copyWith(status: TransactionStatus.failed, error: 'ERR_GPS_UNAVAILABLE');
    }
  }

  Future<void> processCard() async {
    try {
      final cardData = await cardReader.readCard();
      if (cardData == null) {
        state = state.copyWith(status: TransactionStatus.failed, error: 'Card Read Failed');
        return;
      }
      state = state.copyWith(status: TransactionStatus.waitingPin);
      final pinBlock = await pinPad.capturePin();
      if (pinBlock == null) {
        state = state.copyWith(status: TransactionStatus.failed, error: 'PIN Entry Cancelled');
        return;
      }
      await _executeFinal(pinBlock: pinBlock, cardToken: cardData.cardToken);
    } catch (e) {
      state = state.copyWith(status: TransactionStatus.failed, error: e.toString());
    }
  }

  Future<void> _executeFinal({String? pinBlock, String? cardToken}) async {
    state = state.copyWith(status: TransactionStatus.processing);
    try {
      final result = await repository.executeTransaction(TransactionExecutionRequest(
        quoteId: state.quote!.quoteId,
        fundingSource: state.fundingSource!,
        pinBlock: pinBlock,
        cardToken: cardToken,
        serviceCode: state.serviceCode,
        amount: state.amount,
        metadata: state.metadata?.cast<String, String>() ?? (state.metadata != null ? Map<String, String>.from(state.metadata!.map((k, v) => MapEntry(k, v.toString()))) : null),
      ));

      if (result.status == 'SUCCESS') {
        // Phase 2: Refetch balance instead of manual local updates
        await floatNotifier.fetchLatestBalance();
        state = state.copyWith(status: TransactionStatus.success, result: result);
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

  Future<void> _executeDuitNowFlow() async {
    state = state.copyWith(status: TransactionStatus.processing);
    try {
      final proxyId = state.metadata?['duitNowProxyId'] as String?;
      final proxyType = _proxyTypeFromFundingSource(state.fundingSource!);
      
      final result = await repository.initiateDuitNow(
        quoteId: state.quote!.quoteId,
        proxyId: proxyId ?? '',
        proxyType: proxyType,
      );

      if (result.status == 'SUCCESS') {
        await startDuitNowPolling(result.referenceId);
      } else {
        state = state.copyWith(status: TransactionStatus.failed, error: result.errorMessage);
      }
    } catch (e) {
      state = state.copyWith(status: TransactionStatus.failed, error: e.toString());
    }
  }

  String _proxyTypeFromFundingSource(FundingSource source) {
    switch (source) {
      case FundingSource.DUITNOW_MOBILE:
        return 'MOBILE';
      case FundingSource.DUITNOW_MYKAD:
        return 'MYKAD';
      case FundingSource.DUITNOW_BRN:
        return 'BRN';
      default:
        return 'UNKNOWN';
    }
  }

  Future<void> _queueReversal() async {
    // Phase 2: Implement robust reversal saga logic
    await reversalService.queueReversal({
      'quoteId': state.quote?.quoteId,
      'amount': state.amount?.toString(),
      'serviceCode': state.serviceCode,
    });
  }

  Future<void> balanceInquiry(String merchantId) async {
    // Check Compliance Freeze
    if (complianceNotifier.state.isFrozen) {
      state = state.copyWith(status: TransactionStatus.failed, error: 'ERR_COMPLIANCE_FROZEN');
      return;
    }

    state = TransactionState(
      status: TransactionStatus.quoting,
      amount: Decimal.zero,
      serviceCode: 'BALANCE_INQUIRY',
      fundingSource: FundingSource.CARD_EMV,
    );

    try {
      final quote = await repository.getQuote(TransactionQuoteRequest(
        serviceCode: 'BALANCE_INQUIRY',
        amount: Decimal.zero,
        agentId: merchantId,
        fundingSource: FundingSource.CARD_EMV,
      ));
      
      state = state.copyWith(status: TransactionStatus.waitingConsent, quote: quote);

      // Balance Inquiry automatically proceeds to card after quote
      await Future.delayed(const Duration(milliseconds: 500));
      state = state.copyWith(status: TransactionStatus.waitingCard);
      
      final cardData = await cardReader.readCard();
      if (cardData == null) {
        state = state.copyWith(status: TransactionStatus.failed, error: 'Card Read Failed');
        return;
      }
      state = state.copyWith(status: TransactionStatus.waitingPin);
      final pinBlock = await pinPad.capturePin();
      if (pinBlock == null) {
        state = state.copyWith(status: TransactionStatus.failed, error: 'PIN Entry Cancelled');
        return;
      }
      
      state = state.copyWith(status: TransactionStatus.processing);
      final result = await repository.balanceInquiry(TransactionExecutionRequest(
        quoteId: quote.quoteId,
        fundingSource: FundingSource.CARD_EMV,
        pinBlock: pinBlock,
        cardToken: cardData.cardToken,
        serviceCode: 'BALANCE_INQUIRY',
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

  Future<void> startDuitNowPolling(String referenceId) async {
    state = state.copyWith(status: TransactionStatus.processingDuitNow);
    
    // Polling logic for S14 (DuitNow Approval)
    bool isApproved = false;
    int retries = 0;
    while (!isApproved && retries < 36) { // 3 minutes max
      await Future.delayed(pollingInterval);
      final status = await repository.getDuitNowStatus(referenceId);
      if (status == 'SUCCESS' || status == 'COMPLETED') { // Support both labels
        isApproved = true;
        state = state.copyWith(status: TransactionStatus.success);
        break;
      } else if (status == 'FAILED' || status == 'EXPIRED') {
        state = state.copyWith(status: TransactionStatus.failed, error: 'DUITNOW_$status');
        break;
      }
      retries++;
    }

    if (!isApproved && state.status == TransactionStatus.processingDuitNow) {
       // TIMEOUT: Trigger reversal saga (MTI 0400)
       await _queueReversal();
       state = state.copyWith(
         status: TransactionStatus.reversalQueued,
         error: 'DuitNow Approval Timeout. Reversal initiated.',
       );
    }
  }

  void reset() {
    state = TransactionState(status: TransactionStatus.idle);
  }
}

final transactionRepositoryProvider = Provider<TransactionRepository>((ref) {
  return TransactionRepository(
    ledgerApi: ref.watch(ledgerApiProvider),
    merchantApi: ref.watch(merchantApiProvider),
    switchApi: ref.watch(switchApiProvider),
    billerApi: ref.watch(billerApiProvider),
    onboardingApi: ref.watch(onboardingApiProvider),
    dio: ref.watch(dioProvider),
  );
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
