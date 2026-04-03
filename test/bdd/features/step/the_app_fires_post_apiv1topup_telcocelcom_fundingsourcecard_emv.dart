import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> theAppFiresPostApiv1topupTelcocelcomFundingsourcecardEmv(
    WidgetTester tester) async {
  await tester.pumpAndSettle();
  // Success check
  expect(find.textContaining('Success'), findsOneWidget);
}
