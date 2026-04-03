import 'package:flutter_test/flutter_test.dart';

/// Usage: the agent is in Merchant Mode
import 'package:agentbanking_channel/features/merchant/providers/merchant_provider.dart';
import '../../bdd_test_helper.dart';

Future<void> theAgentIsInMerchantMode(WidgetTester tester) async {
  await pumpBddApp(tester, isAuthenticated: true);
  await tester.pumpAndSettle();
  bddContainer.read(merchantProvider.notifier).reset();
}
