import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> theAppDetectsABreachOfTheRm5000PertransactionHardCap(
    WidgetTester tester) async {
  await tester.pumpAndSettle();
  // The snippet shows a snackbar or error text for invalid amount
  expect(find.textContaining('invalid amount'), findsOneWidget);
}
