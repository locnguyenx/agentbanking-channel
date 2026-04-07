# agent_api.api.ResolutionControllerOrchestratorServiceApi

## Load the API package
```dart
import 'package:agent_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**checkerApproveResolution**](ResolutionControllerOrchestratorServiceApi.md#checkerapproveresolution) | **POST** /api/v1/backoffice/transactions/{workflowId}/checker-approve | Checker approves proposed resolution
[**checkerRejectResolution**](ResolutionControllerOrchestratorServiceApi.md#checkerrejectresolution) | **POST** /api/v1/backoffice/transactions/{workflowId}/checker-reject | Checker rejects proposed resolution
[**makerProposeResolution**](ResolutionControllerOrchestratorServiceApi.md#makerproposeresolution) | **POST** /api/v1/backoffice/transactions/{workflowId}/maker-propose | Maker proposes resolution for a transaction


# **checkerApproveResolution**
> ResolutionResponse checkerApproveResolution(workflowId, checkerActionRequest)

Checker approves proposed resolution

Second step in four-eyes approval - checker approves the maker's proposal

### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getResolutionControllerOrchestratorServiceApi();
final String workflowId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final CheckerActionRequest checkerActionRequest = ; // CheckerActionRequest | 

try {
    final response = api.checkerApproveResolution(workflowId, checkerActionRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ResolutionControllerOrchestratorServiceApi->checkerApproveResolution: $e\n');
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

# **checkerRejectResolution**
> ResolutionResponse checkerRejectResolution(workflowId, checkerActionRequest)

Checker rejects proposed resolution

Second step in four-eyes approval - checker rejects the maker's proposal, returning to maker

### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getResolutionControllerOrchestratorServiceApi();
final String workflowId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final CheckerActionRequest checkerActionRequest = ; // CheckerActionRequest | 

try {
    final response = api.checkerRejectResolution(workflowId, checkerActionRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ResolutionControllerOrchestratorServiceApi->checkerRejectResolution: $e\n');
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

# **makerProposeResolution**
> ResolutionResponse makerProposeResolution(workflowId, makerProposalRequest)

Maker proposes resolution for a transaction

First step in four-eyes approval - maker proposes an action (COMMIT, ROLLBACK, ESCALATE)

### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getResolutionControllerOrchestratorServiceApi();
final String workflowId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final MakerProposalRequest makerProposalRequest = ; // MakerProposalRequest | 

try {
    final response = api.makerProposeResolution(workflowId, makerProposalRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ResolutionControllerOrchestratorServiceApi->makerProposeResolution: $e\n');
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

