import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../helpers/bdd_step_utils.dart';

Future<void> aCustomerRequestsATransactionOfRm4000(WidgetTester tester) async {
  await tester.pumpAndSettle();
  
  final withdrawBtn = find.byKey(const Key('btn_withdrawal'));
  expect(withdrawBtn, findsOneWidget);
  await tester.tap(withdrawBtn);
  await tester.pumpAndSettle();

  await selectFundingSourceIfNeeded(tester);

  // Enter amount 4000
  await tester.enterText(find.byKey(const Key('field_amount')), '4000.00');
  await tester.pumpAndSettle();
  
  final proceed = find.byKey(const Key('btn_main_action'));
  if (proceed.evaluate().isNotEmpty) {
    await tester.tap(proceed);
    await tester.pumpAndSettle();
  }
}
