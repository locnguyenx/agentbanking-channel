import 'package:decimal/decimal.dart';

enum MerchantTransactionType { RETAIL_SALE, PIN_PURCHASE, CASHBACK_HYBRID }

class RetailSaleResponse {
  final Decimal floatCreditAmount; // amount minus MDR
  final Decimal mdrAmount;
  final String receiptReference;
  
  RetailSaleResponse({
    required this.floatCreditAmount, 
    required this.mdrAmount, 
    required this.receiptReference
  });

  factory RetailSaleResponse.fromJson(Map<String, dynamic> json) => RetailSaleResponse(
    floatCreditAmount: Decimal.parse((json['netToMerchant'] ?? json['floatCreditAmount']).toString()),
    mdrAmount: Decimal.parse(json['mdrAmount'].toString()),
    receiptReference: json['transactionId'] ?? json['receiptReference'] ?? '',
  );
}

class CashbackResponse {
  final Decimal purchaseAmount;
  final Decimal cashBackAmount;
  final String receiptReference;

  CashbackResponse({
    required this.purchaseAmount, 
    required this.cashBackAmount, 
    required this.receiptReference
  });

  factory CashbackResponse.fromJson(Map<String, dynamic> json) => CashbackResponse(
    purchaseAmount: Decimal.parse(json['purchaseAmount'].toString()),
    cashBackAmount: Decimal.parse(json['cashBackAmount'].toString()),
    receiptReference: json['receiptReference'],
  );
}

class PinPurchaseResponse {
  final String pinCode; // 16-digit
  final Decimal commissionEarned;
  final String receiptReference;

  PinPurchaseResponse({
    required this.pinCode, 
    required this.commissionEarned, 
    required this.receiptReference
  });

  factory PinPurchaseResponse.fromJson(Map<String, dynamic> json) => PinPurchaseResponse(
    pinCode: json['pinCode'],
    commissionEarned: Decimal.parse(json['commissionEarned'].toString()),
    receiptReference: json['receiptReference'],
  );
}
