# agent_api.api.AuthControllerAuthIamServiceApi

## Load the API package
```dart
import 'package:agent_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**authenticateUser**](AuthControllerAuthIamServiceApi.md#authenticateuser) | **POST** /api/v1/auth/token | 
[**getMyProfile**](AuthControllerAuthIamServiceApi.md#getmyprofile) | **GET** /api/v1/auth/me | Get current user profile
[**refreshToken**](AuthControllerAuthIamServiceApi.md#refreshtoken) | **POST** /api/v1/auth/refresh | 
[**revokeToken**](AuthControllerAuthIamServiceApi.md#revoketoken) | **POST** /api/v1/auth/revoke | 


# **authenticateUser**
> TokenResponse authenticateUser(tokenRequest)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getAuthControllerAuthIamServiceApi();
final TokenRequest tokenRequest = ; // TokenRequest | 

try {
    final response = api.authenticateUser(tokenRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AuthControllerAuthIamServiceApi->authenticateUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **tokenRequest** | [**TokenRequest**](TokenRequest.md)|  | 

### Return type

[**TokenResponse**](TokenResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMyProfile**
> MyProfileResponse getMyProfile()

Get current user profile

Returns the profile of the currently authenticated user. For external agents, includes linked agentId.

### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getAuthControllerAuthIamServiceApi();

try {
    final response = api.getMyProfile();
    print(response);
} on DioException catch (e) {
    print('Exception when calling AuthControllerAuthIamServiceApi->getMyProfile: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**MyProfileResponse**](MyProfileResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **refreshToken**
> TokenResponse refreshToken(refreshTokenRequest)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getAuthControllerAuthIamServiceApi();
final RefreshTokenRequest refreshTokenRequest = ; // RefreshTokenRequest | 

try {
    final response = api.refreshToken(refreshTokenRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AuthControllerAuthIamServiceApi->refreshToken: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **refreshTokenRequest** | [**RefreshTokenRequest**](RefreshTokenRequest.md)|  | 

### Return type

[**TokenResponse**](TokenResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **revokeToken**
> revokeToken(revokeTokenRequest)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getAuthControllerAuthIamServiceApi();
final RevokeTokenRequest revokeTokenRequest = ; // RevokeTokenRequest | 

try {
    api.revokeToken(revokeTokenRequest);
} on DioException catch (e) {
    print('Exception when calling AuthControllerAuthIamServiceApi->revokeToken: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **revokeTokenRequest** | [**RevokeTokenRequest**](RevokeTokenRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

