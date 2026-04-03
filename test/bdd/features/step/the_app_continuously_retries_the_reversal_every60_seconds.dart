import 'package:flutter_test/flutter_test.dart';

/// Usage: the app continuously retries the reversal every 60 seconds
Future<void> theAppContinuouslyRetriesTheReversalEvery60Seconds(
    WidgetTester tester) async {
  await tester.pump(const Duration(seconds: 1));
}
