import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> aBillerReceiptWithTmAcknowledgmentReferenceIsIssued(
    WidgetTester tester) async {
  await tester.pumpAndSettle();
  // We expect success screen
  expect(find.text('DONE'), findsOneWidget);
}
