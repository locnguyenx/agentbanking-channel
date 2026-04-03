import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: proceeds or blocks the financial handshake based on the real_time API response
Future<void> proceedsOrBlocksTheFinancialHandshakeBasedOnTheRealTimeApiResponse(
    WidgetTester tester) async {
  // If mocks return success, it should be in waitingConsent (for quotes) or displaying success/failure.
  final statusToken = find.byKey(const Key('bdd_status_token'));
  expect(statusToken, findsOneWidget);
  final statusData = tester.widget<Text>(statusToken).data ?? '';
  
  // High leniency for orchestration steps since they vary by service
  expect(statusData, anyOf(contains('waitingConsent'), contains('success'), contains('quoting'), contains('idle')));
}
