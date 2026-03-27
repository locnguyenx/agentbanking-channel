import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/core/network/idempotency_interceptor.dart';

void main() {
  late IdempotencyInterceptor interceptor;

  setUp(() {
    interceptor = IdempotencyInterceptor();
  });

  test('adds X-Idempotency-Key header to POST requests', () async {
    final options = RequestOptions(path: '/test', method: 'POST');
    final handler = RequestInterceptorHandler();

    await interceptor.onRequest(options, handler);

    expect(options.headers.containsKey('X-Idempotency-Key'), isTrue);
    expect(options.headers['X-Idempotency-Key'], isNotEmpty);
  });

  test('does not add X-Idempotency-Key header to GET requests', () async {
    final options = RequestOptions(path: '/test', method: 'GET');
    final handler = RequestInterceptorHandler();

    await interceptor.onRequest(options, handler);

    expect(options.headers.containsKey('X-Idempotency-Key'), isFalse);
  });
}
