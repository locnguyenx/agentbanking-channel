# agent_api.api.ResolutionControllerOrchestratorServiceApi

## Load the API package
```dart
import 'package:agent_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**checkerApproveTransaction**](ResolutionControllerOrchestratorServiceApi.md#checkerapprovetransaction) | **POST** /api/v1/backoffice/transactions/{workflowId}/checker-approve | Checker approves proposed resolution
[**checkerRejectTransaction**](ResolutionControllerOrchestratorServiceApi.md#checkerrejecttransaction) | **POST** /api/v1/backoffice/transactions/{workflowId}/checker-reject | Checker rejects proposed resolution
[**listTransactions**](ResolutionControllerOrchestratorServiceApi.md#listtransactions) | **GET** /api/v1/backoffice/transactions | 
[**makerProposeTransaction**](ResolutionControllerOrchestratorServiceApi.md#makerproposetransaction) | **POST** /api/v1/backoffice/transactions/{workflowId}/maker-propose | Maker proposes resolution for a transaction


# **checkerApproveTransaction**
> ResolutionResponse checkerApproveTransaction(workflowId, checkerActionRequest)

Checker approves proposed resolution

Second step in four-eyes approval - checker approves the maker's proposal

### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getResolutionControllerOrchestratorServiceApi();
final String workflowId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final CheckerActionRequest checkerActionRequest = ; // CheckerActionRequest | 

try {
    final response = api.checkerApproveTransaction(workflowId, checkerActionRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ResolutionControllerOrchestratorServiceApi->checkerApproveTransaction: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **workflowId** | **String**|  | 
 **checkerActionRequest** | [**CheckerActionRequest**](CheckerActionRequest.md)|  | 

### Return type

[**ResolutionResponse**](ResolutionResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **checkerRejectTransaction**
> ResolutionResponse checkerRejectTransaction(workflowId, checkerActionRequest)

Checker rejects proposed resolution

Second step in four-eyes approval - checker rejects the maker's proposal, returning to maker

### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getResolutionControllerOrchestratorServiceApi();
final String workflowId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final CheckerActionRequest checkerActionRequest = ; // CheckerActionRequest | 

try {
    final response = api.checkerRejectTransaction(workflowId, checkerActionRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ResolutionControllerOrchestratorServiceApi->checkerRejectTransaction: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **workflowId** | **String**|  | 
 **checkerActionRequest** | [**CheckerActionRequest**](CheckerActionRequest.md)|  | 

### Return type

[**ResolutionResponse**](ResolutionResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listTransactions**
> BackofficeTransactionListResponse listTransactions(status)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getResolutionControllerOrchestratorServiceApi();
final String status = status_example; // String | 

try {
    final response = api.listTransactions(status);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ResolutionControllerOrchestratorServiceApi->listTransactions: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **status** | **String**|  | [optional] 

### Return type

[**BackofficeTransactionListResponse**](BackofficeTransactionListResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **makerProposeTransaction**
> ResolutionResponse makerProposeTransaction(workflowId, makerProposalRequest)

Maker proposes resolution for a transaction

First step in four-eyes approval - maker proposes an action (COMMIT, ROLLBACK, ESCALATE)

### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getResolutionControllerOrchestratorServiceApi();
final String workflowId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final MakerProposalRequest makerProposalRequest = ; // MakerProposalRequest | 

try {
    final response = api.makerProposeTransaction(workflowId, makerProposalRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ResolutionControllerOrchestratorServiceApi->makerProposeTransaction: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **workflowId** | **String**|  | 
 **makerProposalRequest** | [**MakerProposalRequest**](MakerProposalRequest.md)|  | 

### Return type

[**ResolutionResponse**](ResolutionResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

