import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:agentbanking_channel/core/network/auth_interceptor.dart';
import 'package:agentbanking_channel/core/security/secure_storage_manager.dart';

class FakeSecureStorage extends Fake implements SecureStorageManager {
  final String? mockJwt;
  FakeSecureStorage({this.mockJwt});

  @override
  Future<String?> readJwt() async => mockJwt;
}

void main() {
  group('AuthInterceptor Tests', () {
    test('adds Authorization header when JWT is present', () async {
      final storage = FakeSecureStorage(mockJwt: 'test-token-123');
      final interceptor = AuthInterceptor(storage);
      final options = RequestOptions(path: '/test');
      
      final handler = RequestInterceptorHandler();
      await interceptor.onRequest(options, handler);
      
      expect(options.headers['Authorization'], 'Bearer test-token-123');
    });

    test('does not add Authorization header when JWT is missing', () async {
      final storage = FakeSecureStorage(mockJwt: null);
      final interceptor = AuthInterceptor(storage);
      final options = RequestOptions(path: '/test');
      
      final handler = RequestInterceptorHandler();
      await interceptor.onRequest(options, handler);
      
      expect(options.headers.containsKey('Authorization'), isFalse);
    });

    test('does not add Authorization header when JWT is empty', () async {
      final storage = FakeSecureStorage(mockJwt: '');
      final interceptor = AuthInterceptor(storage);
      final options = RequestOptions(path: '/test');
      
      final handler = RequestInterceptorHandler();
      await interceptor.onRequest(options, handler);
      
      expect(options.headers.containsKey('Authorization'), isFalse);
    });
  });
}
