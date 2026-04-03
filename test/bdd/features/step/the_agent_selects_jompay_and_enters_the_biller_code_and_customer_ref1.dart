import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../helpers/bdd_step_utils.dart';

Future<void> theAgentSelectsJompayAndEntersTheBillerCodeAndCustomerRef1(
    WidgetTester tester) async {
  await tester.pumpAndSettle();
  
  final jompayBtn = find.byKey(const Key('btn_jompay'));
  if (jompayBtn.evaluate().isEmpty) {
      // Maybe already on page?
  } else {
      await tester.tap(jompayBtn);
      await tester.pumpAndSettle();
  }

  await selectFundingSourceIfNeeded(tester);

  await tester.enterText(find.widgetWithText(TextFormField, 'Biller Code'), '5454');
  await tester.enterText(find.widgetWithText(TextFormField, 'Ref-1'), '1234567890');
  await tester.enterText(find.widgetWithText(TextFormField, 'Amount'), '50.00');
  await tester.pumpAndSettle();
}
