import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import './the_biller_inquiry_confirms_the_account_and_outstanding_amount.dart';
import './the_agent_enters_the_customers_tm_account_number_ref1.dart';

Future<void> theTmBillerInquiryPasses(WidgetTester tester) async {
  await tester.pumpAndSettle();
  if (find.byKey(const Key('btn_bill_payment')).evaluate().isNotEmpty) {
    await theAgentEntersTheCustomersTmAccountNumberRef1(tester);
  }
  await theBillerInquiryConfirmsTheAccountAndOutstandingAmount(tester);
}
