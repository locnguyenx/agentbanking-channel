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
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
      );
      
      options.headers['X-GPS-Latitude'] = position.latitude.toStringAsFixed(6);
      options.headers['X-GPS-Longitude'] = position.longitude.toStringAsFixed(6);
    } catch (e) {
      // If GPS fails, we still proceed but without headers, 
      // or we could throw an error if mandatory.
      // The backend will reject if headers are missing.
    }
    super.onRequest(options, handler);
  }
}
