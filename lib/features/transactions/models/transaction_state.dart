import 'package:decimal/decimal.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';

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
