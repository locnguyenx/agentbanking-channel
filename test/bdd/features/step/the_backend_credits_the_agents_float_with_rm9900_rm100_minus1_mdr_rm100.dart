import 'package:flutter_test/flutter_test.dart';

/// Usage: the backend credits the agent's float with RM 99.00 (RM 100 minus 1% MDR = RM 1.00)
import 'package:agentbanking_channel/features/merchant/providers/merchant_provider.dart';
import 'package:agentbanking_channel/features/merchant/models/merchant_models.dart';
import 'package:decimal/decimal.dart';
import '../../bdd_test_helper.dart';

Future<void> theBackendCreditsTheAgentsFloatWithRm9900Rm100Minus1MdrRm100(WidgetTester tester) async {
  final state = bddContainer.read(merchantProvider);
  expect(state.status, MerchantStatus.success);
  final result = state.result as RetailSaleResponse;
  expect(result.floatCreditAmount, Decimal.parse('99.00'));
  expect(result.mdrAmount, Decimal.parse('1.00'));
}
