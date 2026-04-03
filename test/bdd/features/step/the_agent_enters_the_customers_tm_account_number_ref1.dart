import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../helpers/bdd_step_utils.dart';

Future<void> theAgentEntersTheCustomersTmAccountNumberRef1(
    WidgetTester tester) async {
  await tester.pumpAndSettle();
  
  final billPayBtn = find.byKey(const Key('btn_bill_payment'));
  expect(billPayBtn, findsOneWidget);
  await tester.tap(billPayBtn);
  await tester.pumpAndSettle();

  await selectFundingSourceIfNeeded(tester);

  await tester.tap(find.text('Select Biller'));
  await tester.pumpAndSettle();
  // Using partial match to Telekom Malaysia
  await tester.tap(find.textContaining('Telekom').last);
  await tester.pumpAndSettle();

  await tester.enterText(find.widgetWithText(TextFormField, 'Ref-1'), 'TM123456');
  await tester.enterText(find.widgetWithText(TextFormField, 'Amount'), '100.00');
  await tester.pumpAndSettle();
  
  await tester.tap(find.byKey(const Key('btn_main_action')));
  await tester.pumpAndSettle();
}
