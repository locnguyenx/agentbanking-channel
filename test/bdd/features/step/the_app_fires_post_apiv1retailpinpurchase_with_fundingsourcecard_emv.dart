import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> theAppFiresPostApiv1retailpinpurchaseWithFundingsourcecardEmv(
    WidgetTester tester) async {
  await tester.pumpAndSettle();
  expect(find.textContaining('Success'), findsOneWidget);
}
