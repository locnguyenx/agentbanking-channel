# agent_api.api.RulesControllerRulesServiceApi

## Load the API package
```dart
import 'package:agent_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createFeeConfig**](RulesControllerRulesServiceApi.md#createfeeconfig) | **POST** /api/v1/rules/fees | 


# **createFeeConfig**
> FeeConfigResponse createFeeConfig(feeConfigRequest)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getRulesControllerRulesServiceApi();
final FeeConfigRequest feeConfigRequest = ; // FeeConfigRequest | 

try {
    final response = api.createFeeConfig(feeConfigRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RulesControllerRulesServiceApi->createFeeConfig: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **feeConfigRequest** | [**FeeConfigRequest**](FeeConfigRequest.md)|  | 

### Return type

[**FeeConfigResponse**](FeeConfigResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

