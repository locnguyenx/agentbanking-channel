import 'package:flutter_test/flutter_test.dart';

/// Usage: the UI displays the agent's pre-funded float ledger balance
Future<void> theUiDisplaysTheAgentsPreFundedFloatLedgerBalance(WidgetTester tester) async {
  expect(find.textContaining('Current Float'), findsOneWidget);
  expect(find.textContaining('RM 5,000.00'), findsOneWidget);
}
