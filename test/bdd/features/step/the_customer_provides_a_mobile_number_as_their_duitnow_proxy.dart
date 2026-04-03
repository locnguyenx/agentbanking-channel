import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: the customer provides a Mobile Number as their DuitNow proxy
Future<void> theCustomerProvidesAMobileNumberAsTheirDuitnowProxy(WidgetTester tester) async {
  await tester.pumpAndSettle();
  
  final proxyFinder = find.byKey(const Key('field_duitnow_proxy'));
  if (proxyFinder.evaluate().isEmpty) {
    // Fallback to first text field
    await tester.enterText(find.byType(TextField).at(0), '0123456789');
  } else {
    await tester.enterText(proxyFinder, '0123456789');
  }
  
  final amountFinder = find.byKey(const Key('field_amount'));
  if (amountFinder.evaluate().isEmpty) {
     await tester.enterText(find.byType(TextField).last, '100');
  } else {
    await tester.enterText(amountFinder, '100');
  }
  await tester.pumpAndSettle();
}
