# agent_api.api.EWalletControllerBillerServiceApi

## Load the API package
```dart
import 'package:agent_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**topup1**](EWalletControllerBillerServiceApi.md#topup1) | **POST** /api/v1/ewallet/topup | 
[**withdrawal**](EWalletControllerBillerServiceApi.md#withdrawal) | **POST** /api/v1/ewallet/withdraw | 


# **topup1**
> BuiltMap<String, JsonObject> topup1(requestBody)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getEWalletControllerBillerServiceApi();
final BuiltMap<String, JsonObject> requestBody = Object; // BuiltMap<String, JsonObject> | 

try {
    final response = api.topup1(requestBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling EWalletControllerBillerServiceApi->topup1: $e\n');
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

# **withdrawal**
> BuiltMap<String, JsonObject> withdrawal(requestBody)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getEWalletControllerBillerServiceApi();
final BuiltMap<String, JsonObject> requestBody = Object; // BuiltMap<String, JsonObject> | 

try {
    final response = api.withdrawal(requestBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling EWalletControllerBillerServiceApi->withdrawal: $e\n');
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

