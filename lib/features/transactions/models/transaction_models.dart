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
  DUITNOW_QR;     // NEW: DuitNow Dynamic QR (for Retail Sale)

  String get label {
    switch (this) {
      case CARD_EMV: return 'ATM Card';
      case CASH: return 'Cash';
      case DUITNOW_MOBILE: return 'DuitNow Mobile';
      case DUITNOW_MYKAD: return 'DuitNow MyKad';
      case DUITNOW_BRN: return 'DuitNow BRN';
      case MYKAD_BIOMETRIC: return 'MyKad Biometric';
      case DUITNOW_QR: return 'DuitNow QR';
    }
  }

  static List<FundingSource> allowedFor(String serviceCode) {
    switch (serviceCode) {
      case 'CASH_WITHDRAWAL':
        return [CARD_EMV, MYKAD_BIOMETRIC];
      case 'CASH_DEPOSIT':
      case 'BILL_PAYMENT':
      case 'PREPAID_TOPUP':
      case 'SARAWAK_PAY':
      case 'ESSP_PURCHASE':
      case 'JOMPAY':
        return [CASH, CARD_EMV, DUITNOW_MOBILE];
      case 'PIN_PURCHASE':
        return [CASH, CARD_EMV];
      case 'CASHLESS_PAYMENT':
        return [CARD_EMV, DUITNOW_QR];
      case 'DUITNOW_TRANSFER':
        return [DUITNOW_MOBILE, DUITNOW_MYKAD, DUITNOW_BRN];
      case 'BALANCE_INQUIRY':
        return [CARD_EMV];
      default:
        return [CASH, CARD_EMV];
    }
  }
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
  final String? pan; // ATM Card Number (no masking required)
  final String? pinBlock;
  final String? cardToken;
  final String? duitNowProxyId;
  final String? serviceCode;
  final Decimal? amount;
  final Map<String, String>? metadata;

  TransactionExecutionRequest({
    required this.quoteId,
    required this.fundingSource,
    this.pan,
    this.pinBlock,
    this.cardToken,
    this.duitNowProxyId,
    this.serviceCode,
    this.amount,
    this.metadata,
  });
}

class TransactionExecutionResponse {
  final String status; // SUCCESS, FAILED, PENDING
  final String referenceId;
  final String? errorMessage;
  final Decimal? balance;
  final String? currency;
  final String? qrPayload; // NEW: For DuitNow QR dynamic payload
  final Decimal? amount; // NEW: Amount for confirmation

  TransactionExecutionResponse({
    required this.status,
    required this.referenceId,
    this.errorMessage,
    this.balance,
    this.currency,
    this.qrPayload,
    this.amount,
  });
}
