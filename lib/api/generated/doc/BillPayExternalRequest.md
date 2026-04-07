# agent_api.model.BillPayExternalRequest

## Load the model package
```dart
import 'package:agent_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**billerCode** | **String** | Biller code (4 digits) | 
**ref1** | **String** | Reference 1 (bill account number) | 
**ref2** | **String** | Reference 2 (optional) | [optional] 
**amount** | **String** | Payment amount in MYR | 
**currency** | **String** |  | [default to 'MYR']
**idempotencyKey** | **String** |  | 
**customerMobile** | **String** | Customer mobile number | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


