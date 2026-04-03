import 'package:test/test.dart';
import 'package:agent_api/agent_api.dart';

// tests for EWalletWithdrawExternalRequest
void main() {
  final instance = EWalletWithdrawExternalRequestBuilder();
  // TODO add properties to the builder and call build()

  group(EWalletWithdrawExternalRequest, () {
    // E-wallet provider
    // String walletProvider
    test('to test the property `walletProvider`', () async {
      // TODO
    });

    // E-wallet account ID
    // String walletAccountId
    test('to test the property `walletAccountId`', () async {
      // TODO
    });

    // Withdrawal amount in MYR
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

    // Customer card for card-based withdrawal
    // String customerCard
    test('to test the property `customerCard`', () async {
      // TODO
    });

    // String customerPin
    test('to test the property `customerPin`', () async {
      // TODO
    });
  });
}
