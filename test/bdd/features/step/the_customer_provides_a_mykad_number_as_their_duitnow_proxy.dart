import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> theCustomerProvidesAMykadNumberAsTheirDuitnowProxy(WidgetTester tester) async {
  await tester.pumpAndSettle();
  // Select MyKad chip first
  final chip = find.byKey(const Key('funding_source_DUITNOW_MYKAD'));
  if (chip.evaluate().isNotEmpty) {
    await tester.tap(chip);
    await tester.pumpAndSettle();
  }
  // Find proxy input and enter MyKad
  final proxyField = find.byType(TextField).at(0);
  await tester.enterText(proxyField, '800101145566');
  
  // Enter amount
  final amountField = find.byKey(const Key('field_amount'));
  if (amountField.evaluate().isNotEmpty) {
    await tester.enterText(amountField, '100');
  } else {
    await tester.enterText(find.byType(TextField).at(1), '100');
  }
  
  await tester.pumpAndSettle();
}
