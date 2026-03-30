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
  final BillerRouting? billerRouting;

  TransactionQuoteRequest({
    required this.serviceCode,
    required this.amount,
    required this.agentId,
    required this.fundingSource,
    this.billerRouting,
  });
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
}

class TransactionExecutionRequest {
  final String quoteId;
  final FundingSource fundingSource;
  final String? pinBlock;
  final String? cardToken;
  final String? duitNowProxyId;
  final String? serviceCode;
  final Decimal? amount;
  final Map<String, String>? metadata;

  TransactionExecutionRequest({
    required this.quoteId,
    required this.fundingSource,
    this.pinBlock,
    this.cardToken,
    this.duitNowProxyId,
    this.serviceCode,
    this.amount,
    this.metadata,
  });
}

class TransactionExecutionResponse {
  final String status; // SUCCESS, FAILED
  final String referenceId;
  final String? errorMessage;
  final Decimal? balance;
  final String? currency;

  TransactionExecutionResponse({
    required this.status,
    required this.referenceId,
    this.errorMessage,
    this.balance,
    this.currency,
  });
}
