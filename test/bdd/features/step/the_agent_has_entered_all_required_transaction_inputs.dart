import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> theAgentHasEnteredAllRequiredTransactionInputs(WidgetTester tester) async {
  await tester.pumpAndSettle();
  final withdrawalBtn = find.byKey(const Key('btn_withdrawal'));
  expect(withdrawalBtn, findsOneWidget);
  await tester.tap(withdrawalBtn);
  await tester.pumpAndSettle();

  final fields = find.byType(TextField);
  if (fields.evaluate().length > 1) {
    await tester.enterText(fields.at(0), '1234567890');
    await tester.enterText(fields.at(1), '100');
  } else {
    await tester.enterText(fields.at(0), '100');
  }
  await tester.pumpAndSettle();
}
