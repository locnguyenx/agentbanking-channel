import 'package:dio/dio.dart';
import 'dart:async';

/// Interceptor that provides mock responses when the API Gateway is unreachable.
/// This matches the 'Mock Gateway' project rule while maintaining real app logic.
class MockGatewayInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Detect connection errors to the expected development gateway
    if (err.type == DioExceptionType.connectionError || 
        err.type == DioExceptionType.connectionTimeout) {
      
      final path = err.requestOptions.path;
      
      // Handle Quote Requests
      if (path == '/api/v1/transactions/quote') {
        final data = err.requestOptions.data as Map<String, dynamic>?;
        final amount = data?['amount'] ?? 0.0;
        
        return handler.resolve(Response(
          requestOptions: err.requestOptions,
          data: {
            'fee': 1.0,
            'commission': 0.5,
            'total': amount + 1.0,
            'quoteId': 'MOCK_QUOTE_${DateTime.now().millisecondsSinceEpoch}',
          },
          statusCode: 200,
        ));
      }

      // Handle Cash Withdrawal
      if (path == '/api/v1/withdrawal') {
        return handler.resolve(Response(
          requestOptions: err.requestOptions,
          data: {
            'status': 'SUCCESS',
            'referenceId': 'MOCK_WDL_${DateTime.now().millisecondsSinceEpoch}',
          },
          statusCode: 200,
        ));
      }

      // Handle Cash Deposit
      if (path == '/api/v1/deposit') {
        return handler.resolve(Response(
          requestOptions: err.requestOptions,
          data: {
            'status': 'SUCCESS',
            'referenceId': 'MOCK_DEP_${DateTime.now().millisecondsSinceEpoch}',
          },
          statusCode: 200,
        ));
      }

      // Handle Bill Payment
      if (path == '/api/v1/bill/pay') {
        return handler.resolve(Response(
          requestOptions: err.requestOptions,
          data: {
            'status': 'SUCCESS',
            'referenceId': 'MOCK_BILL_${DateTime.now().millisecondsSinceEpoch}',
          },
          statusCode: 200,
        ));
      }

      // Handle Prepaid Topup
      if (path == '/api/v1/topup') {
        return handler.resolve(Response(
          requestOptions: err.requestOptions,
          data: {
            'status': 'SUCCESS',
            'referenceId': 'MOCK_TOPUP_${DateTime.now().millisecondsSinceEpoch}',
          },
          statusCode: 200,
        ));
      }

      // Handle DuitNow Transfer
      if (path == '/api/v1/transfer/duitnow') {
        return handler.resolve(Response(
          requestOptions: err.requestOptions,
          data: {
            'status': 'SUCCESS',
            'referenceId': 'MOCK_DN_${DateTime.now().millisecondsSinceEpoch}',
          },
          statusCode: 200,
        ));
      }

      // Handle Cashless Payment (Retail Sale)
      if (path == '/api/v1/retail/sale') {
        return handler.resolve(Response(
          requestOptions: err.requestOptions,
          data: {
            'status': 'SUCCESS',
            'referenceId': 'MOCK_SALE_${DateTime.now().millisecondsSinceEpoch}',
          },
          statusCode: 200,
        ));
      }

      // Handle Retail PIN Purchase
      if (path == '/api/v1/retail/pin-purchase') {
        return handler.resolve(Response(
          requestOptions: err.requestOptions,
          data: {
            'status': 'SUCCESS',
            'referenceId': 'MOCK_PIN_${DateTime.now().millisecondsSinceEpoch}',
          },
          statusCode: 200,
        ));
      }

      // Handle Retail Cashback
      if (path == '/api/v1/retail/cashback') {
        return handler.resolve(Response(
          requestOptions: err.requestOptions,
          data: {
            'status': 'SUCCESS',
            'referenceId': 'MOCK_CB_${DateTime.now().millisecondsSinceEpoch}',
          },
          statusCode: 200,
        ));
      }

      // Handle E-Wallet Withdraw
      if (path == '/api/v1/ewallet/withdraw') {
        return handler.resolve(Response(
          requestOptions: err.requestOptions,
          data: {
            'status': 'SUCCESS',
            'referenceId': 'MOCK_EW_WDL_${DateTime.now().millisecondsSinceEpoch}',
          },
          statusCode: 200,
        ));
      }

      // Handle E-Wallet Topup
      if (path == '/api/v1/ewallet/topup') {
        return handler.resolve(Response(
          requestOptions: err.requestOptions,
          data: {
            'status': 'SUCCESS',
            'referenceId': 'MOCK_EW_TOP_${DateTime.now().millisecondsSinceEpoch}',
          },
          statusCode: 200,
        ));
      }

      // Handle eSSP Purchase
      if (path == '/api/v1/essp/purchase') {
        return handler.resolve(Response(
          requestOptions: err.requestOptions,
          data: {
            'status': 'SUCCESS',
            'referenceId': 'MOCK_ESSP_${DateTime.now().millisecondsSinceEpoch}',
          },
          statusCode: 200,
        ));
      }

      // Handle Balance Inquiry
      if (path == '/api/v1/balance-inquiry') {
        return handler.resolve(Response(
          requestOptions: err.requestOptions,
          data: {
            'balance': 5000.0,
            'currency': 'MYR',
          },
          statusCode: 200,
        ));
      }

      // Handle Agent Balance Fetch
      if (path.startsWith('/api/v1/agent/balance')) {
        return handler.resolve(Response(
          requestOptions: err.requestOptions,
          data: {
            'balance': 5000.0,
            'currency': 'MYR',
          },
          statusCode: 200,
        ));
      }

      // Handle KYC Verify
      if (path == '/api/v1/kyc/verify') {
        return handler.resolve(Response(
          requestOptions: err.requestOptions,
          data: {
            'status': 'APPROVED',
            'myKadNumber': '900101015566',
            'fullName': 'Mock User',
          },
          statusCode: 200,
        ));
      }

      // Handle KYC Biometric
      if (path == '/api/v1/kyc/biometric') {
        return handler.resolve(Response(
          requestOptions: err.requestOptions,
          data: {
            'matchScore': 95.5,
            'status': 'SUCCESS',
          },
          statusCode: 200,
        ));
      }

      // Handle DuitNow Transfer/QR Status
      if (path.startsWith('/api/v1/transfer/duitnow/status/')) {
        final isQr = path.contains('/QR_');
        return handler.resolve(Response(
          requestOptions: err.requestOptions,
          data: {
            'status': isQr ? 'COMPLETED' : 'SUCCESS',
            'referenceId': path.split('/').last,
          },
          statusCode: 200,
        ));
      }
    }
    
    super.onError(err, handler);
  }
}
