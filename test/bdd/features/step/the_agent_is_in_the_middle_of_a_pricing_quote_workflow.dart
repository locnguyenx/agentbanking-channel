import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import '../../bdd_test_helper.dart';

Future<void> theAgentIsInTheMiddleOfAPricingQuoteWorkflow(WidgetTester tester) async {
  await pumpBddApp(tester, isAuthenticated: true);
  // Manually move the state machine to Quoting
  bddContainer.read(transactionProvider.notifier).debugSetState(
    TransactionState(status: TransactionStatus.quoting),
  );
  await tester.pumpAndSettle();
}
