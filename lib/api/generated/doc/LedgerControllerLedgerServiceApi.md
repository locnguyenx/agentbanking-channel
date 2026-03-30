# agent_api.api.LedgerControllerLedgerServiceApi

## Load the API package
```dart
import 'package:agent_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**balanceInquiry**](LedgerControllerLedgerServiceApi.md#balanceinquiry) | **POST** /api/v1/balance-inquiry | 
[**credit**](LedgerControllerLedgerServiceApi.md#credit) | **POST** /api/v1/deposit | 
[**debit**](LedgerControllerLedgerServiceApi.md#debit) | **POST** /api/v1/withdrawal | 
[**getBalance**](LedgerControllerLedgerServiceApi.md#getbalance) | **GET** /api/v1/agent/balance | 
[**getDashboard**](LedgerControllerLedgerServiceApi.md#getdashboard) | **GET** /api/v1/backoffice/dashboard | 
[**getSettlement**](LedgerControllerLedgerServiceApi.md#getsettlement) | **GET** /api/v1/backoffice/settlement | 
[**getTransactions**](LedgerControllerLedgerServiceApi.md#gettransactions) | **GET** /api/v1/backoffice/transactions | 


# **balanceInquiry**
> BuiltMap<String, JsonObject> balanceInquiry(balanceInquiryRequest)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getLedgerControllerLedgerServiceApi();
final BalanceInquiryRequest balanceInquiryRequest = ; // BalanceInquiryRequest | 

try {
    final response = api.balanceInquiry(balanceInquiryRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling LedgerControllerLedgerServiceApi->balanceInquiry: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **balanceInquiryRequest** | [**BalanceInquiryRequest**](BalanceInquiryRequest.md)|  | 

### Return type

[**BuiltMap&lt;String, JsonObject&gt;**](JsonObject.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **credit**
> BuiltMap<String, JsonObject> credit(depositRequest)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getLedgerControllerLedgerServiceApi();
final DepositRequest depositRequest = ; // DepositRequest | 

try {
    final response = api.credit(depositRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling LedgerControllerLedgerServiceApi->credit: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **depositRequest** | [**DepositRequest**](DepositRequest.md)|  | 

### Return type

[**BuiltMap&lt;String, JsonObject&gt;**](JsonObject.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **debit**
> BuiltMap<String, JsonObject> debit(withdrawalRequest)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getLedgerControllerLedgerServiceApi();
final WithdrawalRequest withdrawalRequest = ; // WithdrawalRequest | 

try {
    final response = api.debit(withdrawalRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling LedgerControllerLedgerServiceApi->debit: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **withdrawalRequest** | [**WithdrawalRequest**](WithdrawalRequest.md)|  | 

### Return type

[**BuiltMap&lt;String, JsonObject&gt;**](JsonObject.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getBalance**
> BuiltMap<String, JsonObject> getBalance(agentId)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getLedgerControllerLedgerServiceApi();
final String agentId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getBalance(agentId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling LedgerControllerLedgerServiceApi->getBalance: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **agentId** | **String**|  | 

### Return type

[**BuiltMap&lt;String, JsonObject&gt;**](JsonObject.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getDashboard**
> BuiltMap<String, JsonObject> getDashboard()



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getLedgerControllerLedgerServiceApi();

try {
    final response = api.getDashboard();
    print(response);
} on DioException catch (e) {
    print('Exception when calling LedgerControllerLedgerServiceApi->getDashboard: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltMap&lt;String, JsonObject&gt;**](JsonObject.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getSettlement**
> BuiltMap<String, JsonObject> getSettlement(date)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getLedgerControllerLedgerServiceApi();
final String date = date_example; // String | 

try {
    final response = api.getSettlement(date);
    print(response);
} on DioException catch (e) {
    print('Exception when calling LedgerControllerLedgerServiceApi->getSettlement: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **date** | **String**|  | 

### Return type

[**BuiltMap&lt;String, JsonObject&gt;**](JsonObject.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getTransactions**
> BuiltMap<String, JsonObject> getTransactions(page, size)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getLedgerControllerLedgerServiceApi();
final int page = 56; // int | 
final int size = 56; // int | 

try {
    final response = api.getTransactions(page, size);
    print(response);
} on DioException catch (e) {
    print('Exception when calling LedgerControllerLedgerServiceApi->getTransactions: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **int**|  | [optional] [default to 0]
 **size** | **int**|  | [optional] [default to 20]

### Return type

[**BuiltMap&lt;String, JsonObject&gt;**](JsonObject.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

