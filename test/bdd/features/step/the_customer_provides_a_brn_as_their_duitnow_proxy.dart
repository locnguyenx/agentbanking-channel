import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> theCustomerProvidesABrnAsTheirDuitnowProxy(WidgetTester tester) async {
  await tester.pumpAndSettle();
  // Select BRN chip first
  final chip = find.byKey(const Key('funding_source_DUITNOW_BRN'));
  if (chip.evaluate().isNotEmpty) {
    await tester.tap(chip);
    await tester.pumpAndSettle();
  }
  final proxyField = find.byType(TextField).at(0);
  await tester.enterText(proxyField, '202301012345');
  
  // Enter amount
  final amountField = find.byKey(const Key('field_amount'));
  if (amountField.evaluate().isNotEmpty) {
    await tester.enterText(amountField, '100');
  } else {
    await tester.enterText(find.byType(TextField).at(1), '100');
  }
  
  await tester.pumpAndSettle();
}
