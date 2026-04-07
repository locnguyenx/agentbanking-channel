import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> theCustomerDoesNotHaveTheirAtmCard(WidgetTester tester) async {
  await tester.pumpAndSettle();
  
  final withdrawButton = find.byKey(const Key('btn_withdrawal'));
  expect(withdrawButton, findsOneWidget);
  await tester.tap(withdrawButton);
  await tester.pumpAndSettle();
}
