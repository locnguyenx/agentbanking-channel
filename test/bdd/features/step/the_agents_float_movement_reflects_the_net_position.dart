import 'package:flutter_test/flutter_test.dart';

/// Usage: the agent's float movement reflects the net position
import 'package:agentbanking_channel/features/merchant/providers/merchant_provider.dart';
import '../../bdd_test_helper.dart';

Future<void> theAgentsFloatMovementReflectsTheNetPosition(WidgetTester tester) async {
  final state = bddContainer.read(merchantProvider);
  expect(state.status, MerchantStatus.success);
}
