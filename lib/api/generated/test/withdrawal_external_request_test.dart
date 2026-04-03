import 'package:test/test.dart';
import 'package:agent_api/agent_api.dart';

// tests for WithdrawalExternalRequest
void main() {
  final instance = WithdrawalExternalRequestBuilder();
  // TODO add properties to the builder and call build()

  group(WithdrawalExternalRequest, () {
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

    // Customer card number (PAN)
    // String customerCard
    test('to test the property `customerCard`', () async {
      // TODO
    });

    // Customer PIN (4-6 digits)
    // String customerPin
    test('to test the property `customerPin`', () async {
      // TODO
    });

    // GeoLocation location
    test('to test the property `location`', () async {
      // TODO
    });
  });
}
