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
> BuiltMap<String, JsonObject> checkerApprove(caseId, requestBody)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getReconciliationControllerLedgerServiceApi();
final String caseId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final BuiltMap<String, JsonObject> requestBody = Object; // BuiltMap<String, JsonObject> | 

try {
    final response = api.checkerApprove(caseId, requestBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ReconciliationControllerLedgerServiceApi->checkerApprove: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **caseId** | **String**|  | 
 **requestBody** | [**BuiltMap&lt;String, JsonObject&gt;**](JsonObject.md)|  | 

### Return type

[**BuiltMap&lt;String, JsonObject&gt;**](JsonObject.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **checkerReject**
> BuiltMap<String, JsonObject> checkerReject(caseId, requestBody)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getReconciliationControllerLedgerServiceApi();
final String caseId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final BuiltMap<String, JsonObject> requestBody = Object; // BuiltMap<String, JsonObject> | 

try {
    final response = api.checkerReject(caseId, requestBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ReconciliationControllerLedgerServiceApi->checkerReject: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **caseId** | **String**|  | 
 **requestBody** | [**BuiltMap&lt;String, JsonObject&gt;**](JsonObject.md)|  | 

### Return type

[**BuiltMap&lt;String, JsonObject&gt;**](JsonObject.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **makerPropose**
> BuiltMap<String, JsonObject> makerPropose(caseId, requestBody)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getReconciliationControllerLedgerServiceApi();
final String caseId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final BuiltMap<String, JsonObject> requestBody = Object; // BuiltMap<String, JsonObject> | 

try {
    final response = api.makerPropose(caseId, requestBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ReconciliationControllerLedgerServiceApi->makerPropose: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **caseId** | **String**|  | 
 **requestBody** | [**BuiltMap&lt;String, JsonObject&gt;**](JsonObject.md)|  | 

### Return type

[**BuiltMap&lt;String, JsonObject&gt;**](JsonObject.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

