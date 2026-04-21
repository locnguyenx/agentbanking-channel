import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:agentbanking_channel/features/hardware/hardware_interfaces.dart';
import 'package:agentbanking_channel/features/hardware/hardware_providers.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/transactions/providers/card_flow_mixin.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';
import 'package:agentbanking_channel/features/settlement/providers/float_provider.dart';
import 'package:agentbanking_channel/features/transactions/services/reversal_service.dart';
import 'package:agentbanking_channel/features/auth/providers/auth_provider.dart';

/// Handles card-based transaction flows:
///   waitingCard → waitingPin → processing → success/failed/reversalQueued
///
/// Deps: ICardReader, IPinPad, TransactionRepository, FloatNotifier, ReversalService
class CardFlowNotifier extends StateNotifier<TransactionState> with CardFlowMixin {
  final Ref ref;
  @override
  final ICardReader cardReader;
  @override
  final IPinPad pinPad;
  final TransactionRepository repository;
  final FloatNotifier floatNotifier;
  final ReversalService reversalService;
  final Duration cardTimerDelay;

  bool _mounted = true;
  Timer? _cardTimer;

  @override
  bool get isMounted => _mounted;

  CardFlowNotifier({
    required this.ref,
    required this.cardReader,
    required this.pinPad,
    required this.repository,
    required this.floatNotifier,
    required this.reversalService,
    this.cardTimerDelay = Duration.zero,
  }) : super(TransactionState(status: TransactionStatus.idle));

  /// Start the card flow from a quoted transaction state.
  Future<void> startCardFlow(TransactionState quotedState) async {
    if (!_mounted) return;
    state = quotedState.copyWith(status: TransactionStatus.waitingCard);

    _cardTimer?.cancel();
    if (cardTimerDelay == Duration.zero) {
      Future.microtask(() => processCard());
    } else if (cardTimerDelay.inDays < 1) {
      _cardTimer = Timer(cardTimerDelay, () => processCard());
    }
  }

  Future<void> processCard() async {
    if (!_mounted) return;

    final result = await captureCardAndPin(
      updateState: (status, {String? error}) {
        if (_mounted) {
          state = state.copyWith(status: status, error: error);
        }
      },
    );

    if (result == null || !_mounted) return;

    await _executeFinal(
      pinBlock: result.pinBlock,
      cardToken: result.cardToken,
      pan: result.pan,
    );
  }

  Future<void> _executeFinal({String? pinBlock, String? cardToken, String? pan}) async {
    if (!_mounted) return;
    state = state.copyWith(status: TransactionStatus.processing);
    final agentId = ref.read(authProvider).user?.agentId ?? 'AGENT-123';
    try {
      final txResult = await repository.executeTransaction(TransactionExecutionRequest(
        quoteId: state.quote!.quoteId,
        fundingSource: state.fundingSource!,
        pan: pan,
        pinBlock: pinBlock,
        cardToken: cardToken,
        serviceCode: state.serviceCode,
        amount: state.amount,
        metadata: state.metadata?.cast<String, String>() ??
            (state.metadata != null
                ? Map<String, String>.from(state.metadata!.map((k, v) => MapEntry(k, v.toString())))
                : null),
      ), agentId, idempotencyKey: state.idempotencyKey);

      if (!_mounted) return;
      if (txResult.status == 'SUCCESS') {
        await floatNotifier.fetchLatestBalance();
        if (_mounted) {
          state = state.copyWith(status: TransactionStatus.success, result: txResult);
        }
      } else if (txResult.status == 'PENDING') {
        // Biller polling is handled by BillerFlowNotifier
        state = state.copyWith(status: TransactionStatus.processingBiller, result: txResult);
      } else {
        state = state.copyWith(status: TransactionStatus.failed, error: txResult.errorMessage);
      }
    } catch (e) {
      if (!_mounted) return;
      if (e is DioException &&
          (e.type == DioExceptionType.receiveTimeout || e.type == DioExceptionType.connectionTimeout)) {
        await _queueReversal();
        if (_mounted) {
          state = state.copyWith(status: TransactionStatus.reversalQueued, error: 'Timeout - Reversal Queued');
        }
      } else {
        if (_mounted) {
          state = state.copyWith(status: TransactionStatus.failed, error: e.toString());
        }
      }
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

  /// Balance inquiry follows the card flow but uses a different repository method.
  Future<void> balanceInquiry(String merchantId) async {
    if (!_mounted) return;
    state = TransactionState(
      status: TransactionStatus.waitingCard,
      amount: Decimal.zero,
      serviceCode: 'BALANCE_INQUIRY',
      fundingSource: FundingSource.CARD_EMV,
    );
    try {
      final cardData = await cardReader.readCard();
      if (!_mounted) return;
      if (cardData == null) {
        if (_mounted) state = state.copyWith(status: TransactionStatus.failed, error: 'Card Read Failed');
        return;
      }
      if (_mounted) state = state.copyWith(status: TransactionStatus.waitingPin);

      final pinBlock = await pinPad.capturePin();
      if (!_mounted) return;
      if (pinBlock == null) {
        if (_mounted) state = state.copyWith(status: TransactionStatus.failed, error: 'PIN Entry Cancelled');
        return;
      }
      if (_mounted) state = state.copyWith(status: TransactionStatus.processing);

      final txResult = await repository.balanceInquiry(
        TransactionExecutionRequest(
          quoteId: 'NO_QUOTE',
          fundingSource: FundingSource.CARD_EMV,
          pinBlock: pinBlock,
          cardToken: cardData.cardToken,
          serviceCode: 'BALANCE_INQUIRY',
        ),
        merchantId,
      );
      if (!_mounted) return;
      if (txResult.status == 'SUCCESS') {
        state = state.copyWith(status: TransactionStatus.success, result: txResult);
      } else {
        state = state.copyWith(status: TransactionStatus.failed, error: txResult.errorMessage);
      }
    } catch (e) {
      if (_mounted) {
        state = state.copyWith(status: TransactionStatus.failed, error: e.toString());
      }
    }
  }

  void reset() {
    state = TransactionState(status: TransactionStatus.idle);
  }

  @override
  void dispose() {
    _mounted = false;
    _cardTimer?.cancel();
    _cardTimer = null;
    super.dispose();
  }
}

final cardFlowNotifierProvider = StateNotifierProvider<CardFlowNotifier, TransactionState>((ref) {
  return CardFlowNotifier(
    ref: ref,
    cardReader: ref.watch(cardReaderProvider),
    pinPad: ref.watch(pinPadProvider),
    repository: ref.watch(transactionRepositoryProvider),
    floatNotifier: ref.watch(floatProvider.notifier),
    reversalService: ref.watch(reversalServiceProvider),
  );
});
