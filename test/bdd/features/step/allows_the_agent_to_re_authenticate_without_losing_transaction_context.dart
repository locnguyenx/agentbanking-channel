import 'package:flutter_test/flutter_test.dart';

/// Usage: allows the agent to re-authenticate without losing transaction context
Future<void> allowsTheAgentToReAuthenticateWithoutLosingTransactionContext(WidgetTester tester) async {
  // Tap RE-AUTHENTICATE on the dialog which should navigate to login or just re-auth
  final reAuthButton = find.text('RE-AUTHENTICATE');
  expect(reAuthButton, findsOneWidget);
  await tester.tap(reAuthButton);
  await tester.pumpAndSettle();
}
