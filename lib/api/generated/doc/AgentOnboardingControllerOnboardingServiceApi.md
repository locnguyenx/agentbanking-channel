# agent_api.api.AgentOnboardingControllerOnboardingServiceApi

## Load the API package
```dart
import 'package:agent_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**submitApplication**](AgentOnboardingControllerOnboardingServiceApi.md#submitapplication) | **POST** /api/v1/onboarding/submit-application | 


# **submitApplication**
> SubmissionResponse submitApplication(submissionRequest)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getAgentOnboardingControllerOnboardingServiceApi();
final SubmissionRequest submissionRequest = ; // SubmissionRequest | 

try {
    final response = api.submitApplication(submissionRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AgentOnboardingControllerOnboardingServiceApi->submitApplication: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **submissionRequest** | [**SubmissionRequest**](SubmissionRequest.md)|  | 

### Return type

[**SubmissionResponse**](SubmissionResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

