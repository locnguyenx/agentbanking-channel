import 'package:flutter_test/flutter_test.dart';

/// Usage: the agent attempts to initiate a transaction
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import '../../bdd_test_helper.dart';

const bool isRealBackend = bool.fromEnvironment('USE_REAL_BACKEND', defaultValue: false);

Future<void> theAgentAttemptsToInitiateATransaction(WidgetTester tester) async {
  final notifier = bddContainer.read(transactionProvider.notifier);
  
  if (isRealBackend) {
    await tester.runAsync(() async {
      await notifier.startTransaction(
        Decimal.fromInt(100),
        'MERCHANT-123',
        serviceCode: 'CASH_DEPOSIT',
        fundingSource: FundingSource.CASH,
      );
    });
  } else {
    await notifier.startTransaction(
      Decimal.fromInt(100),
      'MERCHANT-123',
      serviceCode: 'CASH_DEPOSIT',
      fundingSource: FundingSource.CASH,
    );
  }
}
