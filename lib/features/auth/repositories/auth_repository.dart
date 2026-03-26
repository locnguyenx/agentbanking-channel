import 'dart:async';
import 'package:agentbanking_channel/features/auth/models/auth_models.dart';

class AuthRepository {
  Future<AuthUser> login(String agentId, String password) async {
    // Simulated API call
    await Future.delayed(const Duration(seconds: 1));
    
    // Simple validation for mock
    if (password == '123456') {
      return AuthUser(
        agentId: agentId,
        name: 'Agent $agentId',
        tier: 'STANDARD',
      );
    } else {
      throw Exception('Invalid Agent ID or Password');
    }
  }

  Future<AuthUser> loginBiometric() async {
    // Simulated biometric success
    await Future.delayed(const Duration(milliseconds: 500));
    return AuthUser(
      agentId: 'AGENT_BIO_01',
      name: 'Biometric Agent',
      tier: 'PREMIER',
    );
  }
}
