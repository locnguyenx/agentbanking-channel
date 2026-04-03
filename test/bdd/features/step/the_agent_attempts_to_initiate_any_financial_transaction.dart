import 'package:flutter_test/flutter_test.dart';

/// Usage: the agent attempts to initiate any financial transaction
Future<void> theAgentAttemptsToInitiateAnyFinancialTransaction(WidgetTester tester) async {
  // Logic: In BDD, attempt to initiate an STP feature
  // If the UI is already locked (EOD), the tap will be blocked.
  final withdrawalButton = find.text('Withdrawal');
  
  if (withdrawalButton.evaluate().isNotEmpty) {
    // Pass warnIfMissed: false because at 23:59:59 the overlay blocks hit testing
    await tester.tap(withdrawalButton, warnIfMissed: false);
    await tester.pump();
  }
}
