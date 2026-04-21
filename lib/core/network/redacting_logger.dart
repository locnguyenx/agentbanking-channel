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

  bool get _disabled => const bool.fromEnvironment('DISABLE_DIO_LOGS', defaultValue: false);

  // Regex patterns for PII
  static final RegExp _myKadRegex = RegExp(r'\b\d{6}-?\d{2}-?\d{4}\b|\b\d{12}\b');
  static final RegExp _cvvKeyRegex = RegExp(r'"cvv"\s*:\s*"\d{3,4}"', caseSensitive: false);
  static final RegExp _pinBlockKeyRegex = RegExp(r'"pinBlock"\s*:\s*"[^"]+"', caseSensitive: false);

  String redact(String text) {
    var redacted = text;
    
    // 1. Mask MyKad (NRIC) - Show only birth date part (first 6)
    redacted = redacted.replaceAllMapped(_myKadRegex, (match) {
      final s = match.group(0)!;
      final clean = s.replaceAll('-', '');
      if (clean.length == 12) {
        if (s.contains('-')) {
          return '${clean.substring(0, 6)}-**-****';
        }
        return '${clean.substring(0, 6)}******';
      }
      return s;
    });

    // 2. PAN (Card Number) is no longer masked (treated as normal account number)
    // accordance with AGENTS.md § 3.3 Security

    // 3. Mask CVV and PIN Block fields specifically in JSON-like strings
    redacted = redacted.replaceAllMapped(_cvvKeyRegex, (match) => '"cvv": "***"');
    redacted = redacted.replaceAllMapped(_pinBlockKeyRegex, (match) => '"pinBlock": "[REDACTED]"');

    return redacted;
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (logRequest && !_disabled) {
      final message = 'NETWORK REQUEST: [${options.method}] ${options.uri}\n'
          'Headers: ${options.headers}\n'
          'Body: ${redact(options.data?.toString() ?? 'EMPTY')}';
      dev.log(message, name: 'AgentBanking.Network');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (logResponse && !_disabled) {
      final message = 'NETWORK RESPONSE: [${response.statusCode}] ${response.requestOptions.uri}\n'
          'Data: ${redact(response.data?.toString() ?? 'EMPTY')}';
      dev.log(message, name: 'AgentBanking.Network');
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (logError && !_disabled) {
      final message = 'NETWORK ERROR: ${err.message}\n'
          'Path: ${err.requestOptions.uri}\n'
          'Error Data: ${redact(err.response?.data?.toString() ?? 'EMPTY')}';
      dev.log(message, name: 'AgentBanking.Network', level: 1000); // 1000 = severe
    }
    handler.next(err);
  }
}
