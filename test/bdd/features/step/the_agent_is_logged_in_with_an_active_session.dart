import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/dashboard/dashboard_screen.dart';
import 'package:agentbanking_channel/features/auth/login_screen.dart';
import '../../../setup/test_credentials.dart';
import '../../bdd_test_helper.dart';

const bool isRealBackend = bool.fromEnvironment('USE_REAL_BACKEND', defaultValue: false);

Future<void> theAgentIsLoggedInWithAnActiveSession(WidgetTester tester) async {
  print('BDD_DEBUG: theAgentIsLoggedInWithAnActiveSession starting');
  await pumpBddApp(tester, isAuthenticated: true);
  print('BDD_DEBUG: pumpBddApp finished');
  await tester.pump(const Duration(milliseconds: 500));
  print('BDD_DEBUG: Initial 500ms pump finished');

  // Real backend connectivity is verified by Dio activity
  
  if (find.byType(LoginScreen).evaluate().isNotEmpty) {
    print('BDD_DEBUG: LoginScreen detected. entering credentials...');
    final fields = find.byType(TextField);
    await tester.enterText(fields.at(0), TestCredentials.username);
    await tester.enterText(fields.at(1), TestCredentials.password);
    
    // In real backend mode, we need runAsync for the actual login call
    if (isRealBackend) {
      await tester.runAsync(() async {
        await tester.tap(find.text('LOGIN'));
      });
      print('BDD_DEBUG: LOGIN tapped. waiting for DashboardScreen...');
      // Wait for the Dashboard to appear using our async-aware waitFor
      await waitFor(tester, find.byType(DashboardScreen), timeout: const Duration(seconds: 60));
      print('BDD_DEBUG: DashboardScreen found!');
  } else {
      await tester.tap(find.text('LOGIN'));
      await tester.pumpAndSettle();
    }
  }

  // Ensure we are indeed on the dashboard
  expect(find.byType(DashboardScreen), findsOneWidget);
}
