import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:decimal/decimal.dart';
import 'package:geolocator/geolocator.dart';

import 'package:agentbanking_channel/features/hardware/hardware_interfaces.dart';
import 'package:agentbanking_channel/features/hardware/hardware_providers.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_state.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_guards.dart';
import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';
import 'package:agentbanking_channel/features/auth/providers/auth_provider.dart';

/// Handles Cash Deposit via ProxyEnquiry + MyKad biometric scan:
///   quoting (ProxyEnquiry) → waitingConsent (Confirm Account) →
///   waitingMyKadScan (for amounts > RM 3,000)
///
/// Deps: TransactionRepository, IMyKadScanner
class ProxyDepositNotifier extends StateNotifier<TransactionState> with TransactionGuardMixin {
  @override
  final Ref ref;
  final TransactionRepository repository;
  final IMyKadScanner myKadScanner;
  @override
  final GeolocatorPlatform geolocator;
  final Duration pollingInterval;

  bool _mounted = true;
  bool _isPolling = false;
  Timer? _pollingTimer;
  Completer<void>? _pollingCompleter;

  ProxyDepositNotifier({
    required this.ref,
    required this.repository,
    required this.myKadScanner,
    required this.geolocator,
    this.pollingInterval = Duration.zero,
  }) : super(TransactionState(status: TransactionStatus.idle));

  /// Execute the ProxyEnquiry workflow for cash deposits.
  Future<void> executeProxyEnquiry({
    required Decimal amount,
    required String merchantId,
    Map<String, String>? metadata,
  }) async {
    if (!_mounted) return;
    
    final guardError = await performGuards(
      amount: amount,
      serviceCode: 'CASH_DEPOSIT',
      fundingSource: FundingSource.CASH,
      metadata: metadata,
    );
    if (guardError != null) {
      state = state.copyWith(status: TransactionStatus.failed, error: guardError);
      return;
    }

    final idempotencyKey = Uuid().v4();
    state = TransactionState(
      status: TransactionStatus.quoting, // Transition to quoting first
      amount: amount,
      serviceCode: 'CASH_DEPOSIT',
      fundingSource: FundingSource.CASH,
      metadata: metadata,
      idempotencyKey: idempotencyKey,
    );

    state = state.copyWith(status: TransactionStatus.processing);
    _isPolling = true;
    int retries = 0;

    while (_isPolling && _mounted && retries < 3) {
      try {
        final accountName = await repository.performProxyEnquiry(
          metadata?['identifier'] ?? '',
          'MOBILE',
        );
        
        if (!_mounted) return;
        
        final response = {
          'accountName': accountName,
          'accountNumber': metadata?['destinationAccount'] ?? 'UNKNOWN',
        };
        
        if (!_mounted) return;
        
        // Success: Transition to waitingConsent with the returned quote info
        final quote = TransactionQuoteResponse(
          quoteId: 'PQ_${Uuid().v4().substring(0, 8)}',
          amount: amount,
          fee: Decimal.zero,
          commission: Decimal.zero,
          total: amount,
        );
        
        final updatedMetadata = Map<String, dynamic>.from(state.metadata ?? {});
        updatedMetadata['accountName'] = response['accountName'];
        updatedMetadata['customerName'] = response['accountName']; // Add this for UI
        updatedMetadata['accountNumber'] = response['accountNumber'];
        
        state = state.copyWith(
          status: TransactionStatus.waitingConsent,
          quote: quote,
          metadata: updatedMetadata,
        );
        _isPolling = false;
        return;
      } catch (e) {
        retries++;
        if (retries >= 3) {
          if (_mounted) {
            state = state.copyWith(status: TransactionStatus.failed, error: e.toString());
          }
          break;
        }
        
        final backoffDelay = Duration(milliseconds: 500 * retries);
        _pollingCompleter = Completer<void>();
        _pollingTimer = Timer(backoffDelay, () {
          if (_pollingCompleter != null && !_pollingCompleter!.isCompleted) {
            _pollingCompleter!.complete();
          }
        });
        await _pollingCompleter!.future;
        _pollingTimer = null;
      }
    }
  }


  void reset() {
    _isPolling = false;
    state = TransactionState(status: TransactionStatus.idle);
  }

  @override
  void dispose() {
    _mounted = false;
    _isPolling = false;
    _pollingTimer?.cancel();
    _pollingTimer = null;
    if (_pollingCompleter != null && !_pollingCompleter!.isCompleted) {
      _pollingCompleter!.complete();
    }
    _pollingCompleter = null;
    super.dispose();
  }
}

final proxyDepositNotifierProvider = StateNotifierProvider<ProxyDepositNotifier, TransactionState>((ref) {
  return ProxyDepositNotifier(
    ref: ref,
    repository: ref.watch(transactionRepositoryProvider),
    myKadScanner: ref.watch(myKadScannerProvider),
    geolocator: GeolocatorPlatform.instance,
  );
});
