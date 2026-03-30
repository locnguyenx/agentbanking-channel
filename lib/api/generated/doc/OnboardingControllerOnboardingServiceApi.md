# agent_api.api.OnboardingControllerOnboardingServiceApi

## Load the API package
```dart
import 'package:agent_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**biometricMatch**](OnboardingControllerOnboardingServiceApi.md#biometricmatch) | **POST** /api/v1/kyc/biometric | 
[**getKycReviewQueue**](OnboardingControllerOnboardingServiceApi.md#getkycreviewqueue) | **GET** /api/v1/backoffice/kyc/review-queue | 
[**verifyMyKad**](OnboardingControllerOnboardingServiceApi.md#verifymykad) | **POST** /api/v1/kyc/verify | 


# **biometricMatch**
> BuiltMap<String, JsonObject> biometricMatch(requestBody)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getOnboardingControllerOnboardingServiceApi();
final BuiltMap<String, String> requestBody = ; // BuiltMap<String, String> | 

try {
    final response = api.biometricMatch(requestBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling OnboardingControllerOnboardingServiceApi->biometricMatch: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **requestBody** | [**BuiltMap&lt;String, String&gt;**](String.md)|  | 

### Return type

[**BuiltMap&lt;String, JsonObject&gt;**](JsonObject.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getKycReviewQueue**
> BuiltMap<String, JsonObject> getKycReviewQueue(page, size)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getOnboardingControllerOnboardingServiceApi();
final int page = 56; // int | 
final int size = 56; // int | 

try {
    final response = api.getKycReviewQueue(page, size);
    print(response);
} on DioException catch (e) {
    print('Exception when calling OnboardingControllerOnboardingServiceApi->getKycReviewQueue: $e\n');
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

# **verifyMyKad**
> BuiltMap<String, JsonObject> verifyMyKad(requestBody)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getOnboardingControllerOnboardingServiceApi();
final BuiltMap<String, String> requestBody = ; // BuiltMap<String, String> | 

try {
    final response = api.verifyMyKad(requestBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling OnboardingControllerOnboardingServiceApi->verifyMyKad: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **requestBody** | [**BuiltMap&lt;String, String&gt;**](String.md)|  | 

### Return type

[**BuiltMap&lt;String, JsonObject&gt;**](JsonObject.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

