import 'package:dio/dio.dart';
import 'package:agent_api/agent_api.dart';

class AppErrorFormatter {
  static String format(Object e) {
    if (e is DioException) {
      return _formatDioException(e);
    }
    
    final errorStr = e.toString();
    if (errorStr.contains('ERR_AUTH_DEVICE_NOT_WHITELISTED')) {
      return 'Device not whitelisted. Please contact your administrator.';
    }
    
    if (e is UnimplementedError) {
        return 'Feature not implemented yet.';
    }

    return 'An unexpected error occurred. Please try again.';
  }

  static String _formatDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timed out. Please check your internet and try again.';
      case DioExceptionType.badResponse:
        final status = e.response?.statusCode;
        if (status == 401) {
          return 'Invalid Agent ID or Password.';
        }
        if (status == 403) {
          return 'Access denied. Your account may be locked.';
        }
        if (status == 404) {
          return 'Service not found. Please contact support.';
        }
        
        // Try to extract message from ErrorResponse
        try {
          final data = e.response?.data;
          if (data != null) {
             // In a real app, we would use serializers.deserialize
             // For now, simple check
             if (data is Map && data['error'] != null && data['error']['message'] != null) {
                return data['error']['message'] as String;
             }
          }
        } catch (_) {}
        
        return 'Server error ($status). Please try again later.';
      case DioExceptionType.cancel:
        return 'Request cancelled.';
      case DioExceptionType.connectionError:
          return 'Unable to connect to the server. Please check your connection.';
      default:
        return 'Network error. Please try again.';
    }
  }
}
