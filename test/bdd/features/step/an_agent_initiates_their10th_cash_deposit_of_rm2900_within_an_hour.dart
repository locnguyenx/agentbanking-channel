import 'package:flutter_test/flutter_test.dart';

/// Usage: an agent initiates their 10th Cash Deposit of RM 2,900 within an hour
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import '../../bdd_test_helper.dart';
import '../../../setup/test_credentials.dart';

Future<void> anAgentInitiatesTheir10thCashDepositOfRm2900WithinAnHour(WidgetTester tester) async {
  final notifier = bddContainer.read(transactionProvider.notifier);
  await notifier.startTransaction(
    Decimal.fromInt(2900), TestCredentials.username,
    serviceCode: 'CASH_DEPOSIT', fundingSource: FundingSource.CASH,
  );
  await tester.pump(const Duration(milliseconds: 500));
}
