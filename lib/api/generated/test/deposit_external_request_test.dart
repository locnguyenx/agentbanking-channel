import 'package:test/test.dart';
import 'package:agent_api/agent_api.dart';

// tests for DepositExternalRequest
void main() {
  final instance = DepositExternalRequestBuilder();
  // TODO add properties to the builder and call build()

  group(DepositExternalRequest, () {
    // Transaction amount in MYR
    // num amount
    test('to test the property `amount`', () async {
      // TODO
    });

    // String currency (default value: 'MYR')
    test('to test the property `currency`', () async {
      // TODO
    });

    // Unique key to prevent duplicate transactions
    // String idempotencyKey
    test('to test the property `idempotencyKey`', () async {
      // TODO
    });

    // Customer account number
    // String customerAccount
    test('to test the property `customerAccount`', () async {
      // TODO
    });

    // Customer full name
    // String customerName
    test('to test the property `customerName`', () async {
      // TODO
    });

    // GeoLocation location
    test('to test the property `location`', () async {
      // TODO
    });
  });
}
