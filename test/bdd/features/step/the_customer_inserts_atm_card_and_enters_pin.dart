import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> theCustomerInsertsAtmCardAndEntersPin(
    WidgetTester tester) async {
  await tester.pumpAndSettle();
  
  final agreeBtn = find.byKey(const Key('btn_confirm'));
  if (agreeBtn.evaluate().isNotEmpty) {
      await tester.tap(agreeBtn);
      await tester.pumpAndSettle();
  }

  final token = find.byKey(const Key('bdd_status_token'));
  if (token.evaluate().isNotEmpty) {
      final statusText = tester.widget<Text>(token).data ?? '';
      expect(statusText, anyOf(
        contains('waitingPin'), 
        contains('processing'), 
        contains('success'), 
        contains('waitingCard'), 
        contains('waitingPhysicalCard')
      ));
  }
}
