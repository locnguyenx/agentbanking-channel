import 'package:flutter_test/flutter_test.dart';

/// Usage: the agent enters "Merchant Mode" on the POS
import 'package:agentbanking_channel/features/merchant/providers/merchant_provider.dart';
import '../../bdd_test_helper.dart';

Future<void> theAgentEntersMerchantModeOnThePos(WidgetTester tester) async {
  await pumpBddApp(tester);
  bddContainer.read(merchantProvider.notifier).reset();
}
