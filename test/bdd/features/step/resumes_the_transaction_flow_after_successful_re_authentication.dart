import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../setup/test_credentials.dart';
import '../../bdd_test_helper.dart';

/// Usage: resumes the transaction flow after successful re_authentication
Future<void> resumesTheTransactionFlowAfterSuccessfulReAuthentication(
    WidgetTester tester) async {
  // Tap re-authenticate on dialog
  await tester.tap(find.text('RE-AUTHENTICATE'));
  await tester.pumpAndSettle();

  // Login again
  await tester.enterText(find.byType(TextField).first, TestCredentials.username);
  await tester.enterText(find.byType(TextField).last, TestCredentials.password);
  await tester.tap(find.text('LOGIN'));
  
  // Verify we are back to dashboard - wait up to 30s
  await waitFor(tester, find.textContaining('Dashboard'), timeout: const Duration(seconds: 30));
  expect(find.textContaining('Dashboard'), findsOneWidget);
}
