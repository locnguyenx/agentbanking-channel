# agent_api.api.AgentControllerOnboardingServiceApi

## Load the API package
```dart
import 'package:agent_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createAgent**](AgentControllerOnboardingServiceApi.md#createagent) | **POST** /api/v1/backoffice/agents | 
[**deactivateAgent**](AgentControllerOnboardingServiceApi.md#deactivateagent) | **DELETE** /api/v1/backoffice/agents/{id} | 
[**getAgent**](AgentControllerOnboardingServiceApi.md#getagent) | **GET** /api/v1/backoffice/agents/{id} | 
[**listAgents**](AgentControllerOnboardingServiceApi.md#listagents) | **GET** /api/v1/backoffice/agents | 
[**updateAgent**](AgentControllerOnboardingServiceApi.md#updateagent) | **PUT** /api/v1/backoffice/agents/{id} | 


# **createAgent**
> AgentResponse createAgent(createAgentExternalRequest)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getAgentControllerOnboardingServiceApi();
final CreateAgentExternalRequest createAgentExternalRequest = ; // CreateAgentExternalRequest | 

try {
    final response = api.createAgent(createAgentExternalRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AgentControllerOnboardingServiceApi->createAgent: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createAgentExternalRequest** | [**CreateAgentExternalRequest**](CreateAgentExternalRequest.md)|  | 

### Return type

[**AgentResponse**](AgentResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deactivateAgent**
> deactivateAgent(id)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getAgentControllerOnboardingServiceApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.deactivateAgent(id);
} on DioException catch (e) {
    print('Exception when calling AgentControllerOnboardingServiceApi->deactivateAgent: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAgent**
> AgentResponse getAgent(id)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getAgentControllerOnboardingServiceApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.getAgent(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AgentControllerOnboardingServiceApi->getAgent: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**AgentResponse**](AgentResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listAgents**
> BuiltList<AgentResponse> listAgents(page, size)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getAgentControllerOnboardingServiceApi();
final int page = 56; // int | 
final int size = 56; // int | 

try {
    final response = api.listAgents(page, size);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AgentControllerOnboardingServiceApi->listAgents: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **int**|  | [optional] [default to 0]
 **size** | **int**|  | [optional] [default to 20]

### Return type

[**BuiltList&lt;AgentResponse&gt;**](AgentResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateAgent**
> AgentResponse updateAgent(id, updateAgentRequest)



### Example
```dart
import 'package:agent_api/api.dart';

final api = AgentApi().getAgentControllerOnboardingServiceApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final UpdateAgentRequest updateAgentRequest = ; // UpdateAgentRequest | 

try {
    final response = api.updateAgent(id, updateAgentRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AgentControllerOnboardingServiceApi->updateAgent: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updateAgentRequest** | [**UpdateAgentRequest**](UpdateAgentRequest.md)|  | 

### Return type

[**AgentResponse**](AgentResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

