import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';

class ManualMockDio extends Mock implements Dio {
  final Map<String, List<Map<String, dynamic>>> _responses = {};

  void setResponse(String path, dynamic data, {int statusCode = 200}) {
    if (data is List) {
      for (var item in data) {
        _responses.putIfAbsent(path, () => []).add({'data': item, 'statusCode': statusCode});
      }
    } else {
      _responses.putIfAbsent(path, () => []).add({'data': data, 'statusCode': statusCode});
    }
  }

  @override
  Future<Response<T>> get<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    return _handleRequest<T>(path);
  }

  @override
  Future<Response<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return _handleRequest<T>(path);
  }

  @override
  Future<Response<T>> request<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return _handleRequest<T>(path);
  }

  Future<Response<T>> _handleRequest<T>(String path) async {
    // 1. Try exact match first
    var responses = _responses[path];
    
    // 2. Try regex match if no exact match
    if (responses == null) {
      final matchingKey = _responses.keys.firstWhere(
        (key) => RegExp(key).hasMatch(path),
        orElse: () => '',
      );
      if (matchingKey.isNotEmpty) {
        responses = _responses[matchingKey];
      }
    }

    if (responses != null && responses.isNotEmpty) {
      final response = responses.length > 1 ? responses.removeAt(0) : responses[0];
      return Response<T>(
        data: response['data'] as T,
        statusCode: response['statusCode'] as int,
        requestOptions: RequestOptions(path: path),
      );
    }
    throw DioException(
      requestOptions: RequestOptions(path: path),
      error: 'No mock response for $path. Available: ${_responses.keys}',
    );
  }

  @override
  BaseOptions get options => BaseOptions();
}
