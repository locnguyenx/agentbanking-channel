import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/auth/providers/auth_provider.dart';
import 'package:agentbanking_channel/features/auth/models/auth_models.dart';
import 'package:geolocator/geolocator.dart';
import '../../bdd_test_helper.dart';
import '../../../setup/test_credentials.dart';
import './the_agent_is_logged_in_with_an_active_session.dart';

Future<void> theAgentIsWithinGeofence(WidgetTester tester) async {
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
    // Also ensure current GPS is within 100m (3.1390, 101.6869)
    mockGeolocator.position = Position(
      latitude: 3.1392, longitude: 101.6871, // ~30m away
      timestamp: DateTime.now(), accuracy: 1.0, altitude: 0.0, heading: 0.0, speed: 0.0, speedAccuracy: 0.0,
      altitudeAccuracy: 0.0, headingAccuracy: 0.0,
    );
    return;
  }
  await pumpBddApp(tester);
  mockAuthRepository.authUser = AuthUser(
    agentId: TestCredentials.username, name: 'Test Agent', tier: 'STANDARD',
    registeredLat: 3.1390, registeredLng: 101.6869,
  );
  await bddContainer.read(authProvider.notifier).loginBiometric();
  mockGeolocator.position = Position(
    latitude: 3.1390, longitude: 101.6869,
    timestamp: DateTime.now(), accuracy: 1.0, altitude: 0.0, heading: 0.0, speed: 0.0, speedAccuracy: 0.0,
    altitudeAccuracy: 0.0, headingAccuracy: 0.0,
  );
}
