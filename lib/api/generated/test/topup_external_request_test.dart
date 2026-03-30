import 'package:test/test.dart';
import 'package:agent_api/agent_api.dart';

// tests for TopupExternalRequest
void main() {
  final instance = TopupExternalRequestBuilder();
  // TODO add properties to the builder and call build()

  group(TopupExternalRequest, () {
    // Telco provider
    // String telco
    test('to test the property `telco`', () async {
      // TODO
    });

    // Mobile number (MSISDN format)
    // String phoneNumber
    test('to test the property `phoneNumber`', () async {
      // TODO
    });

    // Top-up amount in MYR
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

  });
}
