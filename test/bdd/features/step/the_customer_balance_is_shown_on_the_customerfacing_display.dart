import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> theCustomerBalanceIsShownOnTheCustomerfacingDisplay(WidgetTester tester) async {
  await tester.pumpAndSettle();
  // Wait for success screen
  expect(find.byKey(const Key('status_success')), findsOneWidget);
  // Verify balance label is present
  expect(find.textContaining('Balance'), findsWidgets);
}
