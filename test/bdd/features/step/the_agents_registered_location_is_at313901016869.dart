import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/auth/providers/auth_provider.dart';
import 'package:agentbanking_channel/features/auth/models/auth_models.dart';
import '../../bdd_test_helper.dart';
import '../../../setup/test_credentials.dart';
import './the_agent_is_logged_in_with_an_active_session.dart';

Future<void> theAgentsRegisteredLocationIsAt313901016869(WidgetTester tester) async {
  if (isRealBackend) {
    await theAgentIsLoggedInWithAnActiveSession(tester);
    final authNotifier = bddContainer.read(authProvider.notifier);
    final user = bddContainer.read(authProvider).user;
    if (user != null) {
      authNotifier.debugSetAuthenticated(user.copyWith(
        registeredLat: 3.1390,
        registeredLng: 101.6869,
      ));
    }
    return;
  }
  await pumpBddApp(tester);
  mockAuthRepository.authUser = AuthUser(
    agentId: TestCredentials.username,
    name: 'Test Agent',
    tier: 'STANDARD',
    registeredLat: 3.1390,
    registeredLng: 101.6869,
  );
  await bddContainer.read(authProvider.notifier).loginBiometric();
}
