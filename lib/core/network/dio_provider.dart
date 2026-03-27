import 'package:agentbanking_channel/features/transactions/services/reversal_service.dart';
import 'package:agentbanking_channel/core/network/timeout_interceptor.dart';

final dioProvider = Provider<Dio>((ref) {
  final reversalService = ref.watch(reversalServiceProvider);
  
  final dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 25), // Design §4.2 25s limit
  ));

  dio.interceptors.addAll([
    TimeoutInterceptor(reversalService: reversalService),
    GpsInterceptor(),
    IdempotencyInterceptor(),
    LogInterceptor(requestBody: true, responseBody: true),
  ]);

  return dio;
});
