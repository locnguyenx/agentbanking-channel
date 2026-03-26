import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/core/location/geofence_service.dart';

void main() {
  test('GeofenceService verifies if location is within boundaries', () {
    final service = GeofenceService(shopLat: 3.1390, shopLng: 101.6869);
    
    // Within 100m (approx 0.0009 degrees is ~100m at equator, 0.01 is too large, but following plan's 0.01 for now)
    // Actually, let's fix the service to use a more realistic threshold or follow the plan's 0.01 for simplicity in this step.
    expect(service.isWithinGeofence(3.1395, 101.6872), true); 
    
    // Far away (~2km)
    expect(service.isWithinGeofence(3.1500, 101.7000), false); 
  });
}
