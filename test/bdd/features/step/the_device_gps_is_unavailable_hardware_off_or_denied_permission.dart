import 'package:flutter_test/flutter_test.dart';

/// Usage: the device GPS is unavailable (hardware off or denied permission)
import 'package:agentbanking_channel/features/auth/providers/auth_provider.dart';
import 'package:agentbanking_channel/features/auth/models/auth_models.dart';
import '../../bdd_test_helper.dart';
import '../../../setup/test_credentials.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/auth/providers/auth_provider.dart';
import 'package:agentbanking_channel/features/auth/models/auth_models.dart';
import '../../bdd_test_helper.dart';
import '../../../setup/test_credentials.dart';
import './the_agent_is_logged_in_with_an_active_session.dart';

Future<void> theDeviceGpsIsUnavailableHardwareOffOrDeniedPermission(WidgetTester tester) async {
  if (isRealBackend) {
    await theAgentIsLoggedInWithAnActiveSession(tester);
    // In real app we'd physically disable GPS, for BDD we keep mock geolocator failing
    mockGeolocator.shouldThrow = true;
    return;
  }
  await pumpBddApp(tester);
  mockAuthRepository.authUser = AuthUser(
    agentId: TestCredentials.username, name: 'Test Agent', tier: 'STANDARD',
    registeredLat: 3.1390, registeredLng: 101.6869,
  );
  await bddContainer.read(authProvider.notifier).loginBiometric();
  // We can't easily make getCurrentPosition throw if it's a field, 
  // but we can add a flag to FakeGeolocator.
  mockGeolocator.shouldThrow = true;
}
