import 'package:dio/dio.dart';
import 'dart:developer' as dev;

/// A custom Dio [Interceptor] that redacts PII (Personally Identifiable Information)
/// from logs to ensure compliance with Bank Malaysia standards and zero-trust architecture.
class RedactingLogger extends Interceptor {
  final bool logRequest;
  final bool logResponse;
  final bool logError;

  RedactingLogger({
    this.logRequest = true,
    this.logResponse = true,
    this.logError = true,
  });

  // Regex patterns for PII
  static final RegExp _myKadRegex = RegExp(r'\b\d{6}-?\d{2}-?\d{4}\b');
  static final RegExp _panRegex = RegExp(r'\b\d{4}[ -]?\d{4}[ -]?\d{4}[ -]?\d{4}\b');
  static final RegExp _cvvRegex = RegExp(r'\b\d{3,4}\b');

  String redact(String text) {
    var redacted = text;
    
    // Mask MyKad (NRIC) - Show only birth date part
    redacted = redacted.replaceAllMapped(_myKadRegex, (match) {
      final s = match.group(0)!;
      if (s.contains('-')) {
        return '${s.substring(0, 6)}-**-****';
      }
      return '${s.substring(0, 6)}******';
    });

    // Mask PAN (Card Number) - Show first 4 and last 4
    redacted = redacted.replaceAllMapped(_panRegex, (match) {
      final s = match.group(0)!;
      final clean = s.replaceAll(RegExp(r'[ -]'), '');
      if (clean.length == 16) {
        return '${clean.substring(0, 4)} **** **** ${clean.substring(12)}';
      }
      return '**** **** **** ****';
    });

    return redacted;
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (logRequest) {
      final message = 'NETWORK REQUEST: [${options.method}] ${options.uri}\n'
          'Headers: ${options.headers}\n'
          'Body: ${redact(options.data?.toString() ?? 'EMPTY')}';
      dev.log(message, name: 'AgentBanking.Network');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (logResponse) {
      final message = 'NETWORK RESPONSE: [${response.statusCode}] ${response.requestOptions.uri}\n'
          'Data: ${redact(response.data?.toString() ?? 'EMPTY')}';
      dev.log(message, name: 'AgentBanking.Network');
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (logError) {
      final message = 'NETWORK ERROR: ${err.message}\n'
          'Path: ${err.requestOptions.uri}\n'
          'Error Data: ${redact(err.response?.data?.toString() ?? 'EMPTY')}';
      dev.log(message, name: 'AgentBanking.Network', level: 1000); // 1000 = severe
    }
    handler.next(err);
  }
}
