import 'package:flutter_test/flutter_test.dart';

/// Usage: the agent attempts to initiate a transaction
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import '../../bdd_test_helper.dart';

Future<void> theAgentAttemptsToInitiateATransaction(WidgetTester tester) async {
  final notifier = bddContainer.read(transactionProvider.notifier);
  await notifier.startTransaction(
    Decimal.fromInt(100), 'MERCHANT-123',
    serviceCode: 'CASH_DEPOSIT', fundingSource: FundingSource.CASH,
  );
}
