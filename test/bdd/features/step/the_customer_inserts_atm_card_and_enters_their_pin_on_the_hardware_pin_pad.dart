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
      // Small loop to wait for hardware states
      for (int i = 0; i < 5; i++) {
        final statusText = tester.widget<Text>(token).data ?? '';
        if (statusText.contains('waitingCard') || 
            statusText.contains('waitingPin') || 
            statusText.contains('processing') ||
            statusText.contains('success')) {
          break;
        }
        await tester.pump(const Duration(milliseconds: 500));
      }
  }
}
