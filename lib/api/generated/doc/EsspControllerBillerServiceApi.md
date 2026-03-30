# agent_api.api.EsspControllerBillerServiceApi

## Load the API package
```dart
import 'package:agent_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**purchase**](EsspControllerBillerServiceApi.md#purchase) | **POST** /api/v1/essp/purchase | 


# **purchase**
> BuiltMap<String, JsonObject> purchase(requestBody)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getEsspControllerBillerServiceApi();
final BuiltMap<String, JsonObject> requestBody = Object; // BuiltMap<String, JsonObject> | 

try {
    final response = api.purchase(requestBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling EsspControllerBillerServiceApi->purchase: $e\n');
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

