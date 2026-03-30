# agent_api.api.BillerControllerBillerServiceApi

## Load the API package
```dart
import 'package:agent_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**payBill**](BillerControllerBillerServiceApi.md#paybill) | **POST** /api/v1/bill/pay | 
[**topup**](BillerControllerBillerServiceApi.md#topup) | **POST** /api/v1/topup | 


# **payBill**
> BuiltMap<String, JsonObject> payBill(requestBody)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getBillerControllerBillerServiceApi();
final BuiltMap<String, JsonObject> requestBody = Object; // BuiltMap<String, JsonObject> | 

try {
    final response = api.payBill(requestBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling BillerControllerBillerServiceApi->payBill: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **requestBody** | [**BuiltMap&lt;String, JsonObject&gt;**](JsonObject.md)|  | 

### Return type

[**BuiltMap&lt;String, JsonObject&gt;**](JsonObject.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **topup**
> BuiltMap<String, JsonObject> topup(requestBody)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getBillerControllerBillerServiceApi();
final BuiltMap<String, JsonObject> requestBody = Object; // BuiltMap<String, JsonObject> | 

try {
    final response = api.topup(requestBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling BillerControllerBillerServiceApi->topup: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **requestBody** | [**BuiltMap&lt;String, JsonObject&gt;**](JsonObject.md)|  | 

### Return type

[**BuiltMap&lt;String, JsonObject&gt;**](JsonObject.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

