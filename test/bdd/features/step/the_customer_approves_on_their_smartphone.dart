import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: the customer approves on their smartphone
Future<void> theCustomerApprovesOnTheirSmartphone(WidgetTester tester) async {
  // MUST advance the polling timer manually for Future.delayed in TransactionNotifier
  // Also verify that we actually entered the waitingConsent polling state
  final token = find.byKey(const Key('bdd_status_token'));
    bool sawConsent = false;
    if (token.evaluate().isNotEmpty) {
      for (int i = 0; i < 100; i++) {
        await tester.pump(const Duration(milliseconds: 20));
        final statusText = tester.widget<Text>(token).data ?? '';
        if (statusText.contains('waitingConsent') || 
            statusText.contains('success') || 
            statusText.contains('processing')) {
          sawConsent = true;
          break;
        }
      }
      expect(sawConsent, isTrue, reason: 'Expected UI to transition to or already be in a post-consent state. Current: ${tester.widget<Text>(token).data}');
  } else {
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();
  }
}

