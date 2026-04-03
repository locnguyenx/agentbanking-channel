import 'package:test/test.dart';
import 'package:agent_api/agent_api.dart';

// tests for JomPayExternalRequest
void main() {
  final instance = JomPayExternalRequestBuilder();
  // TODO add properties to the builder and call build()

  group(JomPayExternalRequest, () {
    // JomPay biller code
    // String billerCode
    test('to test the property `billerCode`', () async {
      // TODO
    });

    // JomPay reference 1 (bill account)
    // String ref1
    test('to test the property `ref1`', () async {
      // TODO
    });

    // JomPay reference 2 (optional)
    // String ref2
    test('to test the property `ref2`', () async {
      // TODO
    });

    // Payment amount in MYR
    // num amount
    test('to test the property `amount`', () async {
      // TODO
    });

    // String currency (default value: 'MYR')
    test('to test the property `currency`', () async {
      // TODO
    });

    // String idempotencyKey
    test('to test the property `idempotencyKey`', () async {
      // TODO
    });

    // String customerMobile
    test('to test the property `customerMobile`', () async {
      // TODO
    });
  });
}
