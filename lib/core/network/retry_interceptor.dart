import 'dart:async';
import 'dart:math';
import 'package:dio/dio.dart';

/// Interceptor that implements exponential backoff for non-financial requests.
/// BDD @US-CA-23 FR-CA-10.1: [1s, 2s, 4s, 8s]
class RetryInterceptor extends Interceptor {
  final Dio dio;
  final int maxRetries;

  RetryInterceptor({required this.dio, this.maxRetries = 4});

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final requestOptions = err.requestOptions;

    // BDD Requirement: Non-financial requests ONLY.
    // Financial requests (e.g., Execute DuitNow, EMV Transaction) MUST NOT retry 
    // automatically to prevent double-billing risks.
    if (_isFinancialRequest(requestOptions)) {
      return handler.next(err);
    }

    // Only retry on transient network errors
    if (!_isRetryable(err)) {
      return handler.next(err);
    }

    int retryCount = requestOptions.extra['retryCount'] ?? 0;

    if (retryCount < maxRetries) {
      retryCount++;
      requestOptions.extra['retryCount'] = retryCount;

      // Exponential backoff: 2^(retryCount-1) seconds
      // 1st: 1s, 2rd: 2s, 3rd: 4s, 4th: 8s
      final delaySeconds = pow(2, retryCount - 1).toInt();
      
      await Future.delayed(Duration(seconds: delaySeconds));

      try {
        final response = await dio.fetch(requestOptions);
        return handler.resolve(response);
      } on DioException catch (retryErr) {
        return onError(retryErr, handler);
      }
    }

    return handler.next(err);
  }

  bool _isFinancialRequest(RequestOptions options) {
    final path = options.path.toLowerCase();
    // Broad detection of financial endpoints based on API spec/conventions
    return path.contains('/execute') || 
           path.contains('/initiate') || 
           path.contains('/debit') || 
           path.contains('/credit') ||
           path.contains('/payment');
  }

  bool _isRetryable(DioException err) {
    return err.type == DioExceptionType.connectionTimeout ||
           err.type == DioExceptionType.sendTimeout ||
           err.type == DioExceptionType.receiveTimeout ||
           err.type == DioExceptionType.connectionError ||
           (err.response?.statusCode != null && err.response!.statusCode! >= 500);
  }
}
