# agent_api.api.TransactionControllerRulesServiceApi

## Load the API package
```dart
import 'package:agent_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getTransactionQuote**](TransactionControllerRulesServiceApi.md#gettransactionquote) | **POST** /api/v1/transactions/quote | 


# **getTransactionQuote**
> TransactionQuoteResponse getTransactionQuote(transactionQuoteRequest)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getTransactionControllerRulesServiceApi();
final TransactionQuoteRequest transactionQuoteRequest = ; // TransactionQuoteRequest | 

try {
    final response = api.getTransactionQuote(transactionQuoteRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling TransactionControllerRulesServiceApi->getTransactionQuote: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **transactionQuoteRequest** | [**TransactionQuoteRequest**](TransactionQuoteRequest.md)|  | 

### Return type

[**TransactionQuoteResponse**](TransactionQuoteResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

