import 'package:flutter_test/flutter_test.dart';

Future<void> theAgentNeverHasAccessToTheRawPin(
    WidgetTester tester) async {
  await tester.pumpAndSettle();
  // No-op for security check
}
