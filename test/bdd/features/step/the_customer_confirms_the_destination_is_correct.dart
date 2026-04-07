import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> theCustomerConfirmsTheDestinationIsCorrect(
    WidgetTester tester) async {
  await tester.pumpAndSettle();
  
  final agreeBtn = find.byKey(const Key('btn_confirm'));
  expect(agreeBtn, findsOneWidget, reason: "Consent details must be visible for customer to confirm");
}
