import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../bdd_test_helper.dart';

/// Usage: the agent is logged in and active
Future<void> theAgentIsLoggedInAndActive(WidgetTester tester) async {
  if (find.byType(MaterialApp).evaluate().isEmpty) {
    await pumpBddApp(tester, isAuthenticated: true);
  }
  
  // Wait for either logout icon or a dashboard signifier
  await waitFor(tester, find.byElementPredicate((element) {
    return find.byIcon(Icons.logout).evaluate().isNotEmpty || 
           find.text('Withdrawal').evaluate().isNotEmpty;
  }), timeout: const Duration(seconds: 15));
}
