import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: resumes the transaction flow after successful re_authentication
Future<void> resumesTheTransactionFlowAfterSuccessfulReAuthentication(
    WidgetTester tester) async {
  // Tap re-authenticate on dialog
  await tester.tap(find.text('RE-AUTHENTICATE'));
  await tester.pumpAndSettle();

  // Login again
  await tester.enterText(find.byType(TextField).first, 'AGENT-001');
  await tester.enterText(find.byType(TextField).last, 'password123');
  await tester.tap(find.text('LOGIN'));
  await tester.pumpAndSettle();
  
  // Verify we are back to dashboard
  expect(find.textContaining('Dashboard'), findsOneWidget);
}
