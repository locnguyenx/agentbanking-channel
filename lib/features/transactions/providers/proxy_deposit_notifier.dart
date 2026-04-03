import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:agentbanking_channel/features/hardware/hardware_interfaces.dart';
import 'package:agentbanking_channel/features/hardware/hardware_providers.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';

/// Handles Cash Deposit via ProxyEnquiry + MyKad biometric scan:
///   processing → waitingConsent (after proxy lookup)
///   waitingMyKadScan (for amounts > RM 3,000)
///
/// Deps: TransactionRepository, IMyKadScanner
class ProxyDepositNotifier extends StateNotifier<TransactionState> {
  final TransactionRepository repository;
  final IMyKadScanner myKadScanner;
  final Duration pollingInterval;

  bool _mounted = true;
  bool _isPolling = true;
  Timer? _pollingTimer;
  Completer<void>? _pollingCompleter;

  ProxyDepositNotifier({
    required this.repository,
    required this.myKadScanner,
    this.pollingInterval = Duration.zero,
  }) : super(TransactionState(status: TransactionStatus.idle));

  /// Execute the ProxyEnquiry workflow for cash deposits.
  Future<void> executeProxyEnquiry(TransactionState quotedState) async {
    if (!_mounted) return;
    state = quotedState.copyWith(status: TransactionStatus.processing);
    _isPolling = true;
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

        final backoffDelay =
            (pollingInterval.inMilliseconds < 1000) ? pollingInterval : Duration(seconds: 1 << retries);
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

  /// Handle MyKad biometric scan for large cash deposits.
  Future<void> processMyKadScan() async {
    if (!_mounted) return;
    try {
      final myKadData = await myKadScanner.scanMyKad();
      if (!_mounted) return;
      if (myKadData == null) {
        state = state.copyWith(status: TransactionStatus.failed, error: 'MyKad Scan Cancelled');
        return;
      }
      final updatedMetadata = Map<String, dynamic>.from(state.metadata ?? {});
      updatedMetadata['myKadIcNumber'] = myKadData.icNumber;
      updatedMetadata['myKadFullName'] = myKadData.fullName;
      state = state.copyWith(
        status: TransactionStatus.waitingConsent,
        metadata: updatedMetadata,
      );
    } catch (e) {
      if (_mounted) {
        state = state.copyWith(status: TransactionStatus.failed, error: e.toString());
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
    repository: ref.watch(transactionRepositoryProvider),
    myKadScanner: ref.watch(myKadScannerProvider),
  );
});
