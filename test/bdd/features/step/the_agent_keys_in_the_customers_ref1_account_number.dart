import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: the agent keys in the customer's Ref-1 account number
Future<void> theAgentKeysInTheCustomersRef1AccountNumber(
    WidgetTester tester) async {
  // Ref-1 in JomPay is index 1
  final ref1Field = find.byType(TextField).at(1);
  await tester.enterText(ref1Field, '9999999999');
  await tester.pumpAndSettle();
}
