import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> theAgentAcceptsCashFromTheCustomerAndClicksConfirmCashCollected(
    WidgetTester tester) async {
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
  
  // "AGREE" button (Consent) is shown for cash collection confirmation
  final agreeBtn = find.byKey(const Key('btn_confirm'));
  expect(agreeBtn, findsOneWidget, reason: 'Consent (btn_confirm) should be visible for cash collection');
  await tester.tap(agreeBtn);
  await tester.pumpAndSettle();
}
