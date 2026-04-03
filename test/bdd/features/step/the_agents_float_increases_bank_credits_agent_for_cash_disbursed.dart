import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> theAgentsFloatIncreasesBankCreditsAgentForCashDisbursed(
    WidgetTester tester) async {
  await tester.pumpAndSettle();
  // Success check for withdrawal/float increase
  expect(find.textContaining('Success'), findsOneWidget);
}
