import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:decimal/decimal.dart';
import '../../bdd_test_helper.dart';

Future<void> theBillerInquiryReturnsBillerroutingonUs(
    WidgetTester tester) async {
  // Setup mock for ON_US
  mockTransactionRepository.getQuoteStub = (req) async {
    return TransactionQuoteResponse(
      amount: req.amount,
      fee: Decimal.parse('0.00'),
      commission: Decimal.parse('0.20'),
      total: req.amount,
      quoteId: 'JOMPAY_ONUS_789',
    );
  };

  final valBtn = find.text('VALIDATE');
  if (valBtn.evaluate().isNotEmpty) {
    await tester.tap(valBtn);
    await tester.pumpAndSettle();
  }
}
