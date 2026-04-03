import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../helpers/bdd_step_utils.dart';

Future<void> theAgentEntersTheCustomersCelcomPhoneNumberAndItIsValidated(
    WidgetTester tester) async {
  await tester.pumpAndSettle();
  
  final topUpBtn = find.byKey(const Key('btn_top_up'));
  if (topUpBtn.evaluate().isNotEmpty) {
      await tester.tap(topUpBtn);
      await tester.pumpAndSettle();
  }

  await selectFundingSourceIfNeeded(tester);

  await tester.tap(find.text('Select Provider'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('CELCOM').last);
  await tester.pumpAndSettle();

  await tester.enterText(find.widgetWithText(TextFormField, 'Phone Number'), '0191122334');
  await tester.enterText(find.widgetWithText(TextFormField, 'Amount'), '10.00');
  await tester.pumpAndSettle();
  
  await tester.tap(find.byKey(const Key('btn_main_action')));
  await tester.pumpAndSettle();
}
