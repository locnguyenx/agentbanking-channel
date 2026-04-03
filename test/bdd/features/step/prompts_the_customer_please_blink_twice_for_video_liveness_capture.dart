import 'package:flutter_test/flutter_test.dart';

/// Usage: prompts the customer "Please Blink Twice" for Video Liveness capture
Future<void> promptsTheCustomerPleaseBlinkTwiceForVideoLivenessCapture(
    WidgetTester tester) async {
  await tester.pump(const Duration(milliseconds: 500));
  expect(find.textContaining('BLINK TWICE'), findsOneWidget);
}
