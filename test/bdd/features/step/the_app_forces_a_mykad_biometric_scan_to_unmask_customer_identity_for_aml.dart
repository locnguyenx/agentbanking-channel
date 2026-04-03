import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: the app forces a MyKad biometric scan to unmask customer identity for AML
Future<void> theAppForcesAMykadBiometricScanToUnmaskCustomerIdentityForAml(
    WidgetTester tester) async {
  await tester.pumpAndSettle();
  // Check for waitingMyKadScan state via bdd_status_token
  final statusToken = find.byKey(const Key('bdd_status_token'));
  expect(statusToken, findsOneWidget);
  expect(tester.widget<Text>(statusToken).data, contains('waitingMyKadScan'));
  // Scenario: Deposit > RM 3,000
  // Verify state is waitingMyKadScan
  expect(find.textContaining('Status: waitingMyKadScan'), findsOneWidget);
}
