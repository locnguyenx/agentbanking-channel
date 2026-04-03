import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> theAppQueriesTheBackendProxyenquiry(WidgetTester tester) async {
  final fields = find.byType(TextField);
  if (fields.evaluate().length > 1) {
    // If it's Deposit/DuitNow: Destination + Amount
    await tester.enterText(fields.at(0), '1234567890');
    await tester.enterText(fields.at(1), '100');
  } else {
    // Just amount
    await tester.enterText(fields.at(0), '100');
  }
  await tester.pumpAndSettle();
  
  // Actually tap the quote button
  final quoteBtn = find.byKey(const Key('btn_main_action'));
  await tester.tap(quoteBtn);
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 1)); // wait for proxy enquiry if any
  await tester.pumpAndSettle();
}
