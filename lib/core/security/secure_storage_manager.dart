import 'dart:math';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageManager {
  final FlutterSecureStorage _storage;
  static const String _sqlCipherPassphraseKey = 'sqlcipher_passphrase';

  static const String _jwtKey = 'agent_jwt';

  SecureStorageManager(this._storage);

  Future<void> saveJwt(String jwt) async =>
      await _storage.write(key: _jwtKey, value: jwt);

  Future<void> clearJwt() async =>
      await _storage.delete(key: _jwtKey);

  Future<String?> readJwt() async =>
      await _storage.read(key: _jwtKey);

  // Generic storage methods for other services (e.g. Compliance)
  Future<void> write(String key, String value) async =>
      await _storage.write(key: key, value: value);

  Future<String?> read(String key) async =>
      await _storage.read(key: key);

  Future<void> delete(String key) async =>
      await _storage.delete(key: key);

  static const String _complianceLockKey = 'compliance_locked';

  Future<void> setComplianceLock(bool isLocked) async =>
      await _storage.write(key: _complianceLockKey, value: isLocked.toString());

  Future<bool> getComplianceLocked() async {
    final val = await _storage.read(key: _complianceLockKey);
    return val == 'true';
  }

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
