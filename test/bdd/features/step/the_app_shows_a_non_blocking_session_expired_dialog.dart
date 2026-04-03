import 'package:flutter_test/flutter_test.dart';

/// Usage: the app shows a non-blocking session expired dialog
Future<void> theAppShowsANonBlockingSessionExpiredDialog(WidgetTester tester) async {
  // Dialog might need a pump to appear
  await tester.pump(const Duration(milliseconds: 500));
  expect(find.text('Session expired'), findsOneWidget);
}
