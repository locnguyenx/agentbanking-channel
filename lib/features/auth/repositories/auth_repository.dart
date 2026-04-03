import 'dart:async';
import 'package:agentbanking_channel/features/auth/models/auth_models.dart';
import 'package:agentbanking_channel/core/security/secure_storage_manager.dart';

class AuthRepository {
  final SecureStorageManager secureStorage;
  final bool isDeviceWhitelisted;

  AuthRepository({
    required this.secureStorage,
    this.isDeviceWhitelisted = true,
  }) {
    print('DEBUG: AuthRepository created');
  }

  Future<AuthUser> login(String agentId, String password) async {
    if (!isDeviceWhitelisted) {
      throw Exception('ERR_AUTH_DEVICE_NOT_WHITELISTED');
    }
    // No delay in local repository
    
    if (password == '123456') {
      final user = AuthUser(
        agentId: agentId,
        name: 'Agent $agentId',
        tier: 'STANDARD',
      );
      await secureStorage.saveJwt('mock-jwt-${user.agentId}');
      return user;
    } else {
      throw Exception('Invalid Agent ID or Password');
    }
  }

  Future<AuthUser> loginBiometric() async {
    if (!isDeviceWhitelisted) {
      throw Exception('ERR_AUTH_DEVICE_NOT_WHITELISTED');
    }
    // No delay in local repository
    final user = AuthUser(
      agentId: 'BIO_USER_001',
      name: 'Authorized Biometric User',
      tier: 'PREMIER',
    );
    await secureStorage.saveJwt('mock-jwt-${user.agentId}');
    return user;
  }
}
