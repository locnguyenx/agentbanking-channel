import 'package:flutter_test/flutter_test.dart';

/// Usage: a combined Sales + Cash_Back Receipt is issued
import 'package:agentbanking_channel/features/merchant/providers/merchant_provider.dart';
import '../../bdd_test_helper.dart';

Future<void> aCombinedSalesCashBackReceiptIsIssued(WidgetTester tester) async {
  final state = bddContainer.read(merchantProvider);
  expect(state.status, MerchantStatus.success);
}
