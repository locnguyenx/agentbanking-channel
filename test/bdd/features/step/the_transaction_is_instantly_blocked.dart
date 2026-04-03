import 'package:flutter_test/flutter_test.dart';

/// Usage: the transaction is instantly blocked
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import '../../bdd_test_helper.dart';

Future<void> theTransactionIsInstantlyBlocked(WidgetTester tester) async {
  final state = bddContainer.read(transactionProvider);
  expect(state.status, TransactionStatus.failed);
}
