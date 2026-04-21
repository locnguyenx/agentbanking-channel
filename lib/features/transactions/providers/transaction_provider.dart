import 'package:decimal/decimal.dart';
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';

import 'package:agentbanking_channel/features/transactions/providers/quote_notifier.dart';
import 'package:agentbanking_channel/features/transactions/providers/card_flow_notifier.dart';
import 'package:agentbanking_channel/features/transactions/providers/duitnow_flow_notifier.dart';
import 'package:agentbanking_channel/features/transactions/providers/biller_flow_notifier.dart';
import 'package:agentbanking_channel/features/transactions/providers/proxy_deposit_notifier.dart';
import 'package:agentbanking_channel/features/auth/providers/auth_provider.dart';
import 'package:agentbanking_channel/api/api_providers.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_state.dart';
import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';
import 'package:agentbanking_channel/features/hardware/hardware_interfaces.dart';
import 'package:agentbanking_channel/features/hardware/hardware_providers.dart';
import 'package:agentbanking_channel/features/settlement/providers/float_provider.dart';
import 'package:agentbanking_channel/core/network/dio_provider.dart';
import 'package:agentbanking_channel/features/transactions/services/reversal_service.dart';
import 'package:agentbanking_channel/features/compliance/providers/compliance_provider.dart';
import 'package:agentbanking_channel/features/settlement/services/eod_timer_service.dart';
import 'package:agentbanking_channel/core/location/geofence_service.dart';
import 'package:agentbanking_channel/features/transactions/services/validation_service.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_guards.dart';
import 'package:agentbanking_channel/core/network/geolocator_provider.dart';

export 'package:decimal/decimal.dart';
export 'package:agentbanking_channel/features/transactions/models/transaction_state.dart';

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

  bool _mounted = true;

  late QuoteNotifier _quoteNotifier;
  late CardFlowNotifier _cardFlowNotifier;
  late DuitNowFlowNotifier _duitNowFlowNotifier;
  late BillerFlowNotifier _billerFlowNotifier;
  late ProxyDepositNotifier _proxyDepositNotifier;

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
    this.pollingInterval = const Duration(seconds: 2),
    this.cardTimerDelay = Duration.zero,
  }) : super(TransactionState(status: TransactionStatus.idle)) {
    // Initializing specialized sub-notifiers
    _quoteNotifier = QuoteNotifier(
      ref: ref,
      repository: repository,
      geolocator: geolocator,
    );
    _cardFlowNotifier = CardFlowNotifier(
      ref: ref,
      repository: repository,
      cardReader: cardReader,
      pinPad: pinPad,
      floatNotifier: floatNotifier,
      reversalService: reversalService,
      cardTimerDelay: cardTimerDelay,
    );
    _duitNowFlowNotifier = DuitNowFlowNotifier(
      ref: ref,
      repository: repository,
      floatNotifier: floatNotifier,
      reversalService: reversalService,
      pollingInterval: pollingInterval,
    );
    _billerFlowNotifier = BillerFlowNotifier(
      ref: ref,
      repository: repository,
      floatNotifier: floatNotifier,
      geolocator: geolocator,
      pollingInterval: pollingInterval,
    );
    _proxyDepositNotifier = ProxyDepositNotifier(
      ref: ref,
      repository: repository,
      myKadScanner: myKadScanner,
      geolocator: geolocator,
      pollingInterval: pollingInterval,
    );

    // Sync sub-notifier state changes back to façade
    _quoteNotifier.addListener((s) {
      if (_mounted) state = s as TransactionState;
    });
    _cardFlowNotifier.addListener((s) {
      if (_mounted) state = s as TransactionState;
    });
    _duitNowFlowNotifier.addListener((s) {
      if (_mounted) state = s as TransactionState;
    });
    _billerFlowNotifier.addListener((s) {
      if (_mounted) state = s as TransactionState;
    });
    _proxyDepositNotifier.addListener((s) {
      if (_mounted) state = s as TransactionState;
    });
  }

  /// Start a transaction (Delegates to QuoteNotifier, BillerFlow, or ProxyFlow).
  Future<void> startTransaction(
    Decimal amount,
    String merchantId, {
    required String serviceCode,
    required FundingSource fundingSource,
    Map<String, String>? metadata,
  }) async {
    if (!_mounted) return;

    if (serviceCode == 'CASH_DEPOSIT') {
      await _proxyDepositNotifier.executeProxyEnquiry(
        amount: amount,
        merchantId: merchantId,
        fundingSource: fundingSource,
        metadata: metadata,
      );
    } else if (serviceCode == 'BILL_PAYMENT' || serviceCode == 'JOMPAY') {
      await _billerFlowNotifier.executeBillerWorkflow(
        amount: amount,
        merchantId: merchantId,
        serviceCode: serviceCode,
        fundingSource: fundingSource,
        metadata: metadata,
      );
    } else {
      await _quoteNotifier.startQuote(
        amount,
        merchantId,
        serviceCode: serviceCode,
        fundingSource: fundingSource,
        metadata: metadata,
      );
    }
  }

  /// Transaction continuation (Delegates to CardFlow or other executions).
  Future<void> confirmConsent({String? duitNowProxyId}) async {
    if (!_mounted || state.quote == null) return;

    // AML Check: For Cash >= 3000, trigger MyKad Scan
    if (state.fundingSource == FundingSource.CASH && 
        (state.amount ?? Decimal.zero) >= Decimal.fromInt(3000) && 
        state.status != TransactionStatus.waitingMyKadScan &&
        state.metadata?['myKadReference'] == null) {
      state = state.copyWith(status: TransactionStatus.waitingMyKadScan);
      return;
    }

    // Support legacy BDD test harness parameter
    if (duitNowProxyId != null) {
      final updatedMetadata = Map<String, String>.from(state.metadata?.cast<String, String>() ?? {});
      updatedMetadata['duitNowProxyId'] = duitNowProxyId;
      state = state.copyWith(metadata: updatedMetadata);
    }

    if (state.fundingSource == FundingSource.CARD_EMV) {
      await _cardFlowNotifier.startCardFlow(state);
    } else if (state.fundingSource == FundingSource.MYKAD_BIOMETRIC) {
      await _executeMyKadBiometricFlow();
    } else if (state.serviceCode == 'DUITNOW_QR') {
      await _duitNowFlowNotifier.executeDuitNowQrFlow(state);
    } else if (state.serviceCode?.contains('DUITNOW') == true) {
       await _duitNowFlowNotifier.executeDuitNowTransfer(state);
    } else if (state.serviceCode == 'BILL_PAYMENT' || state.serviceCode == 'JOMPAY') {
       await _billerFlowNotifier.executeBillerPayment(state);
    } else {
      await _executeStandardWorkflow();
    }
  }

  Future<void> _executeMyKadBiometricFlow() async {
    if (!_mounted || state.quote == null) return;
    
    state = state.copyWith(status: TransactionStatus.waitingMyKadScan);
    try {
      final myKadData = await myKadScanner.scanMyKad();
      if (myKadData != null && _mounted) {
        final updatedMetadata = Map<String, String>.from(state.metadata?.cast<String, String>() ?? {});
        updatedMetadata['myKadReference'] = myKadData.icNumber;
        updatedMetadata['myKadName'] = myKadData.fullName;
        
        state = state.copyWith(
          status: TransactionStatus.processing,
          metadata: updatedMetadata,
        );

        final agentId = ref.read(authProvider).user?.agentId ?? 'AGENT-123';
        final result = await repository.executeTransaction(TransactionExecutionRequest(
          quoteId: state.quote!.quoteId,
          fundingSource: FundingSource.MYKAD_BIOMETRIC,
          serviceCode: state.serviceCode,
          amount: state.amount,
          metadata: updatedMetadata,
        ), agentId, idempotencyKey: state.idempotencyKey);

        if (_mounted) {
          if (result.status == 'SUCCESS') {
            state = state.copyWith(status: TransactionStatus.success, result: result);
            await floatNotifier.fetchLatestBalance();
          } else {
            state = state.copyWith(
              status: TransactionStatus.failed, 
              error: result.errorMessage ?? 'Transaction failed'
            );
          }
        }
      } else if (_mounted) {
        state = state.copyWith(status: TransactionStatus.failed, error: 'MyKad/Biometric scan failed or cancelled');
      }
    } catch (e) {
      if (_mounted) {
        state = state.copyWith(status: TransactionStatus.failed, error: e.toString());
      }
    }
  }
  
  /// Legacy delegate for JomPay execution
  Future<void> jomPay(
    String billerCode,
    String ref1,
    String? ref2,
    Decimal amount,
    String agentId,
  ) async {
    await startTransaction(
      amount,
      agentId,
      serviceCode: 'JOMPAY',
      fundingSource: FundingSource.CASH,
      metadata: {
        'billerCode': billerCode,
        'ref1': ref1,
        if (ref2 != null) 'ref2': ref2,
      },
    );
  }

  /// Legacy delegate for Balance Inquiry
  Future<void> balanceInquiry(String agentId) async {
    await _cardFlowNotifier.balanceInquiry(agentId);
  }

  Future<void> _executeStandardWorkflow() async {
    if (!_mounted || state.quote == null) return;
    try {
      final agentId = ref.read(authProvider).user?.agentId ?? 'AGENT-123';
      state = state.copyWith(status: TransactionStatus.processing);
      
      final result = await repository.executeTransaction(TransactionExecutionRequest(
        quoteId: state.quote!.quoteId,
        fundingSource: state.fundingSource!,
        serviceCode: state.serviceCode,
        amount: state.amount,
        metadata: state.metadata?.cast<String, String>(),
      ), agentId, idempotencyKey: state.idempotencyKey);

      if (_mounted) {
        if (result.status == 'SUCCESS') {
          state = state.copyWith(status: TransactionStatus.success, result: result);
          await floatNotifier.fetchLatestBalance();
        } else if (result.status == 'PENDING') {
          state = state.copyWith(status: TransactionStatus.processing, result: result);
        } else {
          state = state.copyWith(
            status: TransactionStatus.failed, 
            error: result.errorMessage ?? 'Transaction failed with status: ${result.status}'
          );
        }
      }
    } catch (e) {
      if (_mounted) {
        state = state.copyWith(status: TransactionStatus.failed, error: e.toString());
      }
    }
  }

  Future<void> startDuitNowPolling(String transactionId) async {
    await _duitNowFlowNotifier.startDuitNowPolling(transactionId);
  }
  
  Future<void> completeMyKadScan() async {
    if (!_mounted) return;
    state = state.copyWith(status: TransactionStatus.processing);
    try {
      final myKadData = await myKadScanner.scanMyKad();
      if (myKadData != null && _mounted) {
        final updatedMetadata = Map<String, dynamic>.from(state.metadata ?? {});
        updatedMetadata['myKadReference'] = myKadData.icNumber;
        updatedMetadata['myKadName'] = myKadData.fullName;
        
        state = state.copyWith(
          status: TransactionStatus.waitingConsent,
          metadata: updatedMetadata,
        );
      } else if (_mounted) {
        state = state.copyWith(status: TransactionStatus.failed, error: 'MyKad scan failed');
      }
    } catch (e) {
      if (_mounted) {
        state = state.copyWith(status: TransactionStatus.failed, error: e.toString());
      }
    }
  }

  String getPollingStatusLabel() {
    switch (state.status) {
      case TransactionStatus.processingBiller:
        return 'Confirming with Biller...';
      case TransactionStatus.processingDuitNow:
        return 'Polling DuitNow Status...';
      case TransactionStatus.waitingMyKadScan:
        return 'Waiting for MyKad Biometric Scan...';
      default:
        return 'Processing Transaction...';
    }
  }

  Future<void> recordMyKadScan(String icNumber, String name) async {
    if (!_mounted) return;
    final updatedMetadata = Map<String, String>.from(state.metadata?.cast<String, String>() ?? {});
    updatedMetadata['myKadReference'] = icNumber;
    updatedMetadata['myKadName'] = name;
    
    state = state.copyWith(
      status: TransactionStatus.waitingConsent,
      metadata: updatedMetadata,
    );
  }

  void debugSetState(TransactionState newState) {
    state = newState;
  }

  void reset() {
    state = TransactionState(status: TransactionStatus.idle);
    _quoteNotifier.reset();
    _cardFlowNotifier.reset();
    _duitNowFlowNotifier.reset();
    _billerFlowNotifier.reset();
    _proxyDepositNotifier.reset();
  }

  @override
  void dispose() {
    _mounted = false;
    _quoteNotifier.dispose();
    _cardFlowNotifier.dispose();
    _duitNowFlowNotifier.dispose();
    _billerFlowNotifier.dispose();
    _proxyDepositNotifier.dispose();
    super.dispose();
  }
}

// --- Provider ---
final transactionProvider = StateNotifierProvider<TransactionNotifier, TransactionState>((ref) {
  final repository = ref.watch(transactionRepositoryProvider);
  final cardReader = ref.watch(cardReaderProvider);
  final pinPad = ref.watch(pinPadProvider);
  final floatNotifier = ref.watch(floatProvider.notifier);
  final reversalService = ref.watch(reversalServiceProvider);
  final myKadScanner = ref.watch(myKadScannerProvider);
  final complianceNotifier = ref.watch(complianceProvider.notifier);
  final eodTimerService = ref.watch(eodTimerServiceProvider.notifier);
  final geolocator = ref.watch(geolocatorProvider);
  
  return TransactionNotifier(
    ref: ref,
    repository: repository,
    cardReader: cardReader,
    pinPad: pinPad,
    floatNotifier: floatNotifier,
    reversalService: reversalService,
    myKadScanner: myKadScanner,
    complianceNotifier: complianceNotifier,
    eodTimerService: eodTimerService,
    geolocator: geolocator,
  );
});
