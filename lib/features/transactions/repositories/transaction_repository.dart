import 'package:dio/dio.dart';
import '../models/transaction_models.dart';

class TransactionRepository {
  final Dio dio;

  TransactionRepository(this.dio);

  Future<TransactionQuoteResponse> getQuote(TransactionQuoteRequest request) async {
    // Simulated API call to /api/v1/transactions/quote
    // In real implementation, this would use dio.post
    await Future.delayed(const Duration(milliseconds: 800));
    
    // Mock response
    return TransactionQuoteResponse(
      amount: request.amount,
      fee: 1.00,
      commission: 0.50,
      total: request.amount + 1.00,
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
}
