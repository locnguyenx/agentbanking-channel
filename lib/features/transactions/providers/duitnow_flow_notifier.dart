import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';
import 'package:agentbanking_channel/features/settlement/providers/float_provider.dart';
import 'package:agentbanking_channel/features/transactions/services/reversal_service.dart';
import 'package:agentbanking_channel/features/auth/providers/auth_provider.dart';

/// Handles DuitNow transfer and QR payment flows:
///   processing → waitingConsent (polling) → success/failed/reversalQueued
///
/// Deps: TransactionRepository, FloatNotifier, ReversalService
class DuitNowFlowNotifier extends StateNotifier<TransactionState> {
  final Ref ref;
  final TransactionRepository repository;
  final FloatNotifier floatNotifier;
  final ReversalService reversalService;
  final Duration pollingInterval;

  bool _mounted = true;
  bool _isPolling = false;
  Timer? _pollingTimer;
  Completer<void>? _pollingCompleter;

  DuitNowFlowNotifier({
    required this.ref,
    required this.repository,
    required this.floatNotifier,
    required this.reversalService,
    this.pollingInterval = Duration.zero,
  }) : super(TransactionState(status: TransactionStatus.idle));

  /// Execute a DuitNow proxy transfer (mobile/mykad/brn).
  Future<void> executeDuitNowTransfer(TransactionState quotedState) async {
    if (!_mounted) return;
    state = quotedState.copyWith(status: TransactionStatus.processing);
    try {
      final result = await repository.initiateDuitNow(
        quoteId: state.quote!.quoteId,
        proxyId: state.metadata?['duitNowProxyId'] ?? '',
        proxyType: _proxyTypeFromFundingSource(state.fundingSource!),
        amount: state.amount ?? Decimal.zero,
      );
      if (!_mounted) return;
      if (result.status == 'SUCCESS') {
        state = state.copyWith(status: TransactionStatus.success, result: result);
        await floatNotifier.fetchLatestBalance();
      } else if (result.status == 'PENDING') {
        state = state.copyWith(result: result);
        await startDuitNowPolling(result.referenceId);
      } else {
        state = state.copyWith(status: TransactionStatus.failed, error: result.errorMessage);
      }
    } catch (e) {
      if (_mounted) {
        state = state.copyWith(status: TransactionStatus.failed, error: e.toString());
      }
    }
  }

  /// Execute a DuitNow QR sale flow.
  Future<void> executeDuitNowQrFlow(TransactionState quotedState) async {
    if (!_mounted) return;
    state = quotedState.copyWith(status: TransactionStatus.processing);
    try {
      final agentId = ref.read(authProvider).user?.agentId ?? 'AGENT-123';
      final response = await repository.generateQrSale(state.amount!, agentId);
      if (!_mounted) return;
      final updatedMetadata = Map<String, dynamic>.from(state.metadata ?? {});
      updatedMetadata['qrPayload'] = response['qrPayload'];
      state = state.copyWith(status: TransactionStatus.displayingQr, metadata: updatedMetadata);
      await startDuitNowPolling(response['referenceId']!);
    } catch (e) {
      if (_mounted) {
        state = state.copyWith(status: TransactionStatus.failed, error: e.toString());
      }
    }
  }

  /// Poll for DuitNow payment confirmation.
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
          final result = TransactionExecutionResponse(
            status: 'SUCCESS',
            referenceId: response['transactionId'] ?? referenceId,
          );
          if (_mounted) {
            state = state.copyWith(status: TransactionStatus.success, result: result);
          }
          return;
        } else if (status == 'FAILED') {
          state = state.copyWith(status: TransactionStatus.failed, error: 'FAILED');
          return;
        }
      } catch (e) {
        // Continue polling on transient errors
      }

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
    await reversalService.queueReversal({
      'quoteId': state.quote?.quoteId,
      'amount': state.amount?.toString(),
      'serviceCode': state.serviceCode,
      'idempotencyKey': state.idempotencyKey,
    });
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

final duitNowFlowNotifierProvider = StateNotifierProvider<DuitNowFlowNotifier, TransactionState>((ref) {
  return DuitNowFlowNotifier(
    ref: ref,
    repository: ref.watch(transactionRepositoryProvider),
    floatNotifier: ref.watch(floatProvider.notifier),
    reversalService: ref.watch(reversalServiceProvider),
  );
});
