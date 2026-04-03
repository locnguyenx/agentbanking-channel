import 'package:flutter_test/flutter_test.dart';
import '../../bdd_test_helper.dart';
import 'package:geolocator/geolocator.dart';

/// Usage: the device GPS shows (3.1500, 101.7000)
Future<void> theDeviceGpsShows315001017000(WidgetTester tester) async {
  mockGeolocator.position = Position(
    latitude: 3.1500, longitude: 101.7000,
    timestamp: DateTime.now(), accuracy: 1.0, altitude: 0.0, heading: 0.0, speed: 0.0, speedAccuracy: 0.0,
    altitudeAccuracy: 0.0, headingAccuracy: 0.0,
  );
}
