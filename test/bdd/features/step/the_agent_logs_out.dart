import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: the agent logs out
Future<void> theAgentLogsOut(WidgetTester tester) async {
  final logoutButton = find.byIcon(Icons.logout);
  expect(logoutButton, findsOneWidget);
  await tester.tap(logoutButton);
  await tester.pumpAndSettle();
}
