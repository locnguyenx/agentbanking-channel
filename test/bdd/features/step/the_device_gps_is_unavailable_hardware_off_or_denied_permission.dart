import 'package:flutter_test/flutter_test.dart';

/// Usage: the device GPS is unavailable (hardware off or denied permission)
import 'package:agentbanking_channel/features/auth/providers/auth_provider.dart';
import 'package:agentbanking_channel/features/auth/models/auth_models.dart';
import '../../bdd_test_helper.dart';

Future<void> theDeviceGpsIsUnavailableHardwareOffOrDeniedPermission(WidgetTester tester) async {
  await pumpBddApp(tester);
  mockAuthRepository.authUser = AuthUser(
    agentId: 'AGENT-001', name: 'Test Agent', tier: 'STANDARD',
    registeredLat: 3.1390, registeredLng: 101.6869,
  );
  await bddContainer.read(authProvider.notifier).loginBiometric();
  // We can't easily make getCurrentPosition throw if it's a field, 
  // but we can add a flag to FakeGeolocator.
  mockGeolocator.shouldThrow = true;
}
