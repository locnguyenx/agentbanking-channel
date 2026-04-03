import 'package:flutter_test/flutter_test.dart';

/// Usage: the UI displays the agent's pre-funded Float Ledger balance
Future<void> theUiDisplaysTheAgentsPrefundedFloatLedgerBalance(
    WidgetTester tester) async {
  await tester.pumpAndSettle();
  expect(find.textContaining('Current Float'), findsOneWidget);
  expect(find.textContaining('RM 10,000.00'), findsOneWidget);
}
