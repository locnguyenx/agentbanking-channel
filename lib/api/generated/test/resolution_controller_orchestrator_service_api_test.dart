import 'package:test/test.dart';
import 'package:agent_api/agent_api.dart';


/// tests for ResolutionControllerOrchestratorServiceApi
void main() {
  final instance = AgentApi().getResolutionControllerOrchestratorServiceApi();

  group(ResolutionControllerOrchestratorServiceApi, () {
    // Checker approves proposed resolution
    //
    // Second step in four-eyes approval - checker approves the maker's proposal
    //
    //Future<ResolutionResponse> checkerApproveResolution(String workflowId, CheckerActionRequest checkerActionRequest) async
    test('test checkerApproveResolution', () async {
      // TODO
    });

    // Checker rejects proposed resolution
    //
    // Second step in four-eyes approval - checker rejects the maker's proposal, returning to maker
    //
    //Future<ResolutionResponse> checkerRejectResolution(String workflowId, CheckerActionRequest checkerActionRequest) async
    test('test checkerRejectResolution', () async {
      // TODO
    });

    // Maker proposes resolution for a transaction
    //
    // First step in four-eyes approval - maker proposes an action (COMMIT, ROLLBACK, ESCALATE)
    //
    //Future<ResolutionResponse> makerProposeResolution(String workflowId, MakerProposalRequest makerProposalRequest) async
    test('test makerProposeResolution', () async {
      // TODO
    });

  });
}
