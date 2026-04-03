import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> theAgentHandsOverPhysicalCashFromTheirFloat(WidgetTester tester) async {
  await tester.pumpAndSettle();
  // Should see success screen for withdrawal
  expect(find.textContaining('Success'), findsOneWidget);
}
