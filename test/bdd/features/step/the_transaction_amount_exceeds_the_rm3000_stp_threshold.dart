import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: the transaction amount exceeds the RM 3,000 STP threshold
Future<void> theTransactionAmountExceedsTheRm3000StpThreshold(WidgetTester tester) async {
  // 1. Tap GET QUOTE (in idle)
  await tester.tap(find.byKey(const Key('btn_main_action')));
  await tester.pumpAndSettle();

  // 2. Wait for waitingConsent
  int count = 0;
  String lastStatus = '';
  while (count < 20) {
    await tester.pump(const Duration(milliseconds: 100));
    final statusToken = find.byKey(const Key('bdd_status_token'));
    if (statusToken.evaluate().isNotEmpty) {
       lastStatus = tester.widget<Text>(statusToken).data ?? '';
       if (lastStatus.contains('waitingConsent')) break;
    }
    count++;
  }
  expect(lastStatus, contains('waitingConsent'));

  // 3. Tap CONFIRM (key was btn_confirm in waitingConsent)
  await tester.tap(find.byKey(const Key('btn_confirm')));
  await tester.pumpAndSettle();

  // 4. Wait for waitingMyKadScan
  count = 0;
  while (count < 20) {
    await tester.pump(const Duration(milliseconds: 100));
    final statusToken = find.byKey(const Key('bdd_status_token'));
    if (statusToken.evaluate().isNotEmpty) {
       lastStatus = tester.widget<Text>(statusToken).data ?? '';
       if (lastStatus.contains('waitingMyKadScan')) break;
    }
    count++;
  }

  expect(lastStatus, contains('waitingMyKadScan'), reason: 'Expected waitingMyKadScan but got "$lastStatus"');
}
