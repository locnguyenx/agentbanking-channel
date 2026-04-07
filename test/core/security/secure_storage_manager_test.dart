import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/core/security/secure_storage_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FakeFlutterSecureStorage extends Fake implements FlutterSecureStorage {
  final Map<String, String> _data = {};

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
  }) async {
    if (value == null) {
      _data.remove(key);
    } else {
      _data[key] = value;
    }
  }

  @override
  Future<String?> read({
    required String key,
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    AppleOptions? mOptions,
    WindowsOptions? wOptions,
    WebOptions? webOptions,
  }) async {
    return _data[key];
  }

  @override
  Future<void> delete({
    required String key,
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    AppleOptions? mOptions,
    WindowsOptions? wOptions,
    WebOptions? webOptions,
  }) async {
    _data.remove(key);
  }
}

void main() {
  late FakeFlutterSecureStorage fakeStorage;
  late SecureStorageManager manager;

  setUp(() {
    fakeStorage = FakeFlutterSecureStorage();
    manager = SecureStorageManager(fakeStorage);
  });

  group('SecureStorageManager', () {
    test('saveJwt writes to correct key', () async {
      await manager.saveJwt('test-jwt');
      expect(await fakeStorage.read(key: 'agent_jwt'), 'test-jwt');
    });

    test('readJwt reads from correct key', () async {
      await fakeStorage.write(key: 'agent_jwt', value: 'read-jwt');
      final result = await manager.readJwt();
      expect(result, 'read-jwt');
    });

    test('clearJwt deletes correct key', () async {
      await fakeStorage.write(key: 'agent_jwt', value: 'to-be-deleted');
      await manager.clearJwt();
      expect(await fakeStorage.read(key: 'agent_jwt'), null);
    });

    test('getSqlCipherPassphrase generates and persists passphrase', () async {
      final p1 = await manager.getSqlCipherPassphrase();
      expect(p1, isNotEmpty);
      expect(p1.length, 32);

      final p2 = await manager.getSqlCipherPassphrase();
      expect(p1, p2); // Should be persisted
    });
  });
}
