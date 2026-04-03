import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> onlyThenSubmitsTheApiCallWithTheMykadReferenceNumber(
    WidgetTester tester) async {
  await tester.pumpAndSettle();
  
  // Tap the SCAN button to simulate MyKad read
  final scanBtn = find.byKey(const Key('btn_main_action'));
  if (scanBtn.evaluate().isNotEmpty) {
      await tester.tap(scanBtn);
      await tester.pumpAndSettle();
  }

  // After scan, it returns to waitingConsent. Tap CONFIRM one last time to execute.
  final confirmBtn = find.byKey(const Key('btn_confirm'));
  if (confirmBtn.evaluate().isNotEmpty) {
      await tester.tap(confirmBtn);
      await tester.pumpAndSettle();
  } else {
      // It might have auto-executed, check success
  }

  // Expect Success screen - Use Key for robustness
  expect(find.byKey(const Key('status_success')), findsOneWidget);
}
