import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> theAgentSelectsEsspAndEntersTheCustomersNricAndEsspCertificateType(
    WidgetTester tester) async {
  await tester.pumpAndSettle();
  
  final esspBtn = find.byKey(const Key('btn_essp_service'));
  expect(esspBtn, findsOneWidget, reason: 'Dashboard eSSP button not found');
  await tester.ensureVisible(esspBtn);
  await tester.tap(esspBtn);
  await tester.pumpAndSettle();

  // Modernized SpecialServicesForm labels
  await tester.enterText(find.widgetWithText(TextField, 'Identifier'), '900101141234');
  await tester.enterText(find.widgetWithText(TextField, 'Amount'), '1000.00');
  await tester.pumpAndSettle();
  
  await tester.tap(find.byKey(const Key('btn_main_action')));
  await tester.pumpAndSettle();
}
