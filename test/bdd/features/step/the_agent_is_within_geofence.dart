import 'package:flutter_test/flutter_test.dart';

/// Usage: the agent is within geofence
import '../../bdd_test_helper.dart';
import 'package:agentbanking_channel/features/auth/providers/auth_provider.dart';
import 'package:agentbanking_channel/features/auth/models/auth_models.dart';
import 'package:geolocator/geolocator.dart';

Future<void> theAgentIsWithinGeofence(WidgetTester tester) async {
  await pumpBddApp(tester);
  mockAuthRepository.authUser = AuthUser(
    agentId: 'AGENT-001', name: 'Test Agent', tier: 'STANDARD',
    registeredLat: 3.1390, registeredLng: 101.6869,
  );
  await bddContainer.read(authProvider.notifier).loginBiometric();
  mockGeolocator.position = Position(
    latitude: 3.1390, longitude: 101.6869,
    timestamp: DateTime.now(), accuracy: 1.0, altitude: 0.0, heading: 0.0, speed: 0.0, speedAccuracy: 0.0,
    altitudeAccuracy: 0.0, headingAccuracy: 0.0,
  );
}
