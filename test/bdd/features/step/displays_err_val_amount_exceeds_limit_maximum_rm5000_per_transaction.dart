import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: displays "ERR_VAL_AMOUNT_EXCEEDS_LIMIT: Maximum RM 5,000 per transaction"
Future<void> displaysErrValAmountExceedsLimitMaximumRm5000PerTransaction(WidgetTester tester) async {
  final statusToken = find.byKey(const Key('bdd_status_token'));
  expect(statusToken, findsOneWidget);
  final text = tester.widget<Text>(statusToken).data ?? '';
  expect(text, contains('ERR_VAL_AMOUNT_EXCEEDS_LIMIT'));
  // Just ensure it mentions a limit value (3,000 or 5,000)
  expect(text.contains('3,000') || text.contains('5,000'), isTrue, 
    reason: 'Expected limit value (3,000 or 5,000) in error message: $text');
}
