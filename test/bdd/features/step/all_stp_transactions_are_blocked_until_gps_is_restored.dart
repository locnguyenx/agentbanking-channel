import 'package:flutter_test/flutter_test.dart';

/// Usage: all STP transactions are blocked until GPS is restored
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import '../../bdd_test_helper.dart';

Future<void> allStpTransactionsAreBlockedUntilGpsIsRestored(WidgetTester tester) async {
  final state = bddContainer.read(transactionProvider);
  expect(state.status, TransactionStatus.failed);
}
