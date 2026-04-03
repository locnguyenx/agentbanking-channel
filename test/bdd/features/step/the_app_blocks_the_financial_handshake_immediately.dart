import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

/// Usage: the app blocks the financial handshake immediately
Future<void> theAppBlocksTheFinancialHandshakeImmediately(
    WidgetTester tester) async {
  final proceedBtn = find.byKey(const Key('btn_main_action'));
  await tester.tap(proceedBtn);
  await tester.pumpAndSettle();
  
  // Verify status is not moving to waitingConsent/waitingCard (i.e. stays idle or moves to failed if blocked by notifier)
  final statusToken = find.byKey(const Key('bdd_status_token'));
  expect(statusToken, findsOneWidget);
  final statusData = tester.widget<Text>(statusToken).data ?? '';
  expect(statusData, anyOf(contains('Status: idle'), contains('Status: failed')));
}
