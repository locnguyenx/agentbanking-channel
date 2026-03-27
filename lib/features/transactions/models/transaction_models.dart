import 'package:decimal/decimal.dart';

/// Models for the Fee Pricing Engine and Transaction Execution
/// Mapped to BDD Scenario S3.1

enum FundingSource {
  CARD_EMV,        // EMV Chip + hardware DUKPT PIN (was CARD)
  CASH,            // Physical cash, agent confirms "Confirm Cash Collected"
  DUITNOW_MOBILE,  // DuitNow proxy: Mobile Number
  DUITNOW_MYKAD,  // DuitNow proxy: MyKad Number
  DUITNOW_BRN,    // DuitNow proxy: Business Registration Number
  MYKAD_BIOMETRIC, // MyKad chip + thumbprint (for MyKad withdrawal)
}

// BillerRouting: used for JomPAY to separate ON-US from OFF-US flow
enum BillerRouting { ON_US, OFF_US }

class TransactionQuoteRequest {
  final String serviceCode;
  final Decimal amount;
  final String agentId;
  final FundingSource fundingSource;
  final BillerRouting? billerRouting; // nullable — only for JomPAY

  TransactionQuoteRequest({
    required this.serviceCode,
    required this.amount,
    required this.agentId,
    required this.fundingSource,
    this.billerRouting,
  });

  Map<String, dynamic> toJson() => {
    'serviceCode': serviceCode,
    'amount': amount.toString(),
    'agentId': agentId,
    'fundingSource': fundingSource.name,
    if (billerRouting != null) 'billerRouting': billerRouting!.name,
  };
}

class TransactionQuoteResponse {
  final Decimal amount;
  final Decimal fee;
  final Decimal commission;
  final Decimal total;
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
        amount: Decimal.parse(json['amount'].toString()),
        fee: Decimal.parse(json['fee'].toString()),
        commission: Decimal.parse(json['commission'].toString()),
        total: Decimal.parse(json['total'].toString()),
        quoteId: json['quoteId'],
      );
}

class TransactionExecutionRequest {
  final String quoteId;
  final FundingSource fundingSource;
  final String? pinBlock;
  final String? cardToken;
  final String? duitNowProxyId;

  TransactionExecutionRequest({
    required this.quoteId,
    required this.fundingSource,
    this.pinBlock,
    this.cardToken,
    this.duitNowProxyId,
  });

  Map<String, dynamic> toJson() => {
    'quoteId': quoteId,
    'fundingSource': fundingSource.name,
    'pinBlock': pinBlock,
    'cardToken': cardToken,
    'duitNowProxyId': duitNowProxyId,
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
