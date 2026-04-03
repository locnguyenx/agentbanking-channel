import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> theCustomerConfirmsTheWithdrawalAmountOnscreen(
    WidgetTester tester) async {
  await tester.pumpAndSettle();
  // The confirmation screening shows "Confirm Details" header or "AGREE" button
  expect(find.textContaining('Confirm Details'), findsOneWidget);
  
  final agreeBtn = find.byKey(const Key('btn_confirm'));
  if (agreeBtn.evaluate().isNotEmpty) {
      await tester.tap(agreeBtn);
      await tester.pumpAndSettle();
  }
}
