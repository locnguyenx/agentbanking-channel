import 'dart:math';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageManager {
  final FlutterSecureStorage _storage;
  static const String _sqlCipherPassphraseKey = 'sqlcipher_passphrase';

  SecureStorageManager(this._storage);

  Future<String> getSqlCipherPassphrase() async {
    String? passphrase = await _storage.read(key: _sqlCipherPassphraseKey);
    
    if (passphrase == null) {
      passphrase = _generateRandomPassphrase();
      await _storage.write(key: _sqlCipherPassphraseKey, value: passphrase);
    }
    
    return passphrase;
  }

  String _generateRandomPassphrase() {
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#%^&*()-_=+';
    final random = Random.secure();
    return List.generate(32, (index) => chars[random.nextInt(chars.length)]).join();
  }
}
