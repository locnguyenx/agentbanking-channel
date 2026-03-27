import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:agentbanking_channel/core/security/secure_storage_manager.dart';

import 'secure_storage_manager_test.mocks.dart';

@GenerateMocks([FlutterSecureStorage])
void main() {
  late SecureStorageManager manager;
  late MockFlutterSecureStorage mockStorage;

  setUp(() {
    mockStorage = MockFlutterSecureStorage();
    manager = SecureStorageManager(mockStorage);
  });

  group('SecureStorageManager - SQLCipher Passphrase', () {
    test('returns existing passphrase if it exists in storage', () async {
      when(mockStorage.read(key: 'sqlcipher_passphrase'))
          .thenAnswer((_) async => 'existing_secret');

      final passphrase = await manager.getSqlCipherPassphrase();

      expect(passphrase, equals('existing_secret'));
      verify(mockStorage.read(key: 'sqlcipher_passphrase')).called(1);
    });

    test('generates and saves new passphrase if none exists', () async {
      when(mockStorage.read(key: 'sqlcipher_passphrase'))
          .thenAnswer((_) async => null);
      
      final passphrase = await manager.getSqlCipherPassphrase();

      expect(passphrase, isNotNull);
      expect(passphrase.length, greaterThanOrEqualTo(32));
      verify(mockStorage.write(key: 'sqlcipher_passphrase', value: passphrase)).called(1);
    });
  });
}
