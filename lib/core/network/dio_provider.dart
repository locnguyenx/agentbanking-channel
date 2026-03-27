import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agentbanking_channel/core/network/gps_interceptor.dart';
import 'package:agentbanking_channel/core/network/idempotency_interceptor.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 25), // Design §4.2 25s limit
  ));

  dio.interceptors.addAll([
    GpsInterceptor(),
    IdempotencyInterceptor(),
    LogInterceptor(requestBody: true, responseBody: true), // For non-PII logging
  ]);

  return dio;
});
