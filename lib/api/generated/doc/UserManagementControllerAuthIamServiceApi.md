# agent_api.api.UserManagementControllerAuthIamServiceApi

## Load the API package
```dart
import 'package:agent_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**changePassword**](UserManagementControllerAuthIamServiceApi.md#changepassword) | **POST** /api/v1/auth/password/change | 
[**createAgentUser**](UserManagementControllerAuthIamServiceApi.md#createagentuser) | **POST** /api/v1/backoffice/agents/{agentId}/create-user | 
[**forgotPassword**](UserManagementControllerAuthIamServiceApi.md#forgotpassword) | **POST** /api/v1/auth/password/forgot | 
[**getAgentUserStatus**](UserManagementControllerAuthIamServiceApi.md#getagentuserstatus) | **GET** /api/v1/backoffice/agents/{agentId}/user-status | 
[**resetPassword**](UserManagementControllerAuthIamServiceApi.md#resetpassword) | **POST** /api/v1/auth/password/reset | 


# **changePassword**
> ChangePasswordResponse changePassword(changePasswordRequest)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getUserManagementControllerAuthIamServiceApi();
final ChangePasswordRequest changePasswordRequest = ; // ChangePasswordRequest | 

try {
    final response = api.changePassword(changePasswordRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling UserManagementControllerAuthIamServiceApi->changePassword: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **changePasswordRequest** | [**ChangePasswordRequest**](ChangePasswordRequest.md)|  | 

### Return type

[**ChangePasswordResponse**](ChangePasswordResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createAgentUser**
> UserResponse createAgentUser(agentId, createAgentUserRequest)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getUserManagementControllerAuthIamServiceApi();
final String agentId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final CreateAgentUserRequest createAgentUserRequest = ; // CreateAgentUserRequest | 

try {
    final response = api.createAgentUser(agentId, createAgentUserRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling UserManagementControllerAuthIamServiceApi->createAgentUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **agentId** | **String**|  | 
 **createAgentUserRequest** | [**CreateAgentUserRequest**](CreateAgentUserRequest.md)|  | 

### Return type

[**UserResponse**](UserResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **forgotPassword**
> ForgotPasswordResponse forgotPassword(forgotPasswordRequest)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getUserManagementControllerAuthIamServiceApi();
final ForgotPasswordRequest forgotPasswordRequest = ; // ForgotPasswordRequest | 

try {
    final response = api.forgotPassword(forgotPasswordRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling UserManagementControllerAuthIamServiceApi->forgotPassword: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **forgotPasswordRequest** | [**ForgotPasswordRequest**](ForgotPasswordRequest.md)|  | 

### Return type

[**ForgotPasswordResponse**](ForgotPasswordResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAgentUserStatus**
> AgentUserStatusResponse getAgentUserStatus(agentId)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getUserManagementControllerAuthIamServiceApi();
final String agentId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getAgentUserStatus(agentId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling UserManagementControllerAuthIamServiceApi->getAgentUserStatus: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **agentId** | **String**|  | 

### Return type

[**AgentUserStatusResponse**](AgentUserStatusResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **resetPassword**
> ResetPasswordResponse resetPassword(resetPasswordRequest)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getUserManagementControllerAuthIamServiceApi();
final ResetPasswordRequest resetPasswordRequest = ; // ResetPasswordRequest | 

try {
    final response = api.resetPassword(resetPasswordRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling UserManagementControllerAuthIamServiceApi->resetPassword: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **resetPasswordRequest** | [**ResetPasswordRequest**](ResetPasswordRequest.md)|  | 

### Return type

[**ResetPasswordResponse**](ResetPasswordResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

