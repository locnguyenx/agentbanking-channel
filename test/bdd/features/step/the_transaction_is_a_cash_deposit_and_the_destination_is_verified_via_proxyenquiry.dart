import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> theTransactionIsACashDepositAndTheDestinationIsVerifiedViaProxyenquiry(WidgetTester tester) async {
  await tester.pumpAndSettle();
  final depositBtn = find.byKey(const Key('btn_deposit'));
  expect(depositBtn, findsOneWidget);
  await tester.tap(depositBtn);
  await tester.pumpAndSettle();
  
  // Input destination and amount
  await tester.enterText(find.byKey(const Key('field_destination_account')), '1234567890');
  await tester.enterText(find.byKey(const Key('field_amount')), '100');
  await tester.pumpAndSettle();
  
  // Tap GET QUOTE to move to waitingConsent
  await tester.tap(find.byKey(const Key('btn_main_action')));
  await tester.pumpAndSettle();
}
