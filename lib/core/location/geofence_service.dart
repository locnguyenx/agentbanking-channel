import 'dart:math';

class GeofenceService {
  final double shopLat;
  final double shopLng;
  static const double _maxDistanceMeters = 100.0;

  GeofenceService({required this.shopLat, required this.shopLng});
  
  bool isWithinGeofence(double currentLat, double currentLng) {
    final distanceMeters = _haversineDistance(shopLat, shopLng, currentLat, currentLng);
    return distanceMeters <= _maxDistanceMeters;
  }

  double _haversineDistance(double lat1, double lon1, double lat2, double lon2) {
    const R = 6371000.0; // Earth radius in meters
    final phi1 = lat1 * pi / 180;
    final phi2 = lat2 * pi / 180;
    final dPhi = (lat2 - lat1) * pi / 180;
    final dLambda = (lon2 - lon1) * pi / 180;

    final a = sin(dPhi / 2) * sin(dPhi / 2) +
        cos(phi1) * cos(phi2) * sin(dLambda / 2) * sin(dLambda / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return R * c;
  }
}
