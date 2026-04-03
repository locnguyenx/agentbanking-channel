import 'package:flutter_test/flutter_test.dart';

/// Usage: the customer wants to buy RM 20 of goods AND get RM 50 cash_back
import 'package:agentbanking_channel/features/merchant/providers/merchant_provider.dart';
import 'package:decimal/decimal.dart';
import '../../bdd_test_helper.dart';

import './the_agent_is_logged_in_with_an_active_session.dart';

Future<void> theCustomerWantsToBuyRm20OfGoodsAndGetRm50CashBack(WidgetTester tester) async {
  await theAgentIsLoggedInWithAnActiveSession(tester);
  final notifier = bddContainer.read(merchantProvider.notifier);
  await notifier.startCashback(Decimal.fromInt(20), Decimal.fromInt(50));
}
