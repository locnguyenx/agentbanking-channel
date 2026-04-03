import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../helpers/bdd_step_utils.dart';

Future<void> theAgentSelectsPinPurchaseAndChoosesTheVoucherTypeEgDigiRm10(
    WidgetTester tester) async {
  await tester.pumpAndSettle();
  
  // Dashboard navigation
  final pinBtn = find.byKey(const Key('btn_pin_purchase'));
  await tester.tap(pinBtn);
  await tester.pumpAndSettle();

  await selectFundingSourceIfNeeded(tester);

  // Use Dropdowns in SpecialServicesForm
  await tester.tap(find.text('Select Provider'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Digi').last);
  await tester.pumpAndSettle();

  await tester.tap(find.text('Select Denomination'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('RM 10').last);
  await tester.pumpAndSettle();
  
  await tester.tap(find.byKey(const Key('btn_main_action')));
  await tester.pumpAndSettle();
  
  // Consent/Quote screen "AGREE"
  final agreeBtn = find.byKey(const Key('btn_confirm'));
  if (agreeBtn.evaluate().isNotEmpty) {
      await tester.tap(agreeBtn);
      await tester.pumpAndSettle();
  }
}
