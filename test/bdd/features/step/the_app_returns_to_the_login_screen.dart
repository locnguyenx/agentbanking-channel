import 'package:flutter_test/flutter_test.dart';

/// Usage: the app returns to the login screen
Future<void> theAppReturnsToTheLoginScreen(WidgetTester tester) async {
  // Use 'LOGIN' as found in login_screen.dart (ElevatedButton text)
  expect(find.text('LOGIN'), findsOneWidget);
}
