import 'package:test/test.dart';
import 'package:agent_api/agent_api.dart';


/// tests for MerchantControllerLedgerServiceApi
void main() {
  final instance = AgentApi().getMerchantControllerLedgerServiceApi();

  group(MerchantControllerLedgerServiceApi, () {
    //Future<CashBackResponse> processCashBack(CashBackCommand cashBackCommand) async
    test('test processCashBack', () async {
      // TODO
    });

    //Future<PinPurchaseResponse> processPinPurchase(PinPurchaseCommand pinPurchaseCommand) async
    test('test processPinPurchase', () async {
      // TODO
    });

    //Future<RetailSaleResponse> processRetailSale(RetailSaleCommand retailSaleCommand) async
    test('test processRetailSale', () async {
      // TODO
    });

  });
}
