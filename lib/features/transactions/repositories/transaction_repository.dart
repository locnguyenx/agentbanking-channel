import 'package:dio/dio.dart';
import 'package:decimal/decimal.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/merchant/models/merchant_models.dart';

class TransactionRepository {
  final Dio dio;

  TransactionRepository(this.dio);

  Future<TransactionQuoteResponse> getQuote(TransactionQuoteRequest request) async {
    try {
      final response = await dio.post(
        '/api/v1/transactions/quote',
        data: request.toJson(),
      );
      return TransactionQuoteResponse.fromJson(response.data);
    } catch (e) {
      if (e is DioException && e.response?.statusCode == 200) {
        return TransactionQuoteResponse.fromJson(e.response!.data);
      }
      rethrow;
    }
  }

  Future<TransactionExecutionResponse> executeTransaction(TransactionExecutionRequest request) async {
    try {
      final response = await dio.post(
        '/api/v1/transactions/execute',
        data: request.toJson(),
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
