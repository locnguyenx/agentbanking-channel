import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> theCustomerInsertsTheirAtmCardAndEntersPinDukptEncrypted(
    WidgetTester tester) async {
  await tester.pumpAndSettle();
  
  // Ensure we transition from summary to card entry
  final agreeBtn = find.byKey(const Key('btn_confirm'));
  final agreeText = find.text('AGREE');
  
  if (agreeBtn.evaluate().isNotEmpty) {
      await tester.tap(agreeBtn);
      await tester.pumpAndSettle();
  } else if (agreeText.evaluate().isNotEmpty) {
      await tester.tap(agreeText);
      await tester.pumpAndSettle();
  }
  
  // Wait for the state to transition to WAITING_CARD or beyond
  await tester.pump(const Duration(milliseconds: 500));
  await tester.pumpAndSettle();
  
    final token = find.byKey(const Key('bdd_status_token'));
  if (token.evaluate().isNotEmpty) {
      bool sawCard = false;
      bool sawPin = false;
      for (int i = 0; i < 100; i++) {
        await tester.pump(const Duration(milliseconds: 20));
        final statusText = tester.widget<Text>(token).data ?? '';
        if (statusText.contains('waitingCard')) sawCard = true;
        if (statusText.contains('waitingPin')) sawPin = true;
        if (statusText.contains('processing') || statusText.contains('success')) break;
      }
      expect(sawCard, isTrue, reason: 'Expected UI to transition to waitingCard');
      expect(sawPin, isTrue, reason: 'Expected UI to transition to waitingPin');
  }
}
