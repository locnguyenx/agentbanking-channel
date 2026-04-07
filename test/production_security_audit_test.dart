import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/auth/repositories/auth_repository.dart';
import 'package:agentbanking_channel/core/security/secure_storage_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:agent_api/agent_api.dart';

class FakeSecureStorage extends Fake implements FlutterSecureStorage {
  @override
  Future<void> write({
    required String key,
    required String? value,
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    AppleOptions? mOptions,
    WindowsOptions? wOptions,
    WebOptions? webOptions,
  }) async {}

  @override
  Future<String?> read({
    required String key,
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    AppleOptions? mOptions,
    WindowsOptions? wOptions,
    WebOptions? webOptions,
  }) async => null;

  @override
  Future<void> delete({
    required String key,
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    AppleOptions? mOptions,
    WindowsOptions? wOptions,
    WebOptions? webOptions,
  }) async {}
}

void main() {
  late AuthRepository repository;
  late SecureStorageManager storageManager;

  setUp(() {
    storageManager = SecureStorageManager(FakeSecureStorage());
    repository = AuthRepository(
      secureStorage: storageManager,
      authApi: AuthControllerAuthIamServiceApi(Dio(), standardSerializers),
    );
  });

  test('Security: 123456 bypass must be disabled', () async {
    // This test now asserts that the bypass correctly fails.
    expect(() => repository.login('AGENT001', '123456'), throwsException);
  });

  test('Security: biometric mock bypass must be disabled', () async {
    // This test now asserts that the biometric mock correctly fails.
    expect(() => repository.loginBiometric(), throwsA(anything));
  });
}
