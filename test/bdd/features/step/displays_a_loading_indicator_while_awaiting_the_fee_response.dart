import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> displaysALoadingIndicatorWhileAwaitingTheFeeResponse(WidgetTester tester) async {
  // No extra pump here - the pump in theAgentTapsProceed already rendered the quoting state.
  // Adding a pump(Duration.zero) here would already resolve the mocking timer.
  expect(find.byType(CircularProgressIndicator), findsOneWidget);
  expect(find.text('Calculating Fees...'), findsOneWidget);
  // Conclusively drain the mock timer so it's not pending when test ends
  await tester.pumpAndSettle();
}
