import 'package:flutter_test/flutter_test.dart';

/// Usage: the customer must verbally or digitally confirm ownership before funds are collected
Future<void>
    theCustomerMustVerballyOrDigitallyConfirmOwnershipBeforeFundsAreCollected(
        WidgetTester tester) async {
  // Wait for the UI to transition from 'Processing' to 'Confirm Details'
  int count = 0;
  while (count < 20 && find.textContaining('Confirm Details').evaluate().isEmpty) {
    await tester.pump(const Duration(milliseconds: 100));
    count++;
  }
  
  expect(find.textContaining('Confirm Details'), findsOneWidget);
  
  final agreeBtn = find.textContaining('AGREE');
  expect(agreeBtn, findsOneWidget);
  await tester.tap(agreeBtn);
  await tester.pumpAndSettle();
}
