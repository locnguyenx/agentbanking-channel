import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final _storage = const FlutterSecureStorage();
  final Map<String, String> _mockStorage = {}; // For testing/simpler environments

  Future<void> write(String key, String value) async {
    _mockStorage[key] = value;
    // In real env, await _storage.write(key: key, value: value);
  }

  Future<String?> read(String key) async {
    return _mockStorage[key];
  }

  Future<void> delete(String key) async {
    _mockStorage.remove(key);
  }

  Future<void> saveToken(String token) async => write('auth_token', token);
  Future<String?> getToken() async => read('auth_token');
  Future<void> clearAll() async => _mockStorage.clear();
}
