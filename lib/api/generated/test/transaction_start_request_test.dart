import 'package:test/test.dart';
import 'package:agent_api/agent_api.dart';

// tests for TransactionStartRequest
void main() {
  final instance = TransactionStartRequestBuilder();
  // TODO add properties to the builder and call build()

  group(TransactionStartRequest, () {
    // TransactionType transactionType
    test('to test the property `transactionType`', () async {
      // TODO
    });

    // Unique identifier of the agent
    // String agentId
    test('to test the property `agentId`', () async {
      // TODO
    });

    // Transaction amount in MYR
    // double amount
    test('to test the property `amount`', () async {
      // TODO
    });

    // Optional unique key to prevent duplicate transactions. If not provided, server will generate one.
    // String idempotencyKey
    test('to test the property `idempotencyKey`', () async {
      // TODO
    });

    // Card number (PAN) - required for CASH_WITHDRAWAL
    // String pan
    test('to test the property `pan`', () async {
      // TODO
    });

    // Encrypted PIN block - required for CASH_WITHDRAWAL
    // String pinBlock
    test('to test the property `pinBlock`', () async {
      // TODO
    });

    // Masked card number for display (e.g., 411111******1111)
    // String customerCardMasked
    test('to test the property `customerCardMasked`', () async {
      // TODO
    });

    // Destination account number - required for CASH_DEPOSIT
    // String destinationAccount
    test('to test the property `destinationAccount`', () async {
      // TODO
    });

    // Whether biometric verification is required
    // bool requiresBiometric (default value: false)
    test('to test the property `requiresBiometric`', () async {
      // TODO
    });

    // Biller code - required for BILL_PAYMENT
    // String billerCode
    test('to test the property `billerCode`', () async {
      // TODO
    });

    // Reference 1 (bill account number) - required for BILL_PAYMENT
    // String ref1
    test('to test the property `ref1`', () async {
      // TODO
    });

    // Reference 2 (optional) - for BILL_PAYMENT
    // String ref2
    test('to test the property `ref2`', () async {
      // TODO
    });

    // DuitNow proxy type - required for DUITNOW_TRANSFER
    // String proxyType
    test('to test the property `proxyType`', () async {
      // TODO
    });

    // DuitNow proxy value - required for DUITNOW_TRANSFER
    // String proxyValue
    test('to test the property `proxyValue`', () async {
      // TODO
    });

    // Encrypted customer MyKad number
    // String customerMykad
    test('to test the property `customerMykad`', () async {
      // TODO
    });

    // GPS latitude of transaction location
    // double geofenceLat
    test('to test the property `geofenceLat`', () async {
      // TODO
    });

    // GPS longitude of transaction location
    // double geofenceLng
    test('to test the property `geofenceLng`', () async {
      // TODO
    });

    // Target bank BIN for routing
    // String targetBIN
    test('to test the property `targetBIN`', () async {
      // TODO
    });

    // Agent tier level
    // String agentTier
    test('to test the property `agentTier`', () async {
      // TODO
    });

  });
}
