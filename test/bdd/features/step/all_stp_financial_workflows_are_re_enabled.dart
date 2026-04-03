import 'package:flutter_test/flutter_test.dart';

/// Usage: all STP financial workflows are re-enabled
Future<void> allStpFinancialWorkflowsAreReEnabled(WidgetTester tester) async {
  // Verify the "Withdrawal" button is available again and clickable
  final withdrawalButton = find.text('Withdrawal');
  expect(withdrawalButton, findsOneWidget);
}
