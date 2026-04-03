import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> theAgentEarnsACommissionOnTheSale(WidgetTester tester) async {
  await tester.pumpAndSettle();
  expect(find.textContaining('AGENT COMMISSION'), findsOneWidget);
}
