import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> theAppFiresPostApiv1retailpinPurchaseWithFundingsourcecardEmv(WidgetTester tester) async {
  await tester.pumpAndSettle();
  expect(find.byKey(const Key('status_success')), findsOneWidget);
}
