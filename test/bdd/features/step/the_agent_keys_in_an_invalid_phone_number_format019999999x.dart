import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: the agent keys in an invalid phone number format "019999999X"
Future<void> theAgentKeysInAnInvalidPhoneNumberFormat019999999x(WidgetTester tester) async {
  await tester.pumpAndSettle();
  // Try either 'Phone Number' (TopUpForm) or 'Identifier' (SpecialServicesForm)
  final phoneField = find.widgetWithText(TextFormField, 'Phone Number');
  final idField = find.widgetWithText(TextField, 'Identifier');
  
  if (phoneField.evaluate().isNotEmpty) {
      await tester.enterText(phoneField, '019999999X');
  } else if (idField.evaluate().isNotEmpty) {
      await tester.enterText(idField.at(0), '019999999X');
  } else {
      // Fallback
      await tester.enterText(find.byType(TextField).first, '019999999X');
  }
  await tester.pumpAndSettle();
}
