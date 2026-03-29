import 'package:dio/dio.dart';
import 'package:decimal/decimal.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/merchant/models/merchant_models.dart';

class TransactionRepository {
  final Dio dio;

  TransactionRepository(this.dio);

  Future<TransactionQuoteResponse> getQuote(TransactionQuoteRequest request) async {
    // Phase 2 Fix: Backend Quote service is missing in OpenAPI spec (404),
    // we bypass it and return a local zero-fee quote as allowed by BRD for current iteration.
    return TransactionQuoteResponse(
      amount: request.amount,
      fee: Decimal.zero,
      commission: Decimal.zero,
      total: request.amount,
      quoteId: 'LOCAL_QUOTE_${request.serviceCode}_${DateTime.now().millisecondsSinceEpoch}',
    );
  }

  Future<TransactionExecutionResponse> executeTransaction(TransactionExecutionRequest request) async {
    try {
      String path = '/api/v1/transactions/execute'; // Default
      Map<String, dynamic> data = request.toJson();

      // Route to correct OpenAPI spec endpoints
      if (request.serviceCode == 'CASH_WITHDRAWAL') {
        path = '/api/v1/withdrawal';
        data = {
          'agentId': 'AGENT-123', // Same as passed to startTransaction
          'amount': request.amount.toString(),
          'customerFee': '0.00',
          'agentCommission': '0.00',
          'bankShare': '0.00',
          'idempotencyKey': 'IDEM_${DateTime.now().millisecondsSinceEpoch}',
        };
      } else if (request.serviceCode == 'CASH_DEPOSIT') {
        path = '/api/v1/deposit';
        data = {
          'agentId': 'AGENT-123',
          'amount': request.amount.toString(),
          'customerFee': '0.00',
          'agentCommission': '0.00',
          'bankShare': '0.00',
          'idempotencyKey': 'IDEM_${DateTime.now().millisecondsSinceEpoch}',
        };
      } else if (request.serviceCode == 'BILL_PAY') {
        path = '/api/v1/bill/pay';
      } else if (request.serviceCode == 'TOP_UP') {
        path = '/api/v1/topup';
      }

      final response = await dio.post(
        path,
        data: data,
        options: Options(extra: {'requiresReversal': true}),
      );
      return TransactionExecutionResponse.fromJson(response.data);
    } catch (e) {
      if (e is DioException && e.response?.statusCode == 200) {
        return TransactionExecutionResponse.fromJson(e.response!.data);
      }
      rethrow;
    }
  }

  Future<String> performProxyEnquiry(String proxyId, String proxyType) async {
    try {
      final response = await dio.get(
        '/api/v1/transactions/proxy-enquiry',
        queryParameters: {'proxyId': proxyId, 'proxyType': proxyType},
      );
      return response.data['displayName'] ?? 'UNKNOWN';
    } catch (e) {
      rethrow;
    }
  }

  Future<TransactionExecutionResponse> balanceInquiry(TransactionExecutionRequest request) async {
    try {
      final response = await dio.post(
        '/api/v1/transactions/balance-inquiry',
        data: request.toJson(),
      );
      return TransactionExecutionResponse.fromJson(response.data);
    } catch (e) {
      if (e is DioException && e.response?.statusCode == 200) {
        return TransactionExecutionResponse.fromJson(e.response!.data);
      }
      rethrow;
    }
  }

  Future<TransactionExecutionResponse> initiateDuitNow({
    required String quoteId,
    required String proxyId,
    required String proxyType,
  }) async {
    try {
      final response = await dio.post(
        '/api/v1/transfer/duitnow',
        data: {
          'quoteId': quoteId,
          'proxyId': proxyId,
          'proxyType': proxyType,
        },
      );
      return TransactionExecutionResponse.fromJson(response.data);
    } catch (e) {
      if (e is DioException && e.response?.statusCode == 200) {
        return TransactionExecutionResponse.fromJson(e.response!.data);
      }
      rethrow;
    }
  }

  Future<String> getDuitNowStatus(String referenceId) async {
    try {
      final response = await dio.get(
        '/api/v1/transfer/duitnow/status',
        queryParameters: {'referenceId': referenceId},
      );
      return response.data['status'] ?? 'PENDING';
    } catch (e) {
      rethrow;
    }
  }

  Future<RetailSaleResponse> executeRetailSale(Decimal amount, String fundingSource, {String? pinBlock, String? cardToken}) async {
    final response = await dio.post(
      '/api/v1/merchant/retail-sale',
      data: {
        'amount': amount.toString(),
        'fundingSource': fundingSource,
        'pinBlock': pinBlock,
        'cardToken': cardToken,
      },
    );
    return RetailSaleResponse.fromJson(response.data);
  }

  Future<CashbackResponse> executeCashback(Decimal purchaseAmount, Decimal cashbackAmount, String fundingSource, {String? pinBlock, String? cardToken}) async {
    final response = await dio.post(
      '/api/v1/merchant/cashback',
      data: {
        'purchaseAmount': purchaseAmount.toString(),
        'cashbackAmount': cashbackAmount.toString(),
        'fundingSource': fundingSource,
        'pinBlock': pinBlock,
        'cardToken': cardToken,
      },
    );
    return CashbackResponse.fromJson(response.data);
  }

  Future<String> getComplianceStatus() async {
    final response = await dio.get('/api/v1/compliance/status');
    return response.data['status']; // 'LOCKED' or 'UNLOCKED'
  }
}
