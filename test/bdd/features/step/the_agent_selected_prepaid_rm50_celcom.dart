import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> theAgentSelectedPrepaidRm50Celcom(WidgetTester tester) async {
  await tester.pumpAndSettle();
  final topupBtn = find.byKey(const Key('btn_top_up'));
  await tester.tap(topupBtn.first);
  await tester.pumpAndSettle();

  // Enter reference and amount in SpecialServicesForm
  final idField = find.byType(TextField).at(0);
  final amountField = find.byType(TextField).at(1);
  await tester.enterText(idField, '0123456789');
  await tester.enterText(amountField, '50');
  await tester.pumpAndSettle();
}
