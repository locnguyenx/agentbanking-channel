import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: the customer inserts ATM card and enters their PIN on the hardware PIN pad
Future<void> theCustomerInsertsAtmCardAndEntersTheirPinOnTheHardwarePinPad(
    WidgetTester tester) async {
  await tester.pumpAndSettle();
  
  // If on the quote summary screen, tap AGREE to progress to card entry
  final agreeBtn = find.byKey(const Key('btn_confirm'));
  if (agreeBtn.evaluate().isNotEmpty) {
      await tester.tap(agreeBtn);
      await tester.pumpAndSettle();
  }

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
