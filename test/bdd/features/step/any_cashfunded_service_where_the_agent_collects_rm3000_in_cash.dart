import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../helpers/bdd_step_utils.dart';
import '../../bdd_test_helper.dart';

Future<void> anyCashfundedServiceWhereTheAgentCollectsRm3000InCash(
    WidgetTester tester) async {
  await tester.pumpAndSettle();
  
  final billPayBtn = find.byKey(const Key('btn_bill_payment'));
  if (billPayBtn.evaluate().isNotEmpty) {
      await tester.tap(billPayBtn);
      await tester.pumpAndSettle();
  }

  await selectFundingSourceIfNeeded(tester);

  await tester.tap(find.text('Select Biller'));
  await tester.pumpAndSettle();
  await tester.tap(find.textContaining('Astro').last);
  await tester.pumpAndSettle();

  await tester.enterText(find.widgetWithText(TextFormField, 'Ref-1'), 'ASTRO123');
  await tester.enterText(find.widgetWithText(TextFormField, 'Amount'), '3000.00');
  await tester.pumpAndSettle();
  
  await tester.tap(find.byKey(const Key('btn_main_action')));
  await tester.pumpAndSettle();
  
  // Wait for either the AGREE button or the CONFIRM CASH button
  final agreeBtn = find.byKey(const Key('btn_confirm'));
  final confirmBtn = find.byKey(const Key('btn_main_action'));
  
  // Just wait for the confirmation button to be visible
  await waitFor(tester, find.byWidgetPredicate((widget) => 
    widget is ElevatedButton && (widget.key == const Key('btn_confirm') || widget.key == const Key('btn_main_action'))));
}
