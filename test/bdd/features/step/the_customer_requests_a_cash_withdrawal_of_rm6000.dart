import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> theCustomerRequestsACashWithdrawalOfRm6000(WidgetTester tester) async {
  await tester.pumpAndSettle();
  final withdrawalBtn = find.byKey(const Key('btn_withdrawal'));
  expect(withdrawalBtn, findsOneWidget);
  await tester.tap(withdrawalBtn);
  await tester.pumpAndSettle();

  // Just enter 6000, the next step in BDD taps the button
  await tester.enterText(find.byKey(const Key('field_amount')), '6000');
  await tester.pumpAndSettle();
}
