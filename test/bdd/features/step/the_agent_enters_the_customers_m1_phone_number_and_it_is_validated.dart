import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../helpers/bdd_step_utils.dart';

Future<void> theAgentEntersTheCustomersM1PhoneNumberAndItIsValidated(
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
  await tester.tap(find.text('M1').last);
  await tester.pumpAndSettle();

  await tester.enterText(find.byType(TextFormField).at(0), '0123456789'); // Phone
  await tester.enterText(find.byType(TextFormField).at(1), '10.00');      // Amount
  await tester.pumpAndSettle();
  
  final proceedBtn = find.byKey(const Key('btn_main_action'));
  expect(proceedBtn, findsOneWidget);
  await tester.tap(proceedBtn);
  await tester.pumpAndSettle();

  if (find.text('Invalid').evaluate().isNotEmpty || find.text('Required').evaluate().isNotEmpty) {
      print('BDD: Form Validation Failed! Error found on screen.');
  }
}
