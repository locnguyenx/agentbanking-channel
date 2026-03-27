import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:agentbanking_channel/core/network/timeout_interceptor.dart';
import 'package:agentbanking_channel/features/transactions/services/reversal_service.dart';

import 'timeout_interceptor_test.mocks.dart';

@GenerateMocks([ReversalService, RequestInterceptorHandler, ErrorInterceptorHandler])
void main() {
  late TimeoutInterceptor interceptor;
  late MockReversalService mockReversalService;

  setUp(() {
    mockReversalService = MockReversalService();
    interceptor = TimeoutInterceptor(reversalService: mockReversalService);
  });

  group('TimeoutInterceptor', () {
    test('queues reversal when a financial POST request times out', () async {
      final options = RequestOptions(
        path: '/api/v1/withdrawal',
        method: 'POST',
        extra: {'requiresReversal': true},
      );
      
      final dioException = DioException(
        requestOptions: options,
        type: DioExceptionType.receiveTimeout,
        error: 'Timeout',
      );

      final handler = MockErrorInterceptorHandler();

      await interceptor.onError(dioException, handler);

      verify(mockReversalService.queueReversal(any)).called(1);
    });

    test('does not queue reversal for non-financial GET requests', () async {
      final options = RequestOptions(
        path: '/api/v1/agent/balance',
        method: 'GET',
      );
      
      final dioException = DioException(
        requestOptions: options,
        type: DioExceptionType.receiveTimeout,
        error: 'Timeout',
      );

      final handler = MockErrorInterceptorHandler();

      await interceptor.onError(dioException, handler);

      verifyNever(mockReversalService.queueReversal(any));
    });
  });
}
