import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> theAppInterruptsAndRequiresAMykadScanToRecordTheCustomersIdentityForAml(
    WidgetTester tester) async {
  await tester.pumpAndSettle();
  // Standardized key from TransactionFlowScreen line 273
  expect(find.byKey(const Key('status_waiting_mykad_scan')), findsOneWidget);
}
