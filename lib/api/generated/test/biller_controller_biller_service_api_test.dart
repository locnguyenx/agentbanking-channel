// @dart=2.19
import 'package:test/test.dart';
import 'package:agent_api/agent_api.dart';


/// tests for BillerControllerBillerServiceApi
void main() {
  final instance = AgentApi().getBillerControllerBillerServiceApi();

  group(BillerControllerBillerServiceApi, () {
    //Future<BuiltMap<String, JsonObject>> payBill(BuiltMap<String, JsonObject> requestBody) async
    test('test payBill', () async {
      // TODO
    });

    //Future<BuiltMap<String, JsonObject>> topup(BuiltMap<String, JsonObject> requestBody) async
    test('test topup', () async {
      // TODO
    });

  });
}
