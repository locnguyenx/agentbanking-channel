import 'package:test/test.dart';
import 'package:agent_api/agent_api.dart';


/// tests for AuditLogControllerOnboardingServiceApi
void main() {
  final instance = AgentApi().getAuditLogControllerOnboardingServiceApi();

  group(AuditLogControllerOnboardingServiceApi, () {
    //Future<BuiltMap<String, JsonObject>> getAuditLogs({ String entityType, DateTime fromDate, DateTime toDate, int page, int size }) async
    test('test getAuditLogs', () async {
      // TODO
    });

  });
}
