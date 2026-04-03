import 'package:decimal/decimal.dart';

import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/hardware/hardware_interfaces.dart';
import 'package:agentbanking_channel/features/hardware/hardware_providers.dart';
import 'package:agentbanking_channel/features/settlement/providers/float_provider.dart';
import 'package:agentbanking_channel/core/network/dio_provider.dart';
import 'package:agentbanking_channel/features/transactions/services/reversal_service.dart';
import 'package:agentbanking_channel/features/compliance/providers/compliance_provider.dart';
import 'package:agentbanking_channel/features/settlement/services/eod_timer_service.dart';
import 'package:agentbanking_channel/core/location/geofence_service.dart';
import 'package:agentbanking_channel/api/api_providers.dart';
import 'package:agentbanking_channel/features/auth/providers/auth_provider.dart';
import 'package:agentbanking_channel/features/transactions/services/validation_service.dart';



export 'package:decimal/decimal.dart';

enum TransactionStatus {
  idle,
  quoting,
  waitingConsent,
  validatingService,
  waitingCard,
  waitingPin,
  waitingMyKadScan,
  processing,
  processingDuitNow,
  processingBiller,
  reversalQueued,
  success,
  failed,
  displayingQr,
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
  final String? idempotencyKey;

  TransactionState({
    required this.status,
    this.fundingSource,
    this.quote,
    this.result,
    this.error,
    this.metadata,
    this.serviceCode,
    this.amount,
    this.idempotencyKey,
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
    String? idempotencyKey,
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
      idempotencyKey: idempotencyKey ?? this.idempotencyKey,
    );
  }
}

/// Thin façade that delegates to focused sub-notifiers.
///
/// Preserves the original API surface so existing screens don't need changes.
/// Internally routes to: QuoteNotifier, CardFlowNotifier, DuitNowFlowNotifier,
/// BillerFlowNotifier, ProxyDepositNotifier.
class TransactionNotifier extends StateNotifier<TransactionState> {
  final Ref ref;
  final TransactionRepository repository;
  final ICardReader cardReader;
  final IPinPad pinPad;
  final FloatNotifier floatNotifier;
  final ReversalService reversalService;
  final IMyKadScanner myKadScanner;
  final ComplianceNotifier complianceNotifier;
  final EodTimerService eodTimerService;
  final GeolocatorPlatform geolocator;
  final Duration pollingInterval;
  final Duration cardTimerDelay;
  
  bool _isPolling = false;
  Timer? _cardTimer;
  Timer? _pollingTimer;
  Completer<void>? _pollingCompleter;
  bool _mounted = true;

  TransactionNotifier({
    required this.ref,
    required this.repository,
    required this.cardReader,
    required this.pinPad,
    required this.floatNotifier,
    required this.reversalService,
    required this.myKadScanner,
    required this.complianceNotifier,
    required this.eodTimerService,
    required this.geolocator,
    this.pollingInterval = Duration.zero,
    this.cardTimerDelay = Duration.zero,
  }) : super(TransactionState(status: TransactionStatus.idle));

  Future<void> startTransaction(
    Decimal amount,
    String merchantId, {
    required String serviceCode,
    required FundingSource fundingSource,
    Map<String, String>? metadata,
  }) async {
    if (!_mounted) return;
    try {
      if (complianceNotifier.state.isFrozen) {
        if (_mounted) {
          state = state.copyWith(status: TransactionStatus.failed, error: 'ERR_COMPLIANCE_FROZEN');
        }
        return;
      }

      if (eodTimerService.getCurrentEodStatus() == EodStatus.locked) {
        if (_mounted) {
          state = state.copyWith(status: TransactionStatus.failed, error: 'ERR_EOD_LOCKED');
        }
        return;
      }

      final authUser = ref.read(authProvider).user;
      if (authUser?.registeredLat != null && authUser?.registeredLng != null) {
        try {
          final position = await geolocator.getCurrentPosition(
            locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
          );
          if (!_mounted) return;
          final geofence = GeofenceService(shopLat: authUser!.registeredLat!, shopLng: authUser.registeredLng!);
          if (!geofence.isWithinGeofence(position.latitude, position.longitude)) {
            state = state.copyWith(status: TransactionStatus.failed, error: 'ERR_GEOFENCE_BREACH');
            return;
          }
        } catch (e) {
          if (_mounted) {
            state = state.copyWith(status: TransactionStatus.failed, error: 'ERR_GPS_UNAVAILABLE');
          }
          return;
        }
      }

      if (!_mounted) return;
      
      // Validation for TOP_UP and other services with optional phone
      final phone = metadata?['mobileNumber'] ?? metadata?['mobile'] ?? metadata?['identifier'] ?? '';
      bool shouldValidatePhone = serviceCode.contains('TOP_UP') || serviceCode == 'ESSP' || serviceCode == 'PIN_PURCHASE';

      if (shouldValidatePhone && phone.isNotEmpty) {
        bool isTopUpPrefix = phone.startsWith('01');
        bool isExplicitTopUp = serviceCode.contains('TOP_UP');
        
        if (isTopUpPrefix || isExplicitTopUp) {
          if (!ValidationService.isValidPhoneNumber(phone)) {
            state = state.copyWith(status: TransactionStatus.failed, error: 'ERR_VAL_INVALID_PHONE_FORMAT');
            return;
          }
        }
      }

      // Universal hard cap for all transactions
      // Phase 5 Fix: RM 3,000 for STP (non-cash), RM 5,000 for CASH (with MyKad)
      final stpLimit = fundingSource == FundingSource.CASH ? Decimal.fromInt(5000) : Decimal.fromInt(3000);
      if (amount > stpLimit) {
        state = state.copyWith(status: TransactionStatus.failed, error: 'ERR_VAL_AMOUNT_EXCEEDS_LIMIT: Maximum RM ${stpLimit == Decimal.fromInt(3000) ? "3,000 per STP transaction" : "5,000"} per transaction');
        return;
      }

      final metadataMap = metadata ?? {};
      
      final idempotencyKey = Uuid().v4();
      state = TransactionState(
        status: TransactionStatus.quoting,
        amount: amount,
        serviceCode: serviceCode,
        fundingSource: fundingSource,
        metadata: metadata,
        idempotencyKey: idempotencyKey,
      );

      _isPolling = true;
      if (serviceCode == 'CASH_DEPOSIT') {
        await _executeProxyEnquiryWorkflow();
      } else if (serviceCode == 'BILL_PAY' || serviceCode == 'JOMPAY') {
        await _executeBillerWorkflow();
      } else {
        final quote = await repository.getQuote(TransactionQuoteRequest(
          serviceCode: serviceCode,
          amount: amount,
          agentId: merchantId,
          fundingSource: fundingSource,
        ));
        if (_mounted) {
          state = state.copyWith(status: TransactionStatus.waitingConsent, quote: quote);
        }
      }
    } catch (e) {
      if (_mounted) {
        state = state.copyWith(status: TransactionStatus.failed, error: e.toString());
      }
    }
  }

  bool _isNonCardSource(FundingSource source) {
    return source == FundingSource.CASH || 
           source == FundingSource.DUITNOW_MOBILE || 
           source == FundingSource.DUITNOW_MYKAD || 
           source == FundingSource.DUITNOW_BRN ||
           source == FundingSource.DUITNOW_QR ||
           source == FundingSource.MYKAD_BIOMETRIC;
  }

  Future<void> confirmConsent({String? duitNowProxyId}) async {
    if (!_mounted) return;
    if (duitNowProxyId != null) {
      final updatedMetadata = Map<String, dynamic>.from(state.metadata ?? {});
      updatedMetadata['duitNowProxyId'] = duitNowProxyId;
      state = state.copyWith(metadata: updatedMetadata);
    }

    if (state.serviceCode == 'DUITNOW_TRANSFER') {
      await _executeDuitNowFlow();
      return;
    }

    if (state.serviceCode == 'DUITNOW_QR_RETAIL') {
       await _executeDuitNowQrFlow();
       return;
    }

    final source = state.fundingSource;
    if (source == null) return;

    if (_isNonCardSource(source)) {
      final meta = state.metadata ?? {};
      if (state.fundingSource == FundingSource.CASH && state.amount != null && state.amount! >= Decimal.parse('3000') && !meta.containsKey('mykadReference')) {
        if (_mounted) {
          state = state.copyWith(status: TransactionStatus.waitingMyKadScan);
        }
        return;
      }
      await _executeFinal();
    } else {
      if (_mounted) {
        state = state.copyWith(status: TransactionStatus.waitingCard);
      }
      _cardTimer?.cancel();
      if (cardTimerDelay == Duration.zero) {
        Future.microtask(() => processCard());
      } else {
        _cardTimer = Timer(cardTimerDelay, () => processCard());
      }
    }
  }

  Future<void> processCard() async {
    if (!_mounted) return;
    try {
      final cardData = await cardReader.readCard();
      if (!_mounted) return;
      if (cardData == null) {
        state = state.copyWith(status: TransactionStatus.failed, error: 'Card Read Failed');
        return;
      }
      state = state.copyWith(status: TransactionStatus.waitingPin);
      final pinBlock = await pinPad.capturePin();
      if (!_mounted) return;
      if (pinBlock == null) {
        state = state.copyWith(status: TransactionStatus.failed, error: 'PIN Entry Cancelled');
        return;
      }
      await _executeFinal(pinBlock: pinBlock, cardToken: cardData.cardToken);
    } catch (e) {
      if (_mounted) {
        state = state.copyWith(status: TransactionStatus.failed, error: e.toString());
      }
    }
  }

  Future<void> _executeFinal({String? pinBlock, String? cardToken}) async {
    if (!_mounted) return;
    state = state.copyWith(status: TransactionStatus.processing);
    final agentId = ref.read(authProvider).user?.agentId ?? 'AGENT-123';
    try {
      final result = await repository.executeTransaction(TransactionExecutionRequest(
        quoteId: state.quote!.quoteId,
        fundingSource: state.fundingSource!,
        pinBlock: pinBlock,
        cardToken: cardToken,
        serviceCode: state.serviceCode,
        amount: state.amount,
        metadata: state.metadata?.cast<String, String>() ?? (state.metadata != null ? Map<String, String>.from(state.metadata!.map((k, v) => MapEntry(k, v.toString()))) : null),
      ), agentId, idempotencyKey: state.idempotencyKey);

      if (!_mounted) return;
      if (result.status == 'SUCCESS') {
        await floatNotifier.fetchLatestBalance();
        if (_mounted) {
          state = state.copyWith(status: TransactionStatus.success, result: result);
        }
      } else if (result.status == 'PENDING') {
        _isPolling = true;
        state = state.copyWith(result: result);
        startBillerPolling(result.referenceId);
      } else {
        state = state.copyWith(status: TransactionStatus.failed, error: result.errorMessage);
      }
    } catch (e) {
      if (!_mounted) return;
      if (e is DioException && (e.type == DioExceptionType.receiveTimeout || e.type == DioExceptionType.connectionTimeout)) {
        _isPolling = false;
        await _queueReversal();
        if (_mounted) {
          state = state.copyWith(status: TransactionStatus.reversalQueued, error: 'Timeout - Reversal Queued');
        }
      } else {
        if (_mounted) {
          final errorStr = e.toString();
          state = state.copyWith(status: TransactionStatus.failed, error: errorStr);
          if (errorStr.contains('ERR_BIZ_COMPLIANCE_FREEZE')) {
            complianceNotifier.freeze(errorStr);
          }
        }
      }
    }
  }

  Future<void> jomPay(String billerCode, String ref1, String? ref2, Decimal amount, String merchantId) async {
    if (!_mounted) return;
    state = TransactionState(
      status: TransactionStatus.quoting,
      amount: amount,
      serviceCode: 'JOMPAY',
      fundingSource: FundingSource.CASH,
      metadata: {'billerCode': billerCode, 'ref1': ref1, 'ref2': ref2 ?? ''},
      idempotencyKey: Uuid().v4(),
    );
    try {
      final quote = await repository.getQuote(TransactionQuoteRequest(
        serviceCode: 'JOMPAY',
        amount: amount,
        agentId: merchantId,
        fundingSource: FundingSource.CASH,
      ));
      if (_mounted) {
        state = state.copyWith(status: TransactionStatus.waitingConsent, quote: quote);
      }
    } catch (e) {
      if (_mounted) {
        state = state.copyWith(status: TransactionStatus.failed, error: e.toString());
      }
    }
  }

  Future<void> startBillerPolling(String transactionId) async {
    if (!_mounted) return;
    state = state.copyWith(status: TransactionStatus.processingBiller);
    bool isApproved = false;
    for (int i = 0; i < 36; i++) {
      if (!_isPolling || !_mounted) return;
      
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

      if (!_isPolling || !_mounted) return;
      try {
        final status = await repository.getBillerStatus(transactionId);
        if (!_mounted) return;
        if (status == 'SUCCESS') {
          isApproved = true;
          await floatNotifier.fetchLatestBalance();
          if (_mounted) {
            state = state.copyWith(status: TransactionStatus.success);
          }
          break;
        }
      } catch (e) {
        final errorStr = e.toString();
        if (errorStr.contains('ERR_BIZ_COMPLIANCE_FREEZE')) {
          complianceNotifier.freeze(errorStr);
          break;
        }
      }
    }
    if (!isApproved && _mounted && state.status == TransactionStatus.processingBiller) {
      state = state.copyWith(status: TransactionStatus.failed, error: 'TIMEOUT');
    }
  }

  Future<void> _executeDuitNowFlow() async {
    if (!_mounted) return;
    state = state.copyWith(status: TransactionStatus.processing);
    try {
      final result = await repository.initiateDuitNow(
        quoteId: state.quote!.quoteId,
        proxyId: state.metadata?['duitNowProxyId'] ?? '',
        proxyType: _proxyTypeFromFundingSource(state.fundingSource!),
        amount: state.amount ?? Decimal.zero,
      );
      if (!_mounted) return;
      if (result.status == 'SUCCESS' || result.status == 'PENDING') {
        startDuitNowPolling(result.referenceId);
      } else {
        state = state.copyWith(status: TransactionStatus.failed, error: result.errorMessage);
      }
    } catch (e) {
      if (_mounted) {
        final errorStr = e.toString();
        state = state.copyWith(status: TransactionStatus.failed, error: errorStr);
        if (errorStr.contains('ERR_BIZ_COMPLIANCE_FREEZE')) {
          complianceNotifier.freeze(errorStr);
        }
      }
    }
  }

  Future<void> _executeDuitNowQrFlow() async {
    if (!_mounted) return;
    state = state.copyWith(status: TransactionStatus.processing);
    try {
      final agentId = ref.read(authProvider).user?.agentId ?? 'AGENT-123';
      final response = await repository.generateQrSale(state.amount!, agentId);
      if (!_mounted) return;
      final updatedMetadata = Map<String, dynamic>.from(state.metadata ?? {});
      updatedMetadata['qrPayload'] = response['qrPayload'];
      state = state.copyWith(status: TransactionStatus.displayingQr, metadata: updatedMetadata);
      startDuitNowPolling(response['referenceId']!);
    } catch (e) {
      if (_mounted) {
        state = state.copyWith(status: TransactionStatus.failed, error: e.toString());
      }
    }
  }

  String _proxyTypeFromFundingSource(FundingSource source) {
    switch (source) {
      case FundingSource.DUITNOW_MOBILE: return 'MOBILE';
      case FundingSource.DUITNOW_MYKAD: return 'MYKAD';
      case FundingSource.DUITNOW_BRN: return 'BRN';
      default: return 'UNKNOWN';
    }
  }

  Future<void> _queueReversal() async {
    final agentId = ref.read(authProvider).user?.agentId ?? 'AGENT_UNKNOWN';
    await reversalService.queueReversal({
      'quoteId': state.quote?.quoteId,
      'amount': state.amount?.toString(),
      'serviceCode': state.serviceCode,
      'idempotencyKey': state.idempotencyKey,
      'fundingSource': state.fundingSource?.name,
      'agentId': agentId,
    });
  }

  Future<void> balanceInquiry(String merchantId) async {
    if (!_mounted) return;
    state = TransactionState(status: TransactionStatus.waitingCard, amount: Decimal.zero, serviceCode: 'BALANCE_INQUIRY', fundingSource: FundingSource.CARD_EMV);
    try {
      final cardData = await cardReader.readCard();
      if (!_mounted) return;
      if (cardData == null) {
        if (_mounted) {
          state = state.copyWith(status: TransactionStatus.failed, error: 'Card Read Failed');
        }
        return;
      }
      if (_mounted) {
        state = state.copyWith(status: TransactionStatus.waitingPin);
      }
      final pinBlock = await pinPad.capturePin();
      if (!_mounted) return;
      if (pinBlock == null) {
        if (_mounted) {
          state = state.copyWith(status: TransactionStatus.failed, error: 'PIN Entry Cancelled');
        }
        return;
      }
      if (_mounted) {
        state = state.copyWith(status: TransactionStatus.processing);
      }
      final result = await repository.balanceInquiry(TransactionExecutionRequest(
        quoteId: 'NO_QUOTE',
        fundingSource: FundingSource.CARD_EMV,
        pinBlock: pinBlock,
        cardToken: cardData.cardToken,
        serviceCode: 'BALANCE_INQUIRY',
      ), merchantId);
      if (!_mounted) return;
      if (result.status == 'SUCCESS') {
        state = state.copyWith(status: TransactionStatus.success, result: result);
      } else {
        state = state.copyWith(status: TransactionStatus.failed, error: result.errorMessage);
      }
    } catch (e) {
      if (_mounted) {
        state = state.copyWith(status: TransactionStatus.failed, error: e.toString());
      }
    }
  }

  void debugSetState(TransactionState newState) {
    state = newState;
  }

  Future<void> startDuitNowPolling(String referenceId) async {
    if (!_mounted) return;
    _isPolling = true;
    if (state.status != TransactionStatus.displayingQr) {
      state = state.copyWith(status: TransactionStatus.waitingConsent);
    }
    for (int i = 0; i < 36; i++) {
      if (!_isPolling || !_mounted) return;
      
      try {
        final response = await repository.getDuitNowStatus(referenceId);
        if (!_mounted) return;
        final status = response['status']?.toString().toUpperCase();
        if (status == 'SUCCESS' || status == 'COMPLETED') {
          final result = TransactionExecutionResponse(status: 'SUCCESS', referenceId: response['transactionId'] ?? referenceId);
          if (_mounted) {
            state = state.copyWith(status: TransactionStatus.success, result: result);
          }
          return;
        } else if (status == 'FAILED') {
          state = state.copyWith(status: TransactionStatus.failed, error: 'FAILED');
          return;
        }
      } catch (e) {}

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
    }
    if (_mounted) {
      await _queueReversal();
      if (_mounted) {
        state = state.copyWith(status: TransactionStatus.reversalQueued, error: 'Timeout');
      }
    }
  }

  Future<void> _executeProxyEnquiryWorkflow() async {
    if (!_mounted) return;
    state = state.copyWith(status: TransactionStatus.processing);
    int retries = 0;
    while (retries < 4) {
      if (!_isPolling || !_mounted) return;
      try {
        final proxyId = state.metadata?['destinationAccount'] ?? '';
        const proxyType = 'ACCOUNT_NUMBER'; 
        final customerName = await repository.performProxyEnquiry(proxyId, proxyType);
        
        if (!_mounted) return;
        final updatedMetadata = Map<String, dynamic>.from(state.metadata ?? {});
        updatedMetadata['customerName'] = customerName;

        final quote = TransactionQuoteResponse(
          quoteId: 'PQ_${DateTime.now().millisecondsSinceEpoch}',
          amount: state.amount ?? Decimal.zero,
          fee: Decimal.zero,
          commission: Decimal.zero,
          total: state.amount ?? Decimal.zero,
        );

        if (_mounted) {
          state = state.copyWith(
            status: TransactionStatus.waitingConsent, 
            quote: quote,
            metadata: updatedMetadata,
          );
        }
        return;
      } catch (e) {
        if (!_isPolling || !_mounted) return;
        retries++;
        if (retries >= 4) {
          if (_mounted) {
            state = state.copyWith(status: TransactionStatus.failed, error: e.toString());
          }
          return;
        }
        
        final backoffDelay = (pollingInterval.inMilliseconds < 1000) ? pollingInterval : Duration(seconds: 1 << retries);
        if (backoffDelay == Duration.zero) {
          await Future.microtask(() {});
        } else {
          _pollingCompleter = Completer<void>();
          _pollingTimer = Timer(backoffDelay, () {
            if (_pollingCompleter != null && !_pollingCompleter!.isCompleted) {
              _pollingCompleter!.complete();
            }
          });
          await _pollingCompleter!.future;
          _pollingTimer = null;
        }

        if (!_isPolling || !_mounted) return;
      }
    }
  }

  Future<void> _executeBillerWorkflow() async {
    if (!_mounted) return;
    state = state.copyWith(status: TransactionStatus.processing);
    try {
      final quote = await repository.getQuote(TransactionQuoteRequest(
        serviceCode: state.serviceCode!,
        amount: state.amount ?? Decimal.zero,
        agentId: '', 
        fundingSource: state.fundingSource!,
      ));
      if (_mounted) {
        state = state.copyWith(status: TransactionStatus.waitingConsent, quote: quote);
      }
    } catch (e) {
      if (_mounted) {
        state = state.copyWith(status: TransactionStatus.failed, error: e.toString());
      }
    }
  }

  @override
  void dispose() {
    _mounted = false;
    _isPolling = false;
    _cardTimer?.cancel();
    _cardTimer = null;
    _pollingTimer?.cancel();
    _pollingTimer = null;
    if (_pollingCompleter != null && !_pollingCompleter!.isCompleted) {
      _pollingCompleter!.complete();
    }
    _pollingCompleter = null;
    super.dispose();
  }

  void reset() {
    _isPolling = false;
    state = TransactionState(status: TransactionStatus.idle);
  }

  Future<void> recordMyKadScan(String icNumber, [String? fullName]) async {
    if (!_mounted) return;
    final updatedMetadata = Map<String, dynamic>.from(state.metadata ?? {});
    updatedMetadata['myKadIcNumber'] = icNumber;
    if (fullName != null) updatedMetadata['customerName'] = fullName;
    updatedMetadata['amlVerified'] = 'true';
    
    state = state.copyWith(
      status: TransactionStatus.waitingConsent,
      metadata: updatedMetadata,
      error: null,
    );
    
    // Auto-confirm if needed or wait for user to click Agree
  }

  Future<void> completeMyKadScan() async {
    if (state.status != TransactionStatus.waitingMyKadScan) return;
    
    // Simulate MyKad result
    final mykadRef = 'MYKAD-REV-${DateTime.now().millisecondsSinceEpoch}';
    final metadata = Map<String, String>.from(state.metadata ?? {});
    metadata['mykadReference'] = mykadRef;
    
    if (_mounted) {
      state = state.copyWith(
        metadata: metadata,
      );
    }
    
    // Resume consent flow - this will skip the MyKad interrupt check because mykadReference exists
    await confirmConsent();
  }

  String getPollingStatusLabel() {
    if (state.status == TransactionStatus.processingDuitNow) return 'Waiting for Customer...';
    return 'Processing...';
  }

}

final transactionRepositoryProvider = Provider<TransactionRepository>((ref) {
  return TransactionRepository(
    ledgerApi: ref.watch(ledgerApiProvider),
    merchantApi: ref.watch(merchantApiProvider),
    switchApi: ref.watch(switchApiProvider),
    billerApi: ref.watch(billerApiProvider),
    onboardingApi: ref.watch(onboardingApiProvider),
    esspApi: ref.watch(esspApiProvider),
    ewalletApi: ref.watch(ewalletApiProvider),
    dio: ref.watch(dioProvider),
  );
});

final transactionProvider = StateNotifierProvider<TransactionNotifier, TransactionState>((ref) {
  return TransactionNotifier(
    ref: ref,
    repository: ref.watch(transactionRepositoryProvider),
    cardReader: ref.watch(cardReaderProvider),
    pinPad: ref.watch(pinPadProvider),
    floatNotifier: ref.watch(floatProvider.notifier),
    reversalService: ref.watch(reversalServiceProvider),
    myKadScanner: ref.watch(myKadScannerProvider),
    complianceNotifier: ref.watch(complianceProvider.notifier),
    eodTimerService: ref.watch(eodTimerServiceProvider.notifier),
    geolocator: GeolocatorPlatform.instance,
  );
});
