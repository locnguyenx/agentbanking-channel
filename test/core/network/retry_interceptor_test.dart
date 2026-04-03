import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:agentbanking_channel/core/network/retry_interceptor.dart';

@GenerateMocks([Dio, ErrorInterceptorHandler])
import 'retry_interceptor_test.mocks.dart';

void main() {
  late RetryInterceptor interceptor;
  late MockDio mockDio;
  late MockErrorInterceptorHandler mockHandler;

  setUp(() {
    mockDio = MockDio();
    mockHandler = MockErrorInterceptorHandler();
    interceptor = RetryInterceptor(dio: mockDio, maxRetries: 4);
  });

  group('RetryInterceptor BDD Tests', () {
    test('Retries non-financial requests on transient error (BDD @US-CA-23)', () async {
      final options = RequestOptions(path: '/api/v1/merchants/profile');
      final error = DioException(
        requestOptions: options,
        type: DioExceptionType.connectionTimeout,
      );

      // We expect the interceptor to attempt a retry via dio.fetch
      when(mockDio.fetch(any)).thenAnswer((_) async => Response(
        requestOptions: options,
        statusCode: 200,
        data: {'status': 'ok'},
      ));

      // This is tricky to test with Future.delayed, but we can verify it calls dio.fetch
      await interceptor.onError(error, mockHandler);

      verify(mockDio.fetch(argThat(predicate((RequestOptions o) => o.extra['retryCount'] == 1)))).called(1);
    });

    test('DO NOT retry financial requests (BDD @US-CA-23 Safety Rule)', () async {
      final options = RequestOptions(path: '/api/v1/payments/execute');
      final error = DioException(
        requestOptions: options,
        type: DioExceptionType.connectionTimeout,
      );

      await interceptor.onError(error, mockHandler);

      // Should call next(err) immediately without calling dio.fetch
      verify(mockHandler.next(error)).called(1);
      verifyNever(mockDio.fetch(any));
    });

    test('Stops after max retries (BDD @US-CA-23)', () async {
      final options = RequestOptions(path: '/api/v1/config', extra: {'retryCount': 4});
      final error = DioException(
        requestOptions: options,
        type: DioExceptionType.connectionTimeout,
      );

      await interceptor.onError(error, mockHandler);

      // Should give up and call next(err)
      verify(mockHandler.next(error)).called(1);
      verifyNever(mockDio.fetch(any));
    });
  });
}
