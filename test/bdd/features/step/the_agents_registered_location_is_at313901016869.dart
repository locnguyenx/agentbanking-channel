import 'package:flutter_test/flutter_test.dart';

/// Usage: the agent's registered location is at (3.1390, 101.6869)
import 'package:agentbanking_channel/features/auth/providers/auth_provider.dart';
import '../../bdd_test_helper.dart';
import 'package:agentbanking_channel/features/auth/models/auth_models.dart';

Future<void> theAgentsRegisteredLocationIsAt313901016869(WidgetTester tester) async {
  await pumpBddApp(tester);
  mockAuthRepository.authUser = AuthUser(
    agentId: 'AGENT-001',
    name: 'Test Agent',
    tier: 'STANDARD',
    registeredLat: 3.1390,
    registeredLng: 101.6869,
  );
  await bddContainer.read(authProvider.notifier).loginBiometric();
}
