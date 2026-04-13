# agent_api.model.FeeConfigRequest

## Load the model package
```dart
import 'package:agent_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**agentTier** | **String** |  | 
**transactionType** | **String** | Transaction type. JOMPAY, ASTRO_RPN, TM_RPN map to BILL_PAYMENT. CELCOM_TOPUP, M1_TOPUP map to PREPAID_TOPUP. | 
**feeType** | **String** |  | 
**feeAmount** | **String** |  | [optional] 
**percentage** | **String** |  | [optional] 
**minFee** | **String** |  | [optional] 
**maxFee** | **String** |  | [optional] 
**currency** | **String** |  | 
**effectiveFrom** | [**DateTime**](DateTime.md) |  | 
**effectiveTo** | [**DateTime**](DateTime.md) |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


