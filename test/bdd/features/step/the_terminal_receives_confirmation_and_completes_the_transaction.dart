import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: the terminal receives confirmation and completes the transaction
Future<void> theTerminalReceivesConfirmationAndCompletesTheTransaction(
    WidgetTester tester) async {
  // DuitNow polling loop (TransactionNotifier.startDuitNowPolling) starts immediately now
  // We need to pump enough times to let it reach success.
  bool successFound = false;
  for (int i = 0; i < 40; i++) {
    // Advance time more aggressively (500ms * 12 = 6s, more than enough for a 5s loop)
    await tester.pump(const Duration(milliseconds: 500));
    final statusToken = find.byKey(const Key('bdd_status_token'));
    if (statusToken.evaluate().isNotEmpty) {
      final statusData = tester.widget<Text>(statusToken).data ?? '';
      if (statusData.contains('success')) {
        successFound = true;
        break;
      }
    }
  }
  
  if (!successFound) {
    // Last ditch effort
    await tester.pumpAndSettle(const Duration(seconds: 2));
  }
  
  final statusToken = find.byKey(const Key('bdd_status_token'));
  expect(statusToken, findsOneWidget);
  expect(tester.widget<Text>(statusToken).data, contains('success'));
}
