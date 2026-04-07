import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:agentbanking_channel/core/errors/error_formatter.dart';

void main() {
  group('ErrorFormatter', () {
    test('formats a 401 Unauthorized DioException', () {
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/'),
        response: Response(
          requestOptions: RequestOptions(path: '/'),
          statusCode: 401,
        ),
        type: DioExceptionType.badResponse,
      );

      final result = AppErrorFormatter.format(dioException);
      expect(result, 'Invalid Agent ID or Password.');
    });

    test('formats a 403 Forbidden DioException', () {
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/'),
        response: Response(
          requestOptions: RequestOptions(path: '/'),
          statusCode: 403,
        ),
        type: DioExceptionType.badResponse,
      );

      final result = AppErrorFormatter.format(dioException);
      expect(result, 'Access denied. Your account may be locked.');
    });

    test('formats a connection timeout DioException', () {
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/'),
        type: DioExceptionType.connectionTimeout,
      );

      final result = AppErrorFormatter.format(dioException);
      expect(result, contains('Connection timed out'));
    });

    test('formats a whitelisting error string', () {
      final result = AppErrorFormatter.format(Exception('ERR_AUTH_DEVICE_NOT_WHITELISTED'));
      expect(result, contains('Device not whitelisted'));
    });

    test('formats a custom ErrorResponse from API', () {
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/'),
        response: Response(
          requestOptions: RequestOptions(path: '/'),
          statusCode: 400,
          data: {
            'error': {
              'code': 'VAL_001',
              'message': 'Account balance is too low',
            }
          },
        ),
        type: DioExceptionType.badResponse,
      );

      final result = AppErrorFormatter.format(dioException);
      expect(result, 'Account balance is too low');
    });

    test('returns default message for unknown error', () {
      final result = AppErrorFormatter.format('Some random error');
      expect(result, 'An unexpected error occurred. Please try again.');
    });
  });
}
