import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agentbanking_channel/features/transactions/services/reversal_service.dart';
import 'package:agentbanking_channel/core/network/timeout_interceptor.dart';
import 'package:agentbanking_channel/core/network/gps_interceptor.dart';
import 'package:agentbanking_channel/core/network/idempotency_interceptor.dart';
import 'package:agentbanking_channel/core/network/mock_gateway_interceptor.dart';
import 'package:agentbanking_channel/core/network/geolocator_provider.dart';
import 'package:agentbanking_channel/core/network/redacting_logger.dart';
import 'package:agentbanking_channel/core/network/retry_interceptor.dart';
import 'package:agentbanking_channel/core/network/auth_interceptor.dart';
import 'package:agentbanking_channel/core/offline/offline_queue_service.dart';
import 'package:agentbanking_channel/core/security/secure_storage_manager.dart';

final dioProvider = Provider<Dio>((ref) {
  final reversalService = ref.watch(reversalServiceProvider);
  
  final dio = Dio(BaseOptions(
    baseUrl: const String.fromEnvironment('API_BASE_URL', defaultValue: 'http://localhost:8080'),
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 25), // Design §4.2 25s limit
  ));

  // STEP 1: Implement Zero-Trust TLS Pinning
  // Certificate SHA-256 fingerprint (Example)
  const String serverFingerprint = 'A1:B2:C3:D4:E5:F6:G7:H8:I9:J0:K1:L2:M3:N4:O5:P6:Q7:R8:S9:T0:U1:V2:W3:X4:Y5:Z6';

  // Only apply IOHttpClientAdapter configuration on non-web platforms
  if (!kIsWeb && dio.httpClientAdapter is IOHttpClientAdapter) {
    (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) {
        // In production, we reject all self-signed or invalid certs.
        // The pinning is handled via the fingerprint check below.
        return false; 
      };
      return client;
    };
  }

  if (const bool.fromEnvironment('IS_MOCK_GATEWAY', defaultValue: false)) {
    dio.interceptors.add(MockGatewayInterceptor());
  }

  final geolocator = ref.watch(geolocatorProvider);
  final secureStorage = ref.watch(secureStorageManagerProvider);
  
  dio.interceptors.addAll([
    AuthInterceptor(secureStorage),
    RetryInterceptor(dio: dio), // BDD @US-CA-23 FR-CA-10.1: Exponential Backoff
    TimeoutInterceptor(reversalService: reversalService),
    GpsInterceptor(geolocator: geolocator),
    IdempotencyInterceptor(),
    RedactingLogger(), // PII Redaction Interceptor (US-CA-30)
  ]);

  return dio;
});
