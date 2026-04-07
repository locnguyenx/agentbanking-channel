import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: the customer inserts their ATM card and enters their PIN on the hardware PIN pad
Future<void> theCustomerInsertsTheirAtmCardAndEntersTheirPinOnTheHardwarePinPad(
    WidgetTester tester) async {
  await tester.pumpAndSettle();
  
  // If on the quote summary screen, tap AGREE to progress to card entry
  final agreeBtn = find.byKey(const Key('btn_confirm'));
  debugPrint('DEBUG BDD HARDWARE: Searching for agreeBtn = ${agreeBtn.evaluate().isNotEmpty}');
  if (agreeBtn.evaluate().isNotEmpty) {
    debugPrint('DEBUG BDD HARDWARE: Tapping agreeBtn');
    await tester.tap(agreeBtn);
    await tester.pump();
  }

  // Wait for the UI to transition to telling the customer to insert their card
  bool sawCard = false;
  bool sawPin = false;
  
  for (int i = 0; i < 100; i++) { // wait up to 2 seconds
    await tester.pump(const Duration(milliseconds: 20));
    
    // Check internal state via hidden token because text-matching is fragile
    final statusToken = find.byKey(const Key('bdd_status_token'));
    if (statusToken.evaluate().isNotEmpty) {
      final textWidget = tester.widget<Text>(statusToken);
      final text = textWidget.data ?? '';
      debugPrint('DEBUG BDD HARDWARE: Loop $i token=${text}');
      if (text.contains('waitingCard')) {
        sawCard = true;
      }
      if (text.contains('waitingPin')) {
        sawPin = true;
      }
      if (text.contains('processing') || text.contains('success')) break;
    }
  }
  expect(sawCard, isTrue, reason: 'Expected UI to transition to waitingCard');
  expect(sawPin, isTrue, reason: 'Expected UI to transition to waitingPin');
}
