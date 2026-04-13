# agent_api.api.ComplianceControllerOnboardingServiceApi

## Load the API package
```dart
import 'package:agent_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getComplianceStatus**](ComplianceControllerOnboardingServiceApi.md#getcompliancestatus) | **GET** /api/v1/compliance/status | 


# **getComplianceStatus**
> String getComplianceStatus()



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getComplianceControllerOnboardingServiceApi();

try {
    final response = api.getComplianceStatus();
    print(response);
} on DioException catch (e) {
    print('Exception when calling ComplianceControllerOnboardingServiceApi->getComplianceStatus: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

**String**

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

