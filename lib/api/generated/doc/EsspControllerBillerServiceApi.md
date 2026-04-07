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
> TransactionResponse purchase(esspExternalRequest)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getEsspControllerBillerServiceApi();
final EsspExternalRequest esspExternalRequest = ; // EsspExternalRequest | 

try {
    final response = api.purchase(esspExternalRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling EsspControllerBillerServiceApi->purchase: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **esspExternalRequest** | [**EsspExternalRequest**](EsspExternalRequest.md)|  | 

### Return type

[**TransactionResponse**](TransactionResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

