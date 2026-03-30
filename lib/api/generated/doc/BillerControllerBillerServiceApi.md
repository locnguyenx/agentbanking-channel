# agent_api.api.BillerControllerBillerServiceApi

## Load the API package
```dart
import 'package:agent_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**jomPay**](BillerControllerBillerServiceApi.md#jompay) | **POST** /api/v1/billpayment/jompay | 
[**payBill**](BillerControllerBillerServiceApi.md#paybill) | **POST** /api/v1/bill/pay | 
[**topup**](BillerControllerBillerServiceApi.md#topup) | **POST** /api/v1/topup | 


# **jomPay**
> TransactionResponse jomPay(jomPayExternalRequest)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getBillerControllerBillerServiceApi();
final JomPayExternalRequest jomPayExternalRequest = ; // JomPayExternalRequest | 

try {
    final response = api.jomPay(jomPayExternalRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling BillerControllerBillerServiceApi->jomPay: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **jomPayExternalRequest** | [**JomPayExternalRequest**](JomPayExternalRequest.md)|  | 

### Return type

[**TransactionResponse**](TransactionResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **payBill**
> TransactionResponse payBill(billPayExternalRequest)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getBillerControllerBillerServiceApi();
final BillPayExternalRequest billPayExternalRequest = ; // BillPayExternalRequest | 

try {
    final response = api.payBill(billPayExternalRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling BillerControllerBillerServiceApi->payBill: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **billPayExternalRequest** | [**BillPayExternalRequest**](BillPayExternalRequest.md)|  | 

### Return type

[**TransactionResponse**](TransactionResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **topup**
> TransactionResponse topup(topupExternalRequest)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getBillerControllerBillerServiceApi();
final TopupExternalRequest topupExternalRequest = ; // TopupExternalRequest | 

try {
    final response = api.topup(topupExternalRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling BillerControllerBillerServiceApi->topup: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **topupExternalRequest** | [**TopupExternalRequest**](TopupExternalRequest.md)|  | 

### Return type

[**TransactionResponse**](TransactionResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

