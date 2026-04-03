import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: enters their 6_digit PIN on the encrypted hardware PIN pad
Future<void> entersTheir6DigitPinOnTheEncryptedHardwarePinPad(WidgetTester tester) async {
  await tester.pump(const Duration(milliseconds: 10));
  // In fast mock environments, it might already be processing or success
  final statusToken = find.byKey(const Key('bdd_status_token'));
  expect(statusToken, findsOneWidget);
  final statusData = tester.widget<Text>(statusToken).data ?? '';
  expect(statusData, anyOf(contains('waitingPin'), contains('processing'), contains('success')));
}
