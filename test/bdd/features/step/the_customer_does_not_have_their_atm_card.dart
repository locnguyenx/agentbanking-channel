import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> theCustomerDoesNotHaveTheirAtmCard(WidgetTester tester) async {
  await tester.pumpAndSettle();
  
  final withdrawButton = find.byKey(const Key('btn_withdrawal'));
  expect(withdrawButton, findsOneWidget);
  await tester.tap(withdrawButton);
  await tester.pumpAndSettle();

  // 1. Select MyKad Biometric funding source
  final mykadSource = find.byKey(const Key('funding_source_MYKAD_BIOMETRIC'));
  expect(mykadSource, findsOneWidget);
  await tester.tap(mykadSource);
  await tester.pumpAndSettle();
  
  // 2. Enter amount (Mandatory for Withdraw)
  await tester.enterText(find.byType(TextField).first, '100.00');
  await tester.pumpAndSettle();
  
  // 3. Tap GET QUOTE (btn_main_action)
  final proceed = find.byKey(const Key('btn_main_action'));
  expect(proceed, findsOneWidget);
  await tester.tap(proceed);
  await tester.pumpAndSettle();
}
