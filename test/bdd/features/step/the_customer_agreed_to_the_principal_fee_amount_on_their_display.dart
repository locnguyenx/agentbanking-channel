import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> theCustomerAgreedToThePrincipalFeeAmountOnTheirDisplay(WidgetTester tester) async {
  await tester.pumpAndSettle();
  final withdrawalBtn = find.byKey(const Key('btn_withdrawal'));
  expect(withdrawalBtn, findsOneWidget);
  await tester.tap(withdrawalBtn);
  await tester.pumpAndSettle();
  
  // Enter amount
  await tester.enterText(find.byType(TextField).at(0), '100');
  await tester.pumpAndSettle();
  
  // Tap GET QUOTE
  await tester.tap(find.byKey(const Key('btn_main_action')));
  await tester.pumpAndSettle();
  
  // Tap AGREE (btn_confirm) to satisfy "customer agreed"
  await tester.tap(find.byKey(const Key('btn_confirm')));
  await tester.pumpAndSettle();
}
