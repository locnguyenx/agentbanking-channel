import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> theCustomerDepositsPhysicalCashOfRm3500(WidgetTester tester) async {
  await tester.pumpAndSettle();
  final depositBtn = find.byKey(const Key('btn_deposit'));
  expect(depositBtn, findsOneWidget);
  await tester.tap(depositBtn);
  await tester.pumpAndSettle();

  // Fill in account
  await tester.enterText(find.byKey(const Key('field_destination_account')), '1234567890');
  // Fill in amount
  await tester.enterText(find.byKey(const Key('field_amount')), '3500');
  await tester.pumpAndSettle();
}
