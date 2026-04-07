# agent_api.model.DepositExternalRequest

## Load the model package
```dart
import 'package:agent_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**amount** | **String** | Transaction amount in MYR | 
**currency** | **String** |  | [default to 'MYR']
**idempotencyKey** | **String** | Unique key to prevent duplicate transactions | 
**customerAccount** | **String** | Customer account number | 
**customerName** | **String** | Customer full name | [optional] 
**location** | [**GeoLocation**](GeoLocation.md) |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


