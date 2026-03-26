import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/transaction_repository.dart';
import '../models/transaction_models.dart';
import '../../hardware/hardware_interfaces.dart';

enum TransactionStatus {
  idle,
  quoting,
  waitingConsent,
  waitingCard,
  waitingPin,
  processing,
  success,
  failed,
}

class TransactionState {
  final TransactionStatus status;
  final TransactionQuoteResponse? quote;
  final TransactionExecutionResponse? result;
  final String? error;

  TransactionState({
    required this.status,
    this.quote,
    this.result,
    this.error,
  });

  TransactionState copyWith({
    TransactionStatus? status,
    TransactionQuoteResponse? quote,
    TransactionExecutionResponse? result,
    String? error,
  }) {
    return TransactionState(
      status: status ?? this.status,
      quote: quote ?? this.quote,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }
}

class TransactionNotifier extends StateNotifier<TransactionState> {
  final TransactionRepository repository;
  final ICardReader cardReader;
  final IPinPad pinPad;

  TransactionNotifier({
    required this.repository,
    required this.cardReader,
    required this.pinPad,
  }) : super(TransactionState(status: TransactionStatus.idle));

  Future<void> startTransaction(double amount, String agentId) async {
    state = state.copyWith(status: TransactionStatus.quoting, error: null);
    try {
      final quote = await repository.getQuote(TransactionQuoteRequest(
        amount: amount,
        serviceCode: 'CASH_WDL',
        agentId: agentId,
      ));
      state = state.copyWith(status: TransactionStatus.waitingConsent, quote: quote);
    } catch (e) {
      state = state.copyWith(status: TransactionStatus.failed, error: e.toString());
    }
  }

  Future<void> confirmConsent() async {
    if (state.quote == null) return;
    
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
    final result = await repository.executeTransaction(TransactionExecutionRequest(
      quoteId: state.quote!.quoteId,
      pinBlock: pinBlock,
      cardToken: cardData.cardToken,
    ));

    if (result.status == 'SUCCESS') {
      state = state.copyWith(status: TransactionStatus.success, result: result);
    } else {
      state = state.copyWith(status: TransactionStatus.failed, error: result.errorMessage);
    }
  }

  void reset() {
    state = TransactionState(status: TransactionStatus.idle);
  }
}
