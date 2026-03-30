# agent_api.api.MerchantControllerLedgerServiceApi

## Load the API package
```dart
import 'package:agent_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**processCashBack**](MerchantControllerLedgerServiceApi.md#processcashback) | **POST** /api/v1/retail/cashback | 
[**processPinPurchase**](MerchantControllerLedgerServiceApi.md#processpinpurchase) | **POST** /api/v1/retail/pin-purchase | 
[**processRetailSale**](MerchantControllerLedgerServiceApi.md#processretailsale) | **POST** /api/v1/retail/sale | 


# **processCashBack**
> CashBackResponse processCashBack(cashBackCommand)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getMerchantControllerLedgerServiceApi();
final CashBackCommand cashBackCommand = ; // CashBackCommand | 

try {
    final response = api.processCashBack(cashBackCommand);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MerchantControllerLedgerServiceApi->processCashBack: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **cashBackCommand** | [**CashBackCommand**](CashBackCommand.md)|  | 

### Return type

[**CashBackResponse**](CashBackResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **processPinPurchase**
> PinPurchaseResponse processPinPurchase(pinPurchaseCommand)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getMerchantControllerLedgerServiceApi();
final PinPurchaseCommand pinPurchaseCommand = ; // PinPurchaseCommand | 

try {
    final response = api.processPinPurchase(pinPurchaseCommand);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MerchantControllerLedgerServiceApi->processPinPurchase: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pinPurchaseCommand** | [**PinPurchaseCommand**](PinPurchaseCommand.md)|  | 

### Return type

[**PinPurchaseResponse**](PinPurchaseResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **processRetailSale**
> RetailSaleResponse processRetailSale(retailSaleCommand)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getMerchantControllerLedgerServiceApi();
final RetailSaleCommand retailSaleCommand = ; // RetailSaleCommand | 

try {
    final response = api.processRetailSale(retailSaleCommand);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MerchantControllerLedgerServiceApi->processRetailSale: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **retailSaleCommand** | [**RetailSaleCommand**](RetailSaleCommand.md)|  | 

### Return type

[**RetailSaleResponse**](RetailSaleResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

