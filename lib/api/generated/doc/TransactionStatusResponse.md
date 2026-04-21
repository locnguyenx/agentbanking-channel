# agent_api.model.TransactionStatusResponse

## Load the model package
```dart
import 'package:agent_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**status** | **String** | Current workflow status | [optional] 
**workflowId** | **String** | Workflow identifier | [optional] 
**transactionType** | **String** | Type of transaction | [optional] 
**amount** | **double** | Transaction amount | [optional] 
**customerFee** | **double** | Fee charged to customer | [optional] 
**referenceNumber** | **String** | External reference number from switch/biller | [optional] 
**errorCode** | **String** | Error code if transaction failed | [optional] 
**errorMessage** | **String** | Human-readable error message | [optional] 
**actionCode** | **String** | Recommended action for failed transactions | [optional] 
**completedAt** | [**DateTime**](DateTime.md) | Timestamp when transaction completed | [optional] 
**agentTier** | **String** |  | [optional] 
**billerCode** | **String** |  | [optional] 
**customerCardMasked** | **String** |  | [optional] 
**destinationAccount** | **String** |  | [optional] 
**errorDetails** | [**JsonObject**](.md) |  | [optional] 
**geofenceLat** | **double** |  | [optional] 
**geofenceLng** | **double** |  | [optional] 
**pendingReason** | **String** |  | [optional] 
**ref1** | **String** |  | [optional] 
**ref2** | **String** |  | [optional] 
**targetBin** | **String** |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


