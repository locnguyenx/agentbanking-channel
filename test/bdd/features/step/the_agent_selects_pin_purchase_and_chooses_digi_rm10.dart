import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> theAgentSelectsPinPurchaseAndChoosesDigiRm10(
    WidgetTester tester) async {
  await tester.pumpAndSettle();
  
  final pinBtn = find.byKey(const Key('btn_pin_purchase'));
  expect(pinBtn, findsOneWidget);
  await tester.tap(pinBtn);
  await tester.pumpAndSettle();

  await tester.tap(find.text('Select Provider'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Digi').last);
  await tester.pumpAndSettle();

  await tester.tap(find.text('Select Denomination'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('RM 10').last);
  await tester.pumpAndSettle();
  
  await tester.tap(find.byKey(const Key('btn_main_action')));
  await tester.pumpAndSettle();
}
