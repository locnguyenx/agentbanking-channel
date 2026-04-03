import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> theAgentEnteredACorrectlyFormattedPhoneNumber(WidgetTester tester) async {
  await tester.pumpAndSettle();
  // Find by label to be most robust
  final phoneField = find.widgetWithText(TextFormField, 'Phone Number');
  if (phoneField.evaluate().isEmpty) {
     // Fallback to searching all TextFormFields if label not found precisely
     await tester.enterText(find.byType(TextFormField).first, '0123456789');
  } else {
     await tester.enterText(phoneField, '0123456789');
  }
  await tester.pumpAndSettle();
}
