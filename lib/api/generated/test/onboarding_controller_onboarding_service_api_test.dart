// @dart=2.19
import 'package:test/test.dart';
import 'package:agent_api/agent_api.dart';


/// tests for OnboardingControllerOnboardingServiceApi
void main() {
  final instance = AgentApi().getOnboardingControllerOnboardingServiceApi();

  group(OnboardingControllerOnboardingServiceApi, () {
    //Future<BuiltMap<String, JsonObject>> biometricMatch(BuiltMap<String, String> requestBody) async
    test('test biometricMatch', () async {
      // TODO
    });

    //Future<BuiltMap<String, JsonObject>> getKycReviewQueue({ int page, int size }) async
    test('test getKycReviewQueue', () async {
      // TODO
    });

    //Future<BuiltMap<String, JsonObject>> verifyMyKad(BuiltMap<String, String> requestBody) async
    test('test verifyMyKad', () async {
      // TODO
    });

  });
}
