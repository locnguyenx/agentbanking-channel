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
> BuiltMap<String, JsonObject> topup1(eWalletTopupExternalRequest)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getEWalletControllerBillerServiceApi();
final EWalletTopupExternalRequest eWalletTopupExternalRequest = ; // EWalletTopupExternalRequest | 

try {
    final response = api.topup1(eWalletTopupExternalRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling EWalletControllerBillerServiceApi->topup1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **eWalletTopupExternalRequest** | [**EWalletTopupExternalRequest**](EWalletTopupExternalRequest.md)|  | 

### Return type

[**BuiltMap&lt;String, JsonObject&gt;**](JsonObject.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **withdrawal**
> TransactionResponse withdrawal(eWalletWithdrawExternalRequest)



**DEPRECATED** - Use `POST /api/v1/transactions` with `transactionType: CASH_WITHDRAWAL` instead. This endpoint will be removed in a future version. See [API Changelog](/docs/api/CHANGELOG-2026-04-05-transaction-orchestrator.md) for migration guide. 

### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getEWalletControllerBillerServiceApi();
final EWalletWithdrawExternalRequest eWalletWithdrawExternalRequest = ; // EWalletWithdrawExternalRequest | 

try {
    final response = api.withdrawal(eWalletWithdrawExternalRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling EWalletControllerBillerServiceApi->withdrawal: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **eWalletWithdrawExternalRequest** | [**EWalletWithdrawExternalRequest**](EWalletWithdrawExternalRequest.md)|  | 

### Return type

[**TransactionResponse**](TransactionResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

