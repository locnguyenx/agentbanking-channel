import 'dart:convert';
import 'package:agent_api/agent_api.dart';
import 'package:agentbanking_channel/features/auth/models/auth_models.dart';
import 'package:agentbanking_channel/core/security/secure_storage_manager.dart';

class AuthRepository {
  final SecureStorageManager secureStorage;
  final AuthControllerAuthIamServiceApi authApi;
  final bool isDeviceWhitelisted;
  final bool allowMockAuth;

  AuthRepository({
    required this.secureStorage,
    required this.authApi,
    this.isDeviceWhitelisted = true,
    this.allowMockAuth = false,
  }) {
    print('DEBUG: AuthRepository created');
  }

  Future<AuthUser> login(String agentId, String password) async {
    if (!isDeviceWhitelisted) {
      throw Exception('ERR_AUTH_DEVICE_NOT_WHITELISTED');
    }
    
    const isEnvMock = bool.fromEnvironment('IS_MOCK_AUTH', defaultValue: false);
    const isRealBackend = bool.fromEnvironment('USE_REAL_BACKEND', defaultValue: false);
    
    if (!isRealBackend && (isEnvMock || allowMockAuth) && password == '123456') {
      final user = AuthUser(
        agentId: agentId,
        name: 'Agent $agentId',
        tier: 'STANDARD',
      );
      await secureStorage.saveJwt('mock-jwt-${user.agentId}');
      return user;
    }

    // Real API Call
    final request = TokenRequest((b) => b
      ..username = agentId
      ..password = password
      ..grantType = TokenRequestGrantTypeEnum.password
    );

    print('DEBUG: AuthRepository calling authenticateUser (real API)');
    try {
      final response = await authApi.authenticateUser(tokenRequest: request);
      print('DEBUG: AuthRepository received response: status=${response.statusCode}');
      final tokenData = response.data;
    
      if (tokenData == null || tokenData.accessToken == null) {
        throw Exception('Authentication failed: Missing token in response');
      }

      final String token = tokenData.accessToken!;
      await secureStorage.saveJwt(token);
      
      // Decode JWT to get real agentId (UUID)
      String effectiveAgentId = agentId;
      try {
        final parts = token.split('.');
        if (parts.length == 3) {
          final payload = utf8.decode(base64Url.decode(base64.normalize(parts[1])));
          final Map<String, dynamic> data = json.decode(payload);
          // Backend uses 'agent_id' or 'sub' for the UUID
          effectiveAgentId = data['agent_id'] ?? data['sub'] ?? agentId;
          print('DEBUG: Extracted effectiveAgentId from JWT: $effectiveAgentId');
        }
      } catch (e) {
        print('DEBUG: Failed to decode JWT: $e');
      }
      
      return AuthUser(
        agentId: effectiveAgentId,
        name: 'Agent $agentId',
        tier: 'PRO', // Default for live backend
      );
    } catch (e, stack) {
      print('DEBUG: AuthRepository.login ERROR: $e');
      print('DEBUG: AuthRepository.login STACK: $stack');
      rethrow;
    }
  }

  Future<AuthUser> loginBiometric() async {
    if (!isDeviceWhitelisted) {
      throw Exception('ERR_AUTH_DEVICE_NOT_WHITELISTED');
    }
    
    const isEnvMock = bool.fromEnvironment('IS_MOCK_AUTH', defaultValue: false);
    const isRealBackend = bool.fromEnvironment('USE_REAL_BACKEND', defaultValue: false);

    if (!isRealBackend && (isEnvMock || allowMockAuth)) {
      final user = AuthUser(
        agentId: 'BIO_USER_001',
        name: 'Authorized Biometric User',
        tier: 'PREMIER',
      );
      await secureStorage.saveJwt('mock-jwt-${user.agentId}');
      return user;
    }
    
    throw UnimplementedError('Real Biometric login not yet implemented on backend');
  }
}
