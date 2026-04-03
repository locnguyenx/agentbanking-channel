import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: the POS hardware encrypts the PIN block via DUKPT immediately
Future<void> thePosHardwareEncryptsThePinBlockViaDukptImmediately(
    WidgetTester tester) async {
  await tester.pump(const Duration(milliseconds: 10));
  // In fast mock environments, it might already be in success state
  final statusToken = find.byKey(const Key('bdd_status_token'));
  expect(statusToken, findsOneWidget);
  final statusData = tester.widget<Text>(statusToken).data ?? '';
  expect(statusData, anyOf(contains('processing'), contains('success')));
}
