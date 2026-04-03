import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> theCustomerIsNotifiedOfTheLargeCashCollectionRequirement(
    WidgetTester tester) async {
  await tester.pumpAndSettle();
  
  // The system should show the AML scanning screen
  expect(find.textContaining('Scan MyKad'), findsOneWidget);
}
