# agent_api.model.EWalletWithdrawExternalRequest

## Load the model package
```dart
import 'package:agent_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**walletProvider** | **String** | E-wallet provider | 
**walletAccountId** | **String** | E-wallet account ID | 
**amount** | **num** | Withdrawal amount in MYR | 
**currency** | **String** |  | [default to 'MYR']
**idempotencyKey** | **String** |  | 
**customerCard** | **String** | Customer card for card-based withdrawal | [optional] 
**customerPin** | **String** |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


