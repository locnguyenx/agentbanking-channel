import 'package:flutter_test/flutter_test.dart';

/// Usage: all STP workflows are disabled
Future<void> allStpWorkflowsAreDisabled(WidgetTester tester) async {
  // Verify that we are blocked (e.g. error message or locked screen)
  expect(find.textContaining('Transactions Blocked'), findsOneWidget);
}
