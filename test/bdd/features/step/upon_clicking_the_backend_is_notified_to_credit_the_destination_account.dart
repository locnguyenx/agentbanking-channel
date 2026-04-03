import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: upon clicking, the backend is notified to credit the destination account
Future<void> uponClickingTheBackendIsNotifiedToCreditTheDestinationAccount(WidgetTester tester) async {
  await tester.pumpAndSettle();
  
  // Verify success status via bdd_status_token
  final statusToken = find.byKey(const Key('bdd_status_token'));
  expect(statusToken, findsOneWidget);
  expect(tester.widget<Text>(statusToken).data, contains('Status: success'));
}
