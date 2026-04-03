import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> theAgentSelectedTheBillPaymentFeature(WidgetTester tester) async {
  await tester.pumpAndSettle();
  final billBtn = find.byKey(const Key('btn_bill_payment'));
  expect(billBtn, findsOneWidget);
  await tester.tap(billBtn);
  await tester.pumpAndSettle();
}
