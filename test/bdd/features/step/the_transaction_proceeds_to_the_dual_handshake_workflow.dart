import 'package:flutter_test/flutter_test.dart';

/// Usage: the transaction proceeds to the Dual_Handshake workflow
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import '../../bdd_test_helper.dart';

Future<void> theTransactionProceedsToTheDualHandshakeWorkflow(WidgetTester tester) async {
  final state = bddContainer.read(transactionProvider);
  expect(state.status, anyOf(TransactionStatus.quoting, TransactionStatus.waitingConsent));
}
