import 'package:flutter_test/flutter_test.dart';

Future<void> theAppShowsANonBlockingSessionExpiredPleaseReAuthenticateOverlay(WidgetTester tester) async {
  await tester.pumpAndSettle();
  expect(find.textContaining('Session expired'), findsOneWidget);
  expect(find.text('RE-AUTHENTICATE'), findsOneWidget);
}
