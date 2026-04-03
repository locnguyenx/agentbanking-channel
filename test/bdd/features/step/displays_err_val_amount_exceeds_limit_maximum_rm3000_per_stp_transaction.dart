import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

Future<void> displaysErrValAmountExceedsLimitMaximumRm3000PerStpTransaction(WidgetTester tester) async {
  final statusToken = find.byKey(const Key('bdd_status_token'));
  expect(statusToken, findsOneWidget);
  expect(tester.widget<Text>(statusToken).data, contains('ERR_VAL_AMOUNT_EXCEEDS_LIMIT'));
  expect(tester.widget<Text>(statusToken).data, contains('3,000'));
}
