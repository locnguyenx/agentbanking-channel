import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';
import 'package:agentbanking_channel/features/settlement/providers/float_provider.dart';

/// Handles biller payment flows (bill pay, JomPay):
///   processing → processingBiller (polling) → success/failed
///
/// Deps: TransactionRepository, FloatNotifier
class BillerFlowNotifier extends StateNotifier<TransactionState> {
  final TransactionRepository repository;
  final FloatNotifier floatNotifier;
  final Duration pollingInterval;

  bool _mounted = true;
  bool _isPolling = false;
  Timer? _pollingTimer;
  Completer<void>? _pollingCompleter;

  BillerFlowNotifier({
    required this.repository,
    required this.floatNotifier,
    this.pollingInterval = Duration.zero,
  }) : super(TransactionState(status: TransactionStatus.idle));

  /// Execute the biller quote workflow (bill payment / JomPay).
  Future<void> executeBillerWorkflow(TransactionState quotedState) async {
    if (!_mounted) return;
    state = quotedState.copyWith(status: TransactionStatus.processing);
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

  /// Poll for biller transaction status.
  Future<void> startBillerPolling(String transactionId) async {
    if (!_mounted) return;
    _isPolling = true;
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
        } else if (status == 'FAILED') {
          state = state.copyWith(status: TransactionStatus.failed, error: 'BILLER_FAILED');
          break;
        }
      } catch (e) {
        // Continue polling on transient errors
      }
    }
    if (!isApproved && _mounted && state.status == TransactionStatus.processingBiller) {
      state = state.copyWith(status: TransactionStatus.failed, error: 'TIMEOUT');
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

final billerFlowNotifierProvider = StateNotifierProvider<BillerFlowNotifier, TransactionState>((ref) {
  return BillerFlowNotifier(
    repository: ref.watch(transactionRepositoryProvider),
    floatNotifier: ref.watch(floatProvider.notifier),
  );
});
