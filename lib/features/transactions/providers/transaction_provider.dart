import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/hardware/hardware_interfaces.dart';
import 'package:agentbanking_channel/features/hardware/mock_hardware_impl.dart';

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

  Future<void> startTransaction(double amount, String agentId, {String serviceCode = 'CASH_WDL'}) async {
    state = state.copyWith(status: TransactionStatus.quoting, error: null);
    try {
      final quote = await repository.getQuote(TransactionQuoteRequest(
        amount: amount,
        serviceCode: serviceCode,
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

final transactionRepositoryProvider = Provider<TransactionRepository>((ref) => TransactionRepository(Dio()));

final transactionProvider = StateNotifierProvider<TransactionNotifier, TransactionState>((ref) {
  final repository = ref.watch(transactionRepositoryProvider);
  return TransactionNotifier(
    repository: repository,
    cardReader: MockCardReader(),
    pinPad: MockPinPad(),
  );
});
