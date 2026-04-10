import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/auth/models/auth_models.dart';
import 'package:agentbanking_channel/features/auth/providers/auth_provider.dart';
import 'package:agentbanking_channel/features/auth/repositories/auth_repository.dart';
import 'package:agent_api/agent_api.dart';
import 'package:dio/dio.dart';

import 'package:agentbanking_channel/core/security/secure_storage_manager.dart';

class FakeSecureStorageManager implements SecureStorageManager {
  final Map<String, String> _data = {};

  @override
  Future<void> saveJwt(String jwt) async => _data['agent_jwt'] = jwt;
  @override
  Future<void> clearJwt() async => _data.remove('agent_jwt');
  @override
  Future<String?> readJwt() async => _data['agent_jwt'];
  
  @override
  Future<String> getSqlCipherPassphrase() async => 'test-pass';
  
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late AuthNotifier auth;
  late AuthRepository repository;
  late FakeSecureStorageManager fakeStorage;

  setUp(() {
    fakeStorage = FakeSecureStorageManager();
    repository = AuthRepository(
      secureStorage: fakeStorage,
      authApi: AuthControllerAuthIamServiceApi(Dio(), standardSerializers),
      isDeviceWhitelisted: true,
      allowMockAuth: true,
    );
    auth = AuthNotifier(repository: repository);
  });

  group('AuthNotifier BDD Tests', () {
    test('initial state is unauthenticated', () {
      expect(auth.state.status, AuthStatus.unauthenticated);
      expect(auth.state.user, isNull);
    });

    test('loginBiometric updates state to authenticated and saves JWT', () async {
      // Given: Device is whitelisted (default in setup)
      // When: agent attempts biometric login
      await auth.loginBiometric();
      
      // Then: state is authenticated
      expect(auth.state.status, AuthStatus.authenticated);
      expect(auth.state.user?.agentId, 'BIO_USER_001');
      
      // And: JWT is saved securely
      expect(await fakeStorage.readJwt(), isNotNull);
    });

    test('loginBiometric fails if device is not whitelisted', () async {
      // Given: Device is NOT whitelisted
      final repo = AuthRepository(
        secureStorage: fakeStorage,
        authApi: AuthControllerAuthIamServiceApi(Dio(), standardSerializers),
        isDeviceWhitelisted: false,
      );
      final authNotWhite = AuthNotifier(repository: repo);
      
      // When: agent attempts biometric login
      await authNotWhite.loginBiometric();
      
      // Then: login rejected
      expect(authNotWhite.state.status, AuthStatus.failed);
      expect(authNotWhite.state.error, contains('Device not whitelisted'));
    });

    test('logout clears JWT token from secure storage', () async {
      // Given: agent is logged in
      await auth.loginBiometric();
      expect(await fakeStorage.readJwt(), isNotNull);
      
      // When: agent logs out
      await auth.logout();
      
      // Then: state is unauthenticated
      expect(auth.state.status, AuthStatus.unauthenticated);
      
      // And: JWT is deleted from secure storage
      expect(await fakeStorage.readJwt(), isNull);
    });
  });
}
