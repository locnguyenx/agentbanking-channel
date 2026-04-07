import 'package:dio/dio.dart';
import 'package:agentbanking_channel/core/security/secure_storage_manager.dart';

class AuthInterceptor extends Interceptor {
  final SecureStorageManager _storage;

  AuthInterceptor(this._storage);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final jwt = await _storage.readJwt();
    if (jwt != null && jwt.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $jwt';
    }
    
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // In a real app, we might trigger a logout or token refresh here
      // via a broadcast or callback to AuthProvider
    }
    return handler.next(err);
  }
}
