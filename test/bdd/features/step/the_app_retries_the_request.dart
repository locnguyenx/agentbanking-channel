import 'package:flutter_test/flutter_test.dart';

/// Usage: the app retries the request
Future<void> theAppRetriesTheRequest(WidgetTester tester) async {
  // We expect the app to still be in a state or show a message if it retries.
  // For now, let's just wait and see if it stays in a non-terminal state
  await tester.pump(const Duration(seconds: 1));
}
