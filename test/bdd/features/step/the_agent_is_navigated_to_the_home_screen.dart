import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: the agent is navigated to the Home screen
Future<void> theAgentIsNavigatedToTheHomeScreen(WidgetTester tester) async {
  // Home screen usually has the logout button
  expect(find.byIcon(Icons.logout), findsOneWidget);
}
