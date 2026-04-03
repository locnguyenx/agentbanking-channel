import 'package:test/test.dart';
import 'package:agent_api/agent_api.dart';

/// tests for AgentControllerOnboardingServiceApi
void main() {
  final instance = AgentApi().getAgentControllerOnboardingServiceApi();

  group(AgentControllerOnboardingServiceApi, () {
    //Future<AgentResponse> createAgent(CreateAgentRequest createAgentRequest) async
    test('test createAgent', () async {
      // TODO
    });

    //Future deactivateAgent(String id) async
    test('test deactivateAgent', () async {
      // TODO
    });

    //Future<AgentResponse> getAgent(String id) async
    test('test getAgent', () async {
      // TODO
    });

    //Future<BuiltList<AgentResponse>> listAgents({ int page, int size }) async
    test('test listAgents', () async {
      // TODO
    });

    //Future<AgentResponse> updateAgent(String id, UpdateAgentRequest updateAgentRequest) async
    test('test updateAgent', () async {
      // TODO
    });
  });
}
