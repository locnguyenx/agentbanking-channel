import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../helpers/bdd_step_utils.dart';

Future<void> theEsspCertificateTypeAndNricAreEnteredAndValidated(
    WidgetTester tester) async {
  await tester.pumpAndSettle();
  
  final esspBtn = find.byKey(const Key('btn_essp_service'));
  await tester.tap(esspBtn);
  await tester.pumpAndSettle();

  await selectFundingSourceIfNeeded(tester);
  
  // SpecialServicesForm (ESSP mode) uses "Identifier" and "Amount"
  await tester.enterText(find.widgetWithText(TextField, 'Identifier'), '800101145566');
  await tester.enterText(find.widgetWithText(TextField, 'Amount'), '20.00');
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
