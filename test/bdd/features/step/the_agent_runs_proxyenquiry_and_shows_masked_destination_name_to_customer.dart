import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../helpers/bdd_step_utils.dart';

Future<void> theAgentRunsProxyenquiryAndShowsMaskedDestinationNameToCustomer(
    WidgetTester tester) async {
  await tester.pumpAndSettle();
  
  // FIXED KEY: btn_cash_deposit -> btn_deposit
  final depositBtn = find.byKey(const Key('btn_deposit'));
  if (depositBtn.evaluate().isNotEmpty) {
      await tester.tap(depositBtn);
      await tester.pumpAndSettle();
  }

  await selectFundingSourceIfNeeded(tester);

  await tester.enterText(find.byKey(const Key('field_destination_account')), '1234567890');
  await tester.enterText(find.byKey(const Key('field_amount')), '500.00');
  await tester.pumpAndSettle();
  
  await tester.tap(find.byKey(const Key('btn_main_action')));
  await tester.pumpAndSettle();
  
}
