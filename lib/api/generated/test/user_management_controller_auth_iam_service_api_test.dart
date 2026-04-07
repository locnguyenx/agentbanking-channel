import 'package:test/test.dart';
import 'package:agent_api/agent_api.dart';


/// tests for UserManagementControllerAuthIamServiceApi
void main() {
  final instance = AgentApi().getUserManagementControllerAuthIamServiceApi();

  group(UserManagementControllerAuthIamServiceApi, () {
    //Future<ChangePasswordResponse> changePassword(ChangePasswordRequest changePasswordRequest) async
    test('test changePassword', () async {
      // TODO
    });

    //Future<UserResponse> createAgentUser(String agentId) async
    test('test createAgentUser', () async {
      // TODO
    });

    //Future<ForgotPasswordResponse> forgotPassword(ForgotPasswordRequest forgotPasswordRequest) async
    test('test forgotPassword', () async {
      // TODO
    });

    //Future<AgentUserStatusResponse> getAgentUserStatus(String agentId) async
    test('test getAgentUserStatus', () async {
      // TODO
    });

    //Future<ResetPasswordResponse> resetPassword(ResetPasswordRequest resetPasswordRequest) async
    test('test resetPassword', () async {
      // TODO
    });

  });
}
