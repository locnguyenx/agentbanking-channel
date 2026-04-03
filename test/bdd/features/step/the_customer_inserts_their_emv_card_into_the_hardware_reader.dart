import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: the customer inserts their EMV card into the hardware reader
Future<void> theCustomerInsertsTheirEmvCardIntoTheHardwareReader(WidgetTester tester) async {
  await tester.pump(const Duration(milliseconds: 10));
  // In fast mock environments, it might already be in waitingPin or even success
  final statusToken = find.byKey(const Key('bdd_status_token'));
  expect(statusToken, findsOneWidget);
  final statusData = tester.widget<Text>(statusToken).data ?? '';
  expect(statusData, anyOf(contains('Status: waiting'), contains('Status: processing'), contains('Status: success')));
}
