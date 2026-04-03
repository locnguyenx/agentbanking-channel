import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

/// Usage: the UI requires the agent to click "Confirm Cash Received"
Future<void> theUiRequiresTheAgentToClickConfirmCashReceived(WidgetTester tester) async {
  // Use unified btn_confirm key from TransactionFlowScreen
  expect(find.byKey(const Key('btn_confirm')), findsOneWidget);
  await tester.tap(find.byKey(const Key('btn_confirm')));
  await tester.pumpAndSettle();
}
