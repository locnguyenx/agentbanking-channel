import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: displays "ERR_EXT_BILLER_UNAVAILABLE" or "Number not found"
Future<void> displaysErrExtBillerUnavailableOrNumberNotFound(
    WidgetTester tester) async {
  await tester.pumpAndSettle();
  final token = find.byKey(const Key('bdd_status_token'));
  expect(token, findsOneWidget);
  
  final text = tester.widget<Text>(token).data ?? '';
  bool hasError = text.contains('ERR_EXT_BILLER_UNAVAILABLE') || 
                  text.contains('Number not found') ||
                  text.contains('biller_unavailable');
                  
  expect(hasError, isTrue, reason: 'Expected biller error in status token but found: $text');
}
