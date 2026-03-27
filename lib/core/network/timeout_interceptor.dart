import 'package:dio/dio.dart';
import 'package:agentbanking_channel/features/transactions/services/reversal_service.dart';

class TimeoutInterceptor extends Interceptor {
  final ReversalService _reversalService;

  TimeoutInterceptor({required ReversalService reversalService})
      : _reversalService = reversalService;

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final isTimeout = err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout;

    if (isTimeout) {
      final options = err.requestOptions;
      final requiresReversal = options.extra['requiresReversal'] == true;

      if (requiresReversal) {
        // Queue MTI 0400 Reversal
        await _reversalService.queueReversal({
          'path': options.path,
          'method': options.method,
          'data': options.data,
          'idempotencyKey': options.headers['X-Idempotency-Key'],
        });
      }
    }
    super.onError(err, handler);
  }
}
