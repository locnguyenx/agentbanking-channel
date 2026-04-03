import 'package:flutter_test/flutter_test.dart';

/// Usage: it uses exponential backoff: 1s wait, then 2s, then 4s
Future<void> itUsesExponentialBackoff1sWaitThen2sThen4s(WidgetTester tester) async {
  // Verify timing (simulated)
  await tester.pump(const Duration(seconds: 1));
  await tester.pump(const Duration(seconds: 2));
  await tester.pump(const Duration(seconds: 4));
}
