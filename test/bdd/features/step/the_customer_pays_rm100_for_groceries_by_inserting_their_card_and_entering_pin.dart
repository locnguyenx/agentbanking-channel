import 'package:flutter_test/flutter_test.dart';

/// Usage: the customer pays RM 100 for groceries by inserting their card and entering PIN
import 'package:agentbanking_channel/features/merchant/providers/merchant_provider.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:decimal/decimal.dart';
import '../../bdd_test_helper.dart';

Future<void> theCustomerPaysRm100ForGroceriesByInsertingTheirCardAndEnteringPin(WidgetTester tester) async {
  final notifier = bddContainer.read(merchantProvider.notifier);
  await notifier.startRetailSale(Decimal.fromInt(100), FundingSource.CARD_EMV);
}
