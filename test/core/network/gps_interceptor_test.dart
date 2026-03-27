import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:agentbanking_channel/core/network/gps_interceptor.dart';

import 'gps_interceptor_test.mocks.dart';

@GenerateMocks([GeolocatorPlatform, Position])
void main() {
  late GpsInterceptor interceptor;
  late MockGeolocatorPlatform mockGeolocator;

  setUp(() {
    mockGeolocator = MockGeolocatorPlatform();
    interceptor = GpsInterceptor(geolocator: mockGeolocator);
  });

  test('adds X-GPS headers to the request', () async {
    final mockPosition = MockPosition();
    when(mockPosition.latitude).thenReturn(3.1390);
    when(mockPosition.longitude).thenReturn(101.6869);
    
    when(mockGeolocator.getCurrentPosition(
      locationSettings: anyNamed('locationSettings'),
    )).thenAnswer((_) async => mockPosition);

    final options = RequestOptions(path: '/test');
    final handler = RequestInterceptorHandler();

    await interceptor.onRequest(options, handler);

    expect(options.headers['X-GPS-Latitude'], equals('3.1390'));
    expect(options.headers['X-GPS-Longitude'], equals('101.6869'));
  });
}
