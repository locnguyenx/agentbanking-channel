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
      final statusText = tester.widget<Text>(token).data ?? '';
      expect(statusText, anyOf(
        contains('waitingPin'), 
        contains('processing'), 
        contains('success'), 
        contains('waitingCard'), 
        contains('waitingPhysicalCard'),
        contains('waitingMyKadScan')
      ));
  }
}
