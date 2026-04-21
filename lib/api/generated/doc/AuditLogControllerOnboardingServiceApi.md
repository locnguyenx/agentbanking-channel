# agent_api.api.AuditLogControllerOnboardingServiceApi

## Load the API package
```dart
import 'package:agent_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getAuditLogs**](AuditLogControllerOnboardingServiceApi.md#getauditlogs) | **GET** /api/v1/backoffice/audit-logs | 


# **getAuditLogs**
> BackofficeAuditLogListResponse getAuditLogs(entityType, fromDate, toDate, page, size)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getAuditLogControllerOnboardingServiceApi();
final String entityType = entityType_example; // String | 
final DateTime fromDate = 2013-10-20T19:20:30+01:00; // DateTime | 
final DateTime toDate = 2013-10-20T19:20:30+01:00; // DateTime | 
final int page = 56; // int | 
final int size = 56; // int | 

try {
    final response = api.getAuditLogs(entityType, fromDate, toDate, page, size);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AuditLogControllerOnboardingServiceApi->getAuditLogs: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **entityType** | **String**|  | [optional] 
 **fromDate** | **DateTime**|  | [optional] 
 **toDate** | **DateTime**|  | [optional] 
 **page** | **int**|  | [optional] [default to 0]
 **size** | **int**|  | [optional] [default to 50]

### Return type

[**BackofficeAuditLogListResponse**](BackofficeAuditLogListResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

