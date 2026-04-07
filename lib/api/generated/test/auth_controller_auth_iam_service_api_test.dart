import 'package:test/test.dart';
import 'package:agent_api/agent_api.dart';


/// tests for AuthControllerAuthIamServiceApi
void main() {
  final instance = AgentApi().getAuthControllerAuthIamServiceApi();

  group(AuthControllerAuthIamServiceApi, () {
    //Future<TokenResponse> authenticateUser(TokenRequest tokenRequest) async
    test('test authenticateUser', () async {
      // TODO
    });

    //Future<TokenResponse> refreshToken(RefreshTokenRequest refreshTokenRequest) async
    test('test refreshToken', () async {
      // TODO
    });

    //Future revokeToken(RevokeTokenRequest revokeTokenRequest) async
    test('test revokeToken', () async {
      // TODO
    });

  });
}
