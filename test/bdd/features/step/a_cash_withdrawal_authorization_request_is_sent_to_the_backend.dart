import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../bdd_test_helper.dart';

/// Usage: a cash withdrawal (authorization) request is sent to the backend
Future<void> aCashWithdrawalAuthorizationRequestIsSentToTheBackend(
    WidgetTester tester) async {
  if (find.byType(MaterialApp).evaluate().isEmpty) {
    await pumpBddApp(tester, isAuthenticated: true);
  }

  // Navigate to Withdrawal screen using the dashboard button
  final withdrawalBtn = find.byKey(const Key('btn_withdrawal'));
  await tester.tap(withdrawalBtn);
  await tester.pumpAndSettle();

  // Enter amount
  await tester.enterText(find.byKey(const Key('field_amount')), '100');
  await tester.pumpAndSettle();

  // Get Quote
  await tester.tap(find.byKey(const Key('btn_main_action')));
  await tester.pumpAndSettle();
  
  // We stop here so the next step can set a stub and tap CONFIRM
}
