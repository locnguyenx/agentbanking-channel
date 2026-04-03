import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/core/location/geofence_service.dart';

void main() {
  group('GeofenceService', () {
    // BDD @US-CA-02 @FR-CA-1.2: Geofence within 100m
    test('allows transaction when GPS is within 100m of registered location', () {
      // Given: registered at (3.1390, 101.6869) — BDD exact coordinates
      final svc = GeofenceService(shopLat: 3.1390, shopLng: 101.6869);
      
      // When: device GPS shows (3.1395, 101.6872) — ~68m away according to Haversine
      // Then: geofence check passes
      expect(svc.isWithinGeofence(3.1395, 101.6872), isTrue);
    });

    test('blocks transaction when GPS is outside 100m of registered location', () {
      // Given: registered at (3.1390, 101.6869)
      final svc = GeofenceService(shopLat: 3.1390, shopLng: 101.6869);
      
      // When: device GPS shows (3.1500, 101.7000) — ~1.6km away
      // Then: geofence check fails
      expect(svc.isWithinGeofence(3.1500, 101.7000), isFalse);
    });

    test('blocks transaction when GPS is 550m away (should fail 100m limit)', () {
      // Given: registered at (3.1390, 101.6869)
      final svc = GeofenceService(shopLat: 3.1390, shopLng: 101.6869);
      
      // When: device GPS is approx 0.005 degrees away (~550m)
      const mediumLat = 3.1440; // +0.005
      const mediumLng = 101.6869;
      
      // Then: geofence check should fail (but currently passes because threshold is 0.01)
      expect(svc.isWithinGeofence(mediumLat, mediumLng), isFalse);
    });
  });
}
