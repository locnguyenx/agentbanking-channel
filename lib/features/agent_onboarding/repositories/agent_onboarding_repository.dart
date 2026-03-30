import 'package:agent_api/agent_api.dart';
import 'package:dio/dio.dart';

class AgentOnboardingRepository {
  final AgentControllerOnboardingServiceApi agentApi;

  AgentOnboardingRepository({required this.agentApi});

  Future<AgentResponse?> submitOnboarding({
    required String mykadNumber,
    required String ssmNumber,
    required String businessName,
    required String phoneNumber,
    double lat = 3.1390,
    double lng = 101.6869,
  }) async {
    final request = CreateAgentRequest((b) => b
      ..mykadNumber = mykadNumber
      ..agentCode = ssmNumber // Using SSM as agent code for simplification
      ..businessName = businessName
      ..phoneNumber = phoneNumber
      ..merchantGpsLat = lat
      ..merchantGpsLng = lng
      ..tier = CreateAgentRequestTierEnum.STANDARD
    );

    final response = await agentApi.createAgent(createAgentRequest: request);
    return response.data;
  }

  Future<AgentResponse?> getAgentStatus(String agentId) async {
    final response = await agentApi.getAgent(id: agentId);
    return response.data;
  }
}
