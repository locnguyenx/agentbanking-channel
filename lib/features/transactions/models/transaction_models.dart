/// Models for the Fee Pricing Engine and Transaction Execution
/// Mapped to BDD Scenario S3.1

class TransactionQuoteRequest {
  final String serviceCode;
  final double amount;
  final String agentId;

  TransactionQuoteRequest({
    required this.serviceCode,
    required this.amount,
    required this.agentId,
  });

  Map<String, dynamic> toJson() => {
    'serviceCode': serviceCode,
    'amount': amount,
    'agentId': agentId,
  };
}

class TransactionQuoteResponse {
  final double amount;
  final double fee;
  final double commission;
  final double total;
  final String quoteId;

  TransactionQuoteResponse({
    required this.amount,
    required this.fee,
    required this.commission,
    required this.total,
    required this.quoteId,
  });

  factory TransactionQuoteResponse.fromJson(Map<String, dynamic> json) =>
      TransactionQuoteResponse(
        amount: json['amount'].toDouble(),
        fee: json['fee'].toDouble(),
        commission: json['commission'].toDouble(),
        total: json['total'].toDouble(),
        quoteId: json['quoteId'],
      );
}

class TransactionExecutionRequest {
  final String quoteId;
  final String pinBlock;
  final String cardToken;

  TransactionExecutionRequest({
    required this.quoteId,
    required this.pinBlock,
    required this.cardToken,
  });

  Map<String, dynamic> toJson() => {
    'quoteId': quoteId,
    'pinBlock': pinBlock,
    'cardToken': cardToken,
  };
}

class TransactionExecutionResponse {
  final String status; // SUCCESS, FAILED
  final String referenceId;
  final String? errorMessage;

  TransactionExecutionResponse({
    required this.status,
    required this.referenceId,
    this.errorMessage,
  });

  factory TransactionExecutionResponse.fromJson(Map<String, dynamic> json) =>
      TransactionExecutionResponse(
        status: json['status'],
        referenceId: json['referenceId'],
        errorMessage: json['errorMessage'],
      );
}
