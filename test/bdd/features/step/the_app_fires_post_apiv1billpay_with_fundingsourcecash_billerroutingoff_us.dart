import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> theAppFiresPostApiv1billpayWithFundingsourcecashBillerroutingoffUs(WidgetTester tester) async {
  // Wait up to 2 seconds for success state
  bool found = false;
  for (int i = 0; i < 20; i++) {
    await tester.pump(const Duration(milliseconds: 100));
    if (find.textContaining('Success!').evaluate().isNotEmpty) {
      found = true;
      break;
    }
  }
  expect(found, isTrue, reason: 'Success! widget should be visible after transaction');
}
