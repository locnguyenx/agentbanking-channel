# agent_api.api.SwitchControllerSwitchAdapterServiceApi

## Load the API package
```dart
import 'package:agent_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**duitNowTransfer**](SwitchControllerSwitchAdapterServiceApi.md#duitnowtransfer) | **POST** /api/v1/transfer/duitnow | 


# **duitNowTransfer**
> TransactionResponse duitNowTransfer(duitNowRequest)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getSwitchControllerSwitchAdapterServiceApi();
final DuitNowRequest duitNowRequest = ; // DuitNowRequest | 

try {
    final response = api.duitNowTransfer(duitNowRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling SwitchControllerSwitchAdapterServiceApi->duitNowTransfer: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **duitNowRequest** | [**DuitNowRequest**](DuitNowRequest.md)|  | 

### Return type

[**TransactionResponse**](TransactionResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

