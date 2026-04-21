# agent_api.api.DiscrepancyControllerApi

## Load the API package
```dart
import 'package:agent_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**checkerApprove**](DiscrepancyControllerApi.md#checkerapprove) | **POST** /api/v1/backoffice/discrepancy/checker-approve | 
[**makerPropose**](DiscrepancyControllerApi.md#makerpropose) | **POST** /api/v1/backoffice/discrepancy/maker-propose | 


# **checkerApprove**
> checkerApprove(checkerApproveRequest)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getDiscrepancyControllerApi();
final CheckerApproveRequest checkerApproveRequest = ; // CheckerApproveRequest | 

try {
    api.checkerApprove(checkerApproveRequest);
} on DioException catch (e) {
    print('Exception when calling DiscrepancyControllerApi->checkerApprove: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **checkerApproveRequest** | [**CheckerApproveRequest**](CheckerApproveRequest.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **makerPropose**
> makerPropose(makerProposeRequest)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getDiscrepancyControllerApi();
final MakerProposeRequest makerProposeRequest = ; // MakerProposeRequest | 

try {
    api.makerPropose(makerProposeRequest);
} on DioException catch (e) {
    print('Exception when calling DiscrepancyControllerApi->makerPropose: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **makerProposeRequest** | [**MakerProposeRequest**](MakerProposeRequest.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

