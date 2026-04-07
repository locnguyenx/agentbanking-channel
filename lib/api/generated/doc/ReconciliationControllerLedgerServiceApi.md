# agent_api.api.ReconciliationControllerLedgerServiceApi

## Load the API package
```dart
import 'package:agent_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**checkerApprove**](ReconciliationControllerLedgerServiceApi.md#checkerapprove) | **POST** /api/v1/backoffice/discrepancy/{caseId}/checker-approve | 
[**checkerReject**](ReconciliationControllerLedgerServiceApi.md#checkerreject) | **POST** /api/v1/backoffice/discrepancy/{caseId}/checker-reject | 
[**makerPropose**](ReconciliationControllerLedgerServiceApi.md#makerpropose) | **POST** /api/v1/backoffice/discrepancy/{caseId}/maker-action | 


# **checkerApprove**
> TransactionResponse checkerApprove(caseId, discrepancyCheckerActionRequest)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getReconciliationControllerLedgerServiceApi();
final String caseId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final DiscrepancyCheckerActionRequest discrepancyCheckerActionRequest = ; // DiscrepancyCheckerActionRequest | 

try {
    final response = api.checkerApprove(caseId, discrepancyCheckerActionRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ReconciliationControllerLedgerServiceApi->checkerApprove: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **caseId** | **String**|  | 
 **discrepancyCheckerActionRequest** | [**DiscrepancyCheckerActionRequest**](DiscrepancyCheckerActionRequest.md)|  | 

### Return type

[**TransactionResponse**](TransactionResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **checkerReject**
> TransactionResponse checkerReject(caseId, discrepancyCheckerActionRequest)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getReconciliationControllerLedgerServiceApi();
final String caseId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final DiscrepancyCheckerActionRequest discrepancyCheckerActionRequest = ; // DiscrepancyCheckerActionRequest | 

try {
    final response = api.checkerReject(caseId, discrepancyCheckerActionRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ReconciliationControllerLedgerServiceApi->checkerReject: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **caseId** | **String**|  | 
 **discrepancyCheckerActionRequest** | [**DiscrepancyCheckerActionRequest**](DiscrepancyCheckerActionRequest.md)|  | 

### Return type

[**TransactionResponse**](TransactionResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **makerPropose**
> TransactionResponse makerPropose(caseId, discrepancyMakerActionRequest)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getReconciliationControllerLedgerServiceApi();
final String caseId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final DiscrepancyMakerActionRequest discrepancyMakerActionRequest = ; // DiscrepancyMakerActionRequest | 

try {
    final response = api.makerPropose(caseId, discrepancyMakerActionRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ReconciliationControllerLedgerServiceApi->makerPropose: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **caseId** | **String**|  | 
 **discrepancyMakerActionRequest** | [**DiscrepancyMakerActionRequest**](DiscrepancyMakerActionRequest.md)|  | 

### Return type

[**TransactionResponse**](TransactionResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

