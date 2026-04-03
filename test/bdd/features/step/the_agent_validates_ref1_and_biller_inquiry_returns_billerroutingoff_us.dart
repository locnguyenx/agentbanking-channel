import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../helpers/bdd_step_utils.dart';

Future<void> theAgentValidatesRef1AndBillerInquiryReturnsBillerroutingoffUs(
    WidgetTester tester) async {
  await tester.pumpAndSettle();
  
  final billPayBtn = find.byKey(const Key('btn_bill_payment'));
  if (billPayBtn.evaluate().isNotEmpty) {
    await tester.tap(billPayBtn);
    await tester.pumpAndSettle();
  }

  await selectFundingSourceIfNeeded(tester);

  await tester.tap(find.text('Select Biller'));
  await tester.pumpAndSettle();
  await tester.tap(find.textContaining('JomPAY').last);
  await tester.pumpAndSettle();

  await tester.enterText(find.widgetWithText(TextFormField, 'Ref-1'), 'JOM-12345');
  await tester.enterText(find.widgetWithText(TextFormField, 'Amount'), '50.00');
  await tester.pumpAndSettle();
  
  final proceed = find.byKey(const Key('btn_main_action'));
  if (proceed.evaluate().isNotEmpty) {
    await tester.tap(proceed);
    await tester.pumpAndSettle();
  }
}
