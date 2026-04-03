import 'package:test/test.dart';
import 'package:agent_api/agent_api.dart';

/// tests for LedgerControllerLedgerServiceApi
void main() {
  final instance = AgentApi().getLedgerControllerLedgerServiceApi();

  group(LedgerControllerLedgerServiceApi, () {
    //Future<BuiltMap<String, JsonObject>> balanceInquiry(BalanceInquiryRequest balanceInquiryRequest) async
    test('test balanceInquiry', () async {
      // TODO
    });

    //Future<BuiltMap<String, JsonObject>> credit(DepositRequest depositRequest) async
    test('test credit', () async {
      // TODO
    });

    //Future<BuiltMap<String, JsonObject>> debit(WithdrawalRequest withdrawalRequest) async
    test('test debit', () async {
      // TODO
    });

    //Future<BuiltMap<String, JsonObject>> getBalance(String agentId) async
    test('test getBalance', () async {
      // TODO
    });

    //Future<BuiltMap<String, JsonObject>> getDashboard() async
    test('test getDashboard', () async {
      // TODO
    });

    //Future<BuiltMap<String, JsonObject>> getSettlement(String date) async
    test('test getSettlement', () async {
      // TODO
    });

    //Future<BuiltMap<String, JsonObject>> getTransactions({ int page, int size }) async
    test('test getTransactions', () async {
      // TODO
    });
  });
}
