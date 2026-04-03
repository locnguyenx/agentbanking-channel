import 'package:dio/dio.dart';

/// Interceptor that provides mock responses when the API Gateway is unreachable.
/// This matches the 'Mock Gateway' project rule while maintaining real app logic.
class MockGatewayInterceptor extends Interceptor {
  final Map<String, int> _pollCounts = {};

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final path = options.path;

    // Handle Bill Status Polling (US-CA-17 / JomPay / Bills)
    if (path.startsWith('/api/v1/bill/status/')) {
      final refId = path.split('/').last;
      _pollCounts[refId] = (_pollCounts[refId] ?? 0) + 1;
      
      // Simulate real-world delay: 2 x PENDING (10s) -> SUCCESS
      final status = _pollCounts[refId]! >= 3 ? 'SUCCESS' : 'PENDING';
      
      return handler.resolve(Response(
        requestOptions: options,
        data: {'status': status, 'referenceId': refId},
        statusCode: 200,
      ));
    }

    // Handle Quote Requests
    if (path == '/api/v1/transactions/quote') {
      final data = options.data as Map<String, dynamic>?;
      final amount = data?['amount'] ?? 0.0;

      return handler.resolve(Response(
        requestOptions: options,
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
        requestOptions: options,
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
        requestOptions: options,
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
        requestOptions: options,
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
        requestOptions: options,
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
        requestOptions: options,
        data: {
          'status': 'SUCCESS',
          'referenceId': 'MOCK_DN_${DateTime.now().millisecondsSinceEpoch}',
        },
        statusCode: 200,
      ));
    }

    // Handle Cashless Payment (Retail Sale)
    if (path == '/api/v1/retail/sale') {
      final data = options.data as Map<String, dynamic>?;
      final amount = data?['amount'] ?? 0.0;
      // Calculate MDR: 1% for Card, 0.5% for others (mock logic)
      final mdr = (amount * 0.01 * 100).round() / 100;
      final net = (amount - mdr * 100).round() / 100; // Actually simpler: (amount - mdr)
      
      return handler.resolve(Response(
        requestOptions: options,
        data: {
          'status': 'SUCCESS',
          'referenceId': 'MOCK_SALE_${DateTime.now().millisecondsSinceEpoch}',
          'mdrAmount': mdr,
          'netToMerchant': (amount - mdr).toDouble(),
        },
        statusCode: 200,
      ));
    }

    // Handle Retail PIN Purchase
    if (path == '/api/v1/retail/pin-purchase') {
      return handler.resolve(Response(
        requestOptions: options,
        data: {
          'status': 'SUCCESS',
          'referenceId': 'MOCK_PIN_${DateTime.now().millisecondsSinceEpoch}',
        },
        statusCode: 200,
      ));
    }

    // Handle Retail QR Generation (NEW)
    if (path == '/api/v1/retail/qr') {
      final data = options.data as Map<String, dynamic>?;
      final amount = data?['amount'] ?? 0.0;
      final refId = 'QR_${DateTime.now().millisecondsSinceEpoch}_AMT_$amount';
      return handler.resolve(Response(
        requestOptions: options,
        data: {
          'qrPayload': 'duitnow-qr-payload-for-$refId',
          'referenceId': refId,
        },
        statusCode: 200,
      ));
    }

    // Handle Retail Cashback
    if (path == '/api/v1/retail/cashback') {
      return handler.resolve(Response(
        requestOptions: options,
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
        requestOptions: options,
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
        requestOptions: options,
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
        requestOptions: options,
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
        requestOptions: options,
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
        requestOptions: options,
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
        requestOptions: options,
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
        requestOptions: options,
        data: {
          'matchScore': 95.5,
          'status': 'SUCCESS',
        },
        statusCode: 200,
      ));
    }

    // Handle DuitNow Transfer/QR Status
    if (path.startsWith('/api/v1/transfer/duitnow/status/')) {
      final refId = path.split('/').last;
      final isQr = refId.startsWith('QR_');
      
      Map<String, dynamic> responseData = {
        'status': isQr ? 'COMPLETED' : 'SUCCESS',
        'referenceId': refId,
      };

      if (isQr) {
        // Extract amount from refId if we encoded it earlier
        double amount = 50.0;
        if (refId.contains('_AMT_')) {
          amount = double.tryParse(refId.split('_AMT_').last) ?? 50.0;
        }
        final mdr = (amount * 0.005 * 100).round() / 100;
        responseData.addAll({
          'amount': amount,
          'mdrAmount': mdr,
          'netToMerchant': (amount - mdr),
          'transactionId': 'TXN_$refId',
        });
      }

      return handler.resolve(Response(
        requestOptions: options,
        data: responseData,
        statusCode: 200,
      ));
    }

    super.onRequest(options, handler);
  }
}
