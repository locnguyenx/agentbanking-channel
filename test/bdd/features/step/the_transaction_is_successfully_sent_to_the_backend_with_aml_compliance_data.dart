import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> theTransactionIsSuccessfullySentToTheBackendWithAmlComplianceData(
    WidgetTester tester) async {
  await tester.pumpAndSettle();
  
  // If on a confirmation screen, tap AGREE
  final agreeBtn = find.byKey(const Key('btn_confirm'));
  if (agreeBtn.evaluate().isNotEmpty) {
      await tester.tap(agreeBtn);
      await tester.pumpAndSettle();
  }
  
  expect(find.text('Success!'), findsOneWidget);
}
