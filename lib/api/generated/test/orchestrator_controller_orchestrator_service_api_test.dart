import 'package:test/test.dart';
import 'package:agent_api/agent_api.dart';


/// tests for OrchestratorControllerOrchestratorServiceApi
void main() {
  final instance = AgentApi().getOrchestratorControllerOrchestratorServiceApi();

  group(OrchestratorControllerOrchestratorServiceApi, () {
    // Force resolve a stuck transaction workflow
    //
    // Admin operation to manually resolve a stuck or failed workflow. Requires admin credentials.
    //
    //Future<ForceResolveTransaction200Response> forceResolveTransaction(String workflowId, ForceResolveRequest forceResolveRequest) async
    test('test forceResolveTransaction', () async {
      // TODO
    });

    // Get transaction workflow status
    //
    // Poll the status of a previously started transaction workflow.
    //
    //Future<TransactionStatusResponse> getTransactionStatus(String workflowId) async
    test('test getTransactionStatus', () async {
      // TODO
    });

    // Start a new transaction via Temporal SAGA orchestration
    //
    // Initiates a transaction workflow (withdrawal, deposit, bill payment, or DuitNow transfer) using Temporal durable execution. Returns a workflow ID for polling status.
    //
    //Future<TransactionStartResponse> startTransaction(TransactionStartRequest transactionStartRequest) async
    test('test startTransaction', () async {
      // TODO
    });

  });
}
