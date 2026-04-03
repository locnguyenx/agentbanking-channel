import 'package:flutter_test/flutter_test.dart';

/// Usage: the match-on-card returns match
Future<void> theMatchOnCardReturnsMatch(WidgetTester tester) async {
  // Wait for background card processing and biometric match
  await tester.pump(const Duration(seconds: 1));
  await tester.pumpAndSettle();
}
