import 'package:dio/dio.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';

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
}
