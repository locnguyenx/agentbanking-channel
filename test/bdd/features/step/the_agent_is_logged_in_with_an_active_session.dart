import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/dashboard/dashboard_screen.dart';
import 'package:agentbanking_channel/features/auth/login_screen.dart';
import '../../../setup/test_credentials.dart';
import '../../bdd_test_helper.dart';

Future<void> theAgentIsLoggedInWithAnActiveSession(WidgetTester tester) async {
  await pumpBddApp(tester, isAuthenticated: true);
  await tester.pumpAndSettle();
  
  if (find.byType(LoginScreen).evaluate().isNotEmpty) {
    final fields = find.byType(TextField);
    await tester.enterText(fields.at(0), TestCredentials.username);
    await tester.enterText(fields.at(1), TestCredentials.password);
    await tester.tap(find.text('LOGIN'));
    await tester.pumpAndSettle();
  }

  // Ensure we are indeed on the dashboard
  expect(find.byType(DashboardScreen), findsOneWidget);
}
