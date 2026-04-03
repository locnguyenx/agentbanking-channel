import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> theAgentTypesADestinationAccountNumber(WidgetTester tester) async {
  await tester.pumpAndSettle();
  final depositBtn = find.byKey(const Key('btn_deposit'));
  expect(depositBtn, findsOneWidget);
  await tester.tap(depositBtn);
  await tester.pumpAndSettle();

  final accField = find.byKey(const Key('field_destination_account'));
  await tester.enterText(accField, '1234567890');
  await tester.pumpAndSettle();
}
