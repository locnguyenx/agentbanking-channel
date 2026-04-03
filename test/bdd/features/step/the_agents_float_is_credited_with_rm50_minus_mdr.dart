import 'package:flutter_test/flutter_test.dart';

/// Usage: the agent's float is credited with RM 50 minus MDR
import 'package:agentbanking_channel/features/merchant/providers/merchant_provider.dart';
import 'package:agentbanking_channel/features/merchant/models/merchant_models.dart';
import 'package:decimal/decimal.dart';
import '../../bdd_test_helper.dart';

Future<void> theAgentsFloatIsCreditedWithRm50MinusMdr(WidgetTester tester) async {
  final state = bddContainer.read(merchantProvider);
  expect(state.status, MerchantStatus.success);
  final result = state.result as RetailSaleResponse;
  expect(result.floatCreditAmount, Decimal.parse('49.75'));
}
