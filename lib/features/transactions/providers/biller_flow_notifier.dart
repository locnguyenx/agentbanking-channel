import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:geolocator/geolocator.dart';
import 'package:decimal/decimal.dart';
import 'package:agentbanking_channel/core/network/geolocator_provider.dart';

import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_state.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_guards.dart';
import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';
import 'package:agentbanking_channel/features/settlement/providers/float_provider.dart';
import 'package:agentbanking_channel/features/auth/providers/auth_provider.dart';

/// Handles biller payment flows (bill pay, JomPay):
///   processing → processingBiller (polling) → success/failed
///
/// Deps: TransactionRepository, FloatNotifier
class BillerFlowNotifier extends StateNotifier<TransactionState> with TransactionGuardMixin {
  @override
  final Ref ref;
  final TransactionRepository repository;
  final FloatNotifier floatNotifier;
  @override
  final GeolocatorPlatform geolocator;
  final Duration pollingInterval;

  bool _mounted = true;
  bool _isPolling = false;
  Timer? _pollingTimer;
  Completer<void>? _pollingCompleter;

  BillerFlowNotifier({
    required this.ref,
    required this.repository,
    required this.floatNotifier,
    required this.geolocator,
    this.pollingInterval = Duration.zero,
  }) : super(TransactionState(status: TransactionStatus.idle));

  /// Execute the biller quote workflow (bill payment / JomPay).
  Future<void> executeBillerWorkflow({
    required Decimal amount,
    required String merchantId,
    required String serviceCode,
    required FundingSource fundingSource,
    Map<String, String>? metadata,
  }) async {
    if (!_mounted) return;

    final guardError = await performGuards(
      amount: amount,
      serviceCode: serviceCode,
      fundingSource: fundingSource,
      metadata: metadata,
    );
    if (guardError != null) {
      state = state.copyWith(status: TransactionStatus.failed, error: guardError);
      return;
    }
    
    final idempotencyKey = Uuid().v4();
    state = TransactionState(
      status: TransactionStatus.quoting,
      amount: amount,
      serviceCode: serviceCode,
      fundingSource: fundingSource,
      metadata: metadata,
      idempotencyKey: idempotencyKey,
    );

    state = state.copyWith(status: TransactionStatus.processing);
    try {
      final quote = await repository.getQuote(TransactionQuoteRequest(
        serviceCode: serviceCode,
        amount: amount,
        agentId: merchantId,
        fundingSource: fundingSource,
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

  /// Execute the biller payment and start polling.
  Future<void> executeBillerPayment(TransactionState quotedState) async {
    if (!_mounted) return;
    state = quotedState.copyWith(status: TransactionStatus.processing);
    try {
      final agentId = ref.read(authProvider).user?.agentId ?? 'AGENT-123';
      final result = await repository.executeTransaction(TransactionExecutionRequest(
        quoteId: state.quote!.quoteId,
        fundingSource: state.fundingSource!,
        serviceCode: state.serviceCode,
        amount: state.amount,
        metadata: state.metadata?.cast<String, String>(),
      ), agentId, idempotencyKey: state.idempotencyKey);

      if (!_mounted) return;

      if (result.status == 'SUCCESS') {
        state = state.copyWith(status: TransactionStatus.success, result: result);
        await floatNotifier.fetchLatestBalance();
      } else if (result.status == 'PENDING') {
        // Update state with execution result for reference ID
        state = state.copyWith(result: result);
        await startBillerPolling(result.referenceId);
      } else {
        state = state.copyWith(
          status: TransactionStatus.failed, 
          error: result.errorMessage ?? 'Transaction failed with status: ${result.status}'
        );
      }
    } catch (e) {
      if (_mounted) {
        state = state.copyWith(status: TransactionStatus.failed, error: e.toString());
      }
    }
  }

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
  final geolocator = ref.watch(geolocatorProvider);
  return BillerFlowNotifier(
    ref: ref,
    repository: ref.watch(transactionRepositoryProvider),
    floatNotifier: ref.watch(floatProvider.notifier),
    geolocator: geolocator,
  );
});
