# agent_api.api.SwitchControllerBillerServiceApi

## Load the API package
```dart
import 'package:agent_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**proxyEnquiry**](SwitchControllerBillerServiceApi.md#proxyenquiry) | **GET** /api/v1/transfer/proxy/enquiry | 


# **proxyEnquiry**
> JsonObject proxyEnquiry(proxyId, proxyType)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getSwitchControllerBillerServiceApi();
final String proxyId = proxyId_example; // String | 
final String proxyType = proxyType_example; // String | 

try {
    final response = api.proxyEnquiry(proxyId, proxyType);
    print(response);
} on DioException catch (e) {
    print('Exception when calling SwitchControllerBillerServiceApi->proxyEnquiry: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **proxyId** | **String**|  | 
 **proxyType** | **String**|  | 

### Return type

[**JsonObject**](JsonObject.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

