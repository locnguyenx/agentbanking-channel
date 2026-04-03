import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: the agent authenticates using fingerprint biometrics
Future<void> theAgentAuthenticatesUsingFingerprintBiometrics(WidgetTester tester) async {
  // Find the biometric login button
  final bioButton = find.byIcon(Icons.fingerprint);
  expect(bioButton, findsOneWidget);
  await tester.tap(bioButton);
  await tester.pumpAndSettle();
}
