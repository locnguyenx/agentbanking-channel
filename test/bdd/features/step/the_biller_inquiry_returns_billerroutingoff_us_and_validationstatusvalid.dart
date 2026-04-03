import 'package:flutter_test/flutter_test.dart';

/// Usage: the biller inquiry returns billerRouting=OFF_US and validationStatus=VALID
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:decimal/decimal.dart';
import '../../bdd_test_helper.dart';

Future<void> theBillerInquiryReturnsBillerroutingoffUsAndValidationstatusvalid(WidgetTester tester) async {
  // Set up mock return for JomPAY quote with OFF_US
  mockTransactionRepository.getQuoteStub = (req) async {
    return TransactionQuoteResponse(
      amount: req.amount,
      fee: Decimal.parse('1.00'),
      commission: Decimal.parse('0.50'),
      total: req.amount + Decimal.parse('1.00'),
      quoteId: 'JOMPAY_OFFUS_123',
    );
  };

  final proceedBtn = find.byKey(const Key('btn_main_action'));
  expect(proceedBtn, findsOneWidget, reason: 'PROCEED button should be visible on JomPayForm');
  await tester.tap(proceedBtn);
  await tester.pumpAndSettle();
}
