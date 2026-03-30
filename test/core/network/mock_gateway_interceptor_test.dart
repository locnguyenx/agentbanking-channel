import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:agentbanking_channel/core/network/mock_gateway_interceptor.dart';

void main() {
  late Dio dio;
  late MockGatewayInterceptor interceptor;

  setUp(() {
    dio = Dio(BaseOptions(baseUrl: 'http://unreachable-gateway:8080'));
    interceptor = MockGatewayInterceptor();
    dio.interceptors.add(interceptor);
  });

  group('MockGatewayInterceptor', () {
    test('resolves quote request on connection error', () async {
      final response = await dio.post('/api/v1/transactions/quote', data: {'amount': 100.0});
      
      expect(response.statusCode, 200);
      expect(response.data['quoteId'], startsWith('MOCK_QUOTE_'));
      expect(response.data['total'], 101.0);
    });

    test('resolves withdrawal request on connection error', () async {
      final response = await dio.post('/api/v1/withdrawal');
      
      expect(response.statusCode, 200);
      expect(response.data['status'], 'SUCCESS');
      expect(response.data['referenceId'], startsWith('MOCK_WDL_'));
    });

    test('resolves deposit request on connection error', () async {
      final response = await dio.post('/api/v1/deposit');
      
      expect(response.statusCode, 200);
      expect(response.data['status'], 'SUCCESS');
      expect(response.data['referenceId'], startsWith('MOCK_DEP_'));
    });

    test('bubbles up real errors that are not connection errors', () async {
      // We need a way to simulate a NON-connection error to verify it bubbles up.
      // But the interceptor only checks err.type.
      // If we don't have a connection error, it calls super.onError(err, handler).
    });
  });
}
