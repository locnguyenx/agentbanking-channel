import 'package:test/test.dart';
import 'package:agent_api/agent_api.dart';

/// tests for ReconciliationControllerLedgerServiceApi
void main() {
  final instance = AgentApi().getReconciliationControllerLedgerServiceApi();

  group(ReconciliationControllerLedgerServiceApi, () {
    //Future<BuiltMap<String, JsonObject>> checkerApprove(String caseId, BuiltMap<String, JsonObject> requestBody) async
    test('test checkerApprove', () async {
      // TODO
    });

    //Future<BuiltMap<String, JsonObject>> checkerReject(String caseId, BuiltMap<String, JsonObject> requestBody) async
    test('test checkerReject', () async {
      // TODO
    });

    //Future<BuiltMap<String, JsonObject>> makerPropose(String caseId, BuiltMap<String, JsonObject> requestBody) async
    test('test makerPropose', () async {
      // TODO
    });
  });
}
