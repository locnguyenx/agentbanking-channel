import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: the agent logs out
Future<void> theAgentLogsOut(WidgetTester tester) async {
  final logoutButton = find.byKey(const Key('btn_logout'));
  if (logoutButton.evaluate().isEmpty) {
    // Fallback to icon if key is missing (for safety)
    final iconButton = find.byIcon(Icons.logout);
    expect(iconButton, findsOneWidget);
    await tester.tap(iconButton);
  } else {
    await tester.tap(logoutButton);
  }
  await tester.pumpAndSettle();
}
