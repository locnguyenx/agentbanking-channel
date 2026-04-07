# agent_api.api.OrchestratorControllerOrchestratorServiceApi

## Load the API package
```dart
import 'package:agent_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**forceResolveTransaction**](OrchestratorControllerOrchestratorServiceApi.md#forceresolvetransaction) | **POST** /api/v1/transactions/{workflowId}/force-resolve | Force resolve a stuck transaction workflow
[**getTransactionStatus**](OrchestratorControllerOrchestratorServiceApi.md#gettransactionstatus) | **GET** /api/v1/transactions/{workflowId}/status | Get transaction workflow status
[**startTransaction**](OrchestratorControllerOrchestratorServiceApi.md#starttransaction) | **POST** /api/v1/transactions | Start a new transaction via Temporal SAGA orchestration


# **forceResolveTransaction**
> ForceResolveTransaction200Response forceResolveTransaction(workflowId, forceResolveRequest)

Force resolve a stuck transaction workflow

Admin operation to manually resolve a stuck or failed workflow. Requires admin credentials.

### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getOrchestratorControllerOrchestratorServiceApi();
final String workflowId = workflowId_example; // String | The workflow ID to force resolve
final ForceResolveRequest forceResolveRequest = ; // ForceResolveRequest | 

try {
    final response = api.forceResolveTransaction(workflowId, forceResolveRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling OrchestratorControllerOrchestratorServiceApi->forceResolveTransaction: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **workflowId** | **String**| The workflow ID to force resolve | 
 **forceResolveRequest** | [**ForceResolveRequest**](ForceResolveRequest.md)|  | 

### Return type

[**ForceResolveTransaction200Response**](ForceResolveTransaction200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getTransactionStatus**
> TransactionStatusResponse getTransactionStatus(workflowId)

Get transaction workflow status

Poll the status of a previously started transaction workflow.

### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getOrchestratorControllerOrchestratorServiceApi();
final String workflowId = workflowId_example; // String | The workflow ID returned from the start transaction response

try {
    final response = api.getTransactionStatus(workflowId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling OrchestratorControllerOrchestratorServiceApi->getTransactionStatus: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **workflowId** | **String**| The workflow ID returned from the start transaction response | 

### Return type

[**TransactionStatusResponse**](TransactionStatusResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **startTransaction**
> TransactionStartResponse startTransaction(transactionStartRequest)

Start a new transaction via Temporal SAGA orchestration

Initiates a transaction workflow (withdrawal, deposit, bill payment, or DuitNow transfer) using Temporal durable execution. Returns a workflow ID for polling status.

### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getOrchestratorControllerOrchestratorServiceApi();
final TransactionStartRequest transactionStartRequest = ; // TransactionStartRequest | 

try {
    final response = api.startTransaction(transactionStartRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling OrchestratorControllerOrchestratorServiceApi->startTransaction: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **transactionStartRequest** | [**TransactionStartRequest**](TransactionStartRequest.md)|  | 

### Return type

[**TransactionStartResponse**](TransactionStartResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

