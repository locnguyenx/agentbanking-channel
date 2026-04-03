import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: the agent attempts to log in
Future<void> theAgentAttemptsToLogIn(WidgetTester tester) async {
  // Find biometric button and tap it
  final bioButton = find.byIcon(Icons.fingerprint);
  expect(bioButton, findsOneWidget);
  await tester.tap(bioButton);
  await tester.pumpAndSettle();
}
