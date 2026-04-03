import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: the agent NEVER sees or has access to the customer's PIN
Future<void> theAgentNeverSeesOrHasAccessToTheCustomersPin(
    WidgetTester tester) async {
  // Verification: Hardware pin pad means no virtual keyboard/text field in UI
  expect(find.byType(TextField), findsNothing);
}
