import 'package:flutter_test/flutter_test.dart';

/// Usage: a Sales Receipt is issued to the customer
import 'package:agentbanking_channel/features/merchant/providers/merchant_provider.dart';
import '../../bdd_test_helper.dart';

Future<void> aSalesReceiptIsIssuedToTheCustomer(WidgetTester tester) async {
  // Verification: In success state
  final state = bddContainer.read(merchantProvider);
  expect(state.status, MerchantStatus.success);
}
