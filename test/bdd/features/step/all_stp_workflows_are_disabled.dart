import 'package:flutter_test/flutter_test.dart';
import '../../bdd_test_helper.dart';

/// Usage: all STP workflows are disabled
Future<void> allStpWorkflowsAreDisabled(WidgetTester tester) async {
  // Verify that we are blocked (e.g. error message or locked screen)
  await waitFor(tester, find.textContaining('Transactions Blocked'), timeout: const Duration(seconds: 10));
}
