# agent_api.api.ReconciliationControllerLedgerServiceApi

## Load the API package
```dart
import 'package:agent_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**checkerApproveActionLegacy**](ReconciliationControllerLedgerServiceApi.md#checkerapproveactionlegacy) | **POST** /api/v1/backoffice/discrepancy/{caseId}/checker-approve | 
[**checkerRejectActionLegacy**](ReconciliationControllerLedgerServiceApi.md#checkerrejectactionlegacy) | **POST** /api/v1/backoffice/discrepancy/{caseId}/checker-reject | 
[**makerProposeActionLegacy**](ReconciliationControllerLedgerServiceApi.md#makerproposeactionlegacy) | **POST** /api/v1/backoffice/discrepancy/{caseId}/maker-action | 


# **checkerApproveActionLegacy**
> checkerApproveActionLegacy(caseId, checkerApproveActionLegacyRequest)



DEPRECATED: Use /api/v1/backoffice/discrepancy/checker-approve instead.

### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getReconciliationControllerLedgerServiceApi();
final String caseId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final CheckerApproveActionLegacyRequest checkerApproveActionLegacyRequest = ; // CheckerApproveActionLegacyRequest | 

try {
    api.checkerApproveActionLegacy(caseId, checkerApproveActionLegacyRequest);
} on DioException catch (e) {
    print('Exception when calling ReconciliationControllerLedgerServiceApi->checkerApproveActionLegacy: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **caseId** | **String**|  | 
 **checkerApproveActionLegacyRequest** | [**CheckerApproveActionLegacyRequest**](CheckerApproveActionLegacyRequest.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **checkerRejectActionLegacy**
> checkerRejectActionLegacy(caseId, checkerApproveActionLegacyRequest)



DEPRECATED: Use /api/v1/backoffice/transactions/{workflowId}/checker-reject instead.

### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getReconciliationControllerLedgerServiceApi();
final String caseId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final CheckerApproveActionLegacyRequest checkerApproveActionLegacyRequest = ; // CheckerApproveActionLegacyRequest | 

try {
    api.checkerRejectActionLegacy(caseId, checkerApproveActionLegacyRequest);
} on DioException catch (e) {
    print('Exception when calling ReconciliationControllerLedgerServiceApi->checkerRejectActionLegacy: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **caseId** | **String**|  | 
 **checkerApproveActionLegacyRequest** | [**CheckerApproveActionLegacyRequest**](CheckerApproveActionLegacyRequest.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **makerProposeActionLegacy**
> makerProposeActionLegacy(caseId, makerProposeActionLegacyRequest)



DEPRECATED: Use /api/v1/backoffice/discrepancy/maker-propose instead.

### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getReconciliationControllerLedgerServiceApi();
final String caseId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final MakerProposeActionLegacyRequest makerProposeActionLegacyRequest = ; // MakerProposeActionLegacyRequest | 

try {
    api.makerProposeActionLegacy(caseId, makerProposeActionLegacyRequest);
} on DioException catch (e) {
    print('Exception when calling ReconciliationControllerLedgerServiceApi->makerProposeActionLegacy: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **caseId** | **String**|  | 
 **makerProposeActionLegacyRequest** | [**MakerProposeActionLegacyRequest**](MakerProposeActionLegacyRequest.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

