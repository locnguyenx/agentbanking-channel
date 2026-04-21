# agent_api.model.TransactionStartRequest

## Load the model package
```dart
import 'package:agent_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**idempotencyKey** | **String** | Unique key to prevent duplicate transactions. | 
**transactionType** | [**TransactionType**](TransactionType.md) |  | 
**agentId** | **String** | Unique identifier of the agent | [optional] 
**amount** | **double** | Transaction amount in MYR | 
**fundingSource** | **String** | Source of funds for the transaction. | 
**pan** | **String** | Card number (PAN) - required for CASH_WITHDRAWAL | [optional] 
**pinBlock** | **String** | Encrypted PIN block - required for CASH_WITHDRAWAL | [optional] 
**customerCardMasked** | **String** | Masked card number for display (e.g., 411111******1111) | [optional] 
**destinationAccount** | **String** | Destination account number - required for CASH_DEPOSIT | [optional] 
**requiresBiometric** | **bool** | Whether biometric verification is required | [optional] [default to false]
**billerCode** | **String** | Biller code - required for BILL_PAYMENT | [optional] 
**ref1** | **String** | Reference 1 (bill account number) - required for BILL_PAYMENT | [optional] 
**ref2** | **String** | Reference 2 (optional) - for BILL_PAYMENT | [optional] 
**proxyType** | **String** | DuitNow proxy type - required for DUITNOW_TRANSFER | [optional] 
**proxyValue** | **String** | DuitNow proxy value - required for DUITNOW_TRANSFER | [optional] 
**customerMykad** | **String** | Encrypted customer MyKad number | [optional] 
**geofenceLat** | **double** | GPS latitude of transaction location | [optional] 
**geofenceLng** | **double** | GPS longitude of transaction location | [optional] 
**targetBIN** | **String** | Target bank BIN for routing | [optional] 
**agentTier** | **String** | Agent tier level | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


