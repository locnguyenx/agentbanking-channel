import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';

class GpsInterceptor extends Interceptor {
  final GeolocatorPlatform? _geolocator;

  GpsInterceptor({GeolocatorPlatform? geolocator})
      : _geolocator = geolocator;

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      final geolocator = _geolocator ?? GeolocatorPlatform.instance;
      final position = await geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.high, timeLimit: Duration(seconds: 10)),
      );
      
      options.headers['X-GPS-Latitude'] = position.latitude.toStringAsFixed(6);
      options.headers['X-GPS-Longitude'] = position.longitude.toStringAsFixed(6);
    } catch (e) {
      // US-CA-02: Strict geofence enforcement. Block request if GPS unavailable.
      throw DioException(
        requestOptions: options,
        error: 'ERR_VAL_GPS_UNAVAILABLE',
        type: DioExceptionType.cancel,
      );
    }
    super.onRequest(options, handler);
  }
}
