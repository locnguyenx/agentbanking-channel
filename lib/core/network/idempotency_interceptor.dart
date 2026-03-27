import 'package:dio/dio.dart';

import 'package:uuid/uuid.dart';

class IdempotencyInterceptor extends Interceptor {
  final Uuid _uuid = const Uuid();

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final method = options.method.toUpperCase();
    if (method == 'POST' || method == 'PUT' || method == 'PATCH' || method == 'DELETE') {
      options.headers['X-Idempotency-Key'] = _uuid.v4();
    }
    super.onRequest(options, handler);
  }
}
