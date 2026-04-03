import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> theEwalletAccountIsValidatedAndHasSufficientBalance(
    WidgetTester tester) async {
  await tester.pumpAndSettle();
  // For withdrawal, it should wait for consent after e-wallet check
  expect(find.textContaining('Confirm Details'), findsOneWidget);
}
