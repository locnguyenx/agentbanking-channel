import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../helpers/bdd_step_utils.dart';

Future<void> theCustomerProvidesTheirSarawakPayAccountIdentifier(
    WidgetTester tester) async {
  await tester.pumpAndSettle();
  
  final sarawakBtn = find.byKey(const Key('btn_sarawak_pay'));
  if (sarawakBtn.evaluate().isNotEmpty) {
      await tester.tap(sarawakBtn);
      await tester.pumpAndSettle();
  }

  await selectFundingSourceIfNeeded(tester);
  
  // Use "Mobile Number" label from EWalletForm
  await tester.enterText(find.widgetWithText(TextFormField, 'Mobile Number'), '0123456789');
  await tester.enterText(find.widgetWithText(TextFormField, 'Amount'), '50.00');
  await tester.pumpAndSettle();
  
  await tester.tap(find.byKey(const Key('btn_main_action')));
  await tester.pumpAndSettle();
}
