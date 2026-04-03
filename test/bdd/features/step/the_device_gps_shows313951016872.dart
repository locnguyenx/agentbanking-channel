import 'package:flutter_test/flutter_test.dart';

/// Usage: the device GPS shows (3.1395, 101.6872)
import '../../bdd_test_helper.dart';
import 'package:geolocator/geolocator.dart';

Future<void> theDeviceGpsShows313951016872(WidgetTester tester) async {
  mockGeolocator.position = Position(
    latitude: 3.1395, longitude: 101.6872,
    timestamp: DateTime.now(), accuracy: 1.0, altitude: 0.0, heading: 0.0, speed: 0.0, speedAccuracy: 0.0,
    altitudeAccuracy: 0.0, headingAccuracy: 0.0,
  );
}
