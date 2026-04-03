import 'package:flutter_test/flutter_test.dart';

/// Usage: the app does NOT retry the financial request
Future<void> theAppDoesNotRetryTheFinancialRequest(WidgetTester tester) async {
  // Check for the correct text in the specialized Reversal Queued view
  expect(find.text('Request Timeout'), findsOneWidget);
  expect(find.textContaining('reversal has been queued'), findsOneWidget);
}
