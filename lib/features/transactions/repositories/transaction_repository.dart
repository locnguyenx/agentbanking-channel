import 'package:dio/dio.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';

class TransactionRepository {
  final Dio dio;

  TransactionRepository(this.dio);

  Future<TransactionQuoteResponse> getQuote(TransactionQuoteRequest request) async {
    // Simulated API call to /api/v1/transactions/quote
    // In real implementation, this would use dio.post
    await Future.delayed(const Duration(milliseconds: 800));
    
    // Mock response
    final amount = request.amount;
    final fee = Decimal.parse('1.00');
    final commission = Decimal.parse('0.50');
    
    return TransactionQuoteResponse(
      amount: amount,
      fee: fee,
      commission: commission,
      total: amount + fee,
      quoteId: 'QUOTE_${DateTime.now().millisecondsSinceEpoch}',
    );
  }

  Future<TransactionExecutionResponse> executeTransaction(TransactionExecutionRequest request) async {
    // Simulated API call to /api/v1/transactions/execute
    await Future.delayed(const Duration(seconds: 2));

    return TransactionExecutionResponse(
      status: 'SUCCESS',
      referenceId: 'REF_${DateTime.now().millisecondsSinceEpoch}',
    );
  }
  Future<String> performProxyEnquiry(String proxyId, String proxyType) async {
    // Simulated API call to /api/v1/transactions/proxy-enquiry
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Mock masked response
    return 'MOHD A***D BIN AL*';
  }
}
