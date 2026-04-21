# agent_api.api.OnboardingControllerOnboardingServiceApi

## Load the API package
```dart
import 'package:agent_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**biometricMatch**](OnboardingControllerOnboardingServiceApi.md#biometricmatch) | **POST** /api/v1/onboarding/biometric-match | 
[**getKycReviewQueue**](OnboardingControllerOnboardingServiceApi.md#getkycreviewqueue) | **GET** /api/v1/backoffice/kyc/review-queue | 
[**submitApplicationLegacy**](OnboardingControllerOnboardingServiceApi.md#submitapplicationlegacy) | **POST** /api/v1/onboarding/submit-application-legacy | 
[**verifyMyKad**](OnboardingControllerOnboardingServiceApi.md#verifymykad) | **POST** /api/v1/onboarding/verify-mykad | 
[**verifyMyKadKyc**](OnboardingControllerOnboardingServiceApi.md#verifymykadkyc) | **POST** /api/v1/kyc/verify | 


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

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

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

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **submitApplicationLegacy**
> ApplicationSubmitResponse submitApplicationLegacy(applicationSubmitRequest)



DEPRECATED: Use /api/v1/onboarding/submit-application instead.

### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getOnboardingControllerOnboardingServiceApi();
final ApplicationSubmitRequest applicationSubmitRequest = ; // ApplicationSubmitRequest | 

try {
    final response = api.submitApplicationLegacy(applicationSubmitRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling OnboardingControllerOnboardingServiceApi->submitApplicationLegacy: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **applicationSubmitRequest** | [**ApplicationSubmitRequest**](ApplicationSubmitRequest.md)|  | 

### Return type

[**ApplicationSubmitResponse**](ApplicationSubmitResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **verifyMyKad**
> KycVerifyResponse verifyMyKad(myKadVerifyRequest)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getOnboardingControllerOnboardingServiceApi();
final MyKadVerifyRequest myKadVerifyRequest = ; // MyKadVerifyRequest | 

try {
    final response = api.verifyMyKad(myKadVerifyRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling OnboardingControllerOnboardingServiceApi->verifyMyKad: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **myKadVerifyRequest** | [**MyKadVerifyRequest**](MyKadVerifyRequest.md)|  | 

### Return type

[**KycVerifyResponse**](KycVerifyResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **verifyMyKadKyc**
> BuiltMap<String, JsonObject> verifyMyKadKyc(requestBody)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getOnboardingControllerOnboardingServiceApi();
final BuiltMap<String, String> requestBody = ; // BuiltMap<String, String> | 

try {
    final response = api.verifyMyKadKyc(requestBody);
    print(response);
} on DioException catch (e) {
    print('Exception when calling OnboardingControllerOnboardingServiceApi->verifyMyKadKyc: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **requestBody** | [**BuiltMap&lt;String, String&gt;**](String.md)|  | 

### Return type

[**BuiltMap&lt;String, JsonObject&gt;**](JsonObject.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

