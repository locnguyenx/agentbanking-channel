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
> BalanceResponse balanceInquiry(balanceInquiryExternalRequest)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getLedgerControllerLedgerServiceApi();
final BalanceInquiryExternalRequest balanceInquiryExternalRequest = ; // BalanceInquiryExternalRequest | 

try {
    final response = api.balanceInquiry(balanceInquiryExternalRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling LedgerControllerLedgerServiceApi->balanceInquiry: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **balanceInquiryExternalRequest** | [**BalanceInquiryExternalRequest**](BalanceInquiryExternalRequest.md)|  | 

### Return type

[**BalanceResponse**](BalanceResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **credit**
> TransactionResponse credit(depositExternalRequest)



**DEPRECATED** - Use `POST /api/v1/transactions` with `transactionType: CASH_DEPOSIT` instead. This endpoint will be removed in a future version. See [API Changelog](/docs/api/CHANGELOG-2026-04-05-transaction-orchestrator.md) for migration guide. 

### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getLedgerControllerLedgerServiceApi();
final DepositExternalRequest depositExternalRequest = ; // DepositExternalRequest | 

try {
    final response = api.credit(depositExternalRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling LedgerControllerLedgerServiceApi->credit: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **depositExternalRequest** | [**DepositExternalRequest**](DepositExternalRequest.md)|  | 

### Return type

[**TransactionResponse**](TransactionResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **debit**
> TransactionResponse debit(withdrawalExternalRequest)



**DEPRECATED** - Use `POST /api/v1/transactions` with `transactionType: CASH_WITHDRAWAL` instead. This endpoint will be removed in a future version. See [API Changelog](/docs/api/CHANGELOG-2026-04-05-transaction-orchestrator.md) for migration guide. 

### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getLedgerControllerLedgerServiceApi();
final WithdrawalExternalRequest withdrawalExternalRequest = ; // WithdrawalExternalRequest | 

try {
    final response = api.debit(withdrawalExternalRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling LedgerControllerLedgerServiceApi->debit: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **withdrawalExternalRequest** | [**WithdrawalExternalRequest**](WithdrawalExternalRequest.md)|  | 

### Return type

[**TransactionResponse**](TransactionResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getBalance**
> BalanceResponse getBalance(agentId)



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

[**BalanceResponse**](BalanceResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getDashboard**
> DashboardResponse getDashboard()



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

[**DashboardResponse**](DashboardResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getSettlement**
> SettlementResponse getSettlement(date)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getLedgerControllerLedgerServiceApi();
final Date date = 2013-10-20; // Date | 

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
 **date** | **Date**|  | 

### Return type

[**SettlementResponse**](SettlementResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getTransactions**
> TransactionListResponse getTransactions(page, size)



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

[**TransactionListResponse**](TransactionListResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

