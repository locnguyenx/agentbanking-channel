import 'package:test/test.dart';
import 'package:agent_api/agent_api.dart';


/// tests for SwitchControllerSwitchAdapterServiceApi
void main() {
  final instance = AgentApi().getSwitchControllerSwitchAdapterServiceApi();

  group(SwitchControllerSwitchAdapterServiceApi, () {
    // **DEPRECATED** - Use `POST /api/v1/transactions` with `transactionType: DUITNOW_TRANSFER` instead. This endpoint will be removed in a future version. See [API Changelog](/docs/api/CHANGELOG-2026-04-05-transaction-orchestrator.md) for migration guide. 
    //
    //Future<TransactionResponse> duitNowTransfer(DuitNowRequest duitNowRequest) async
    test('test duitNowTransfer', () async {
      // TODO
    });

  });
}
