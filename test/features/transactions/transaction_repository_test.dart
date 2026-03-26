import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';

void main() {
  late TransactionRepository repository;
  late Dio dio;

  setUp(() {
    dio = Dio();
    repository = TransactionRepository(dio);
  });

  group('TransactionRepository', () {
    test('getQuote returns valid quote response', () async {
      final request = TransactionQuoteRequest(
        serviceCode: 'CASH_WDL',
        amount: 100.0,
        agentId: 'AGENT007',
        fundingSource: FundingSource.CARD,
      );

      final response = await repository.getQuote(request);

      expect(response.amount, 100.0);
      expect(response.fee, 1.0);
      expect(response.quoteId, startsWith('QUOTE_'));
    });

    test('executeTransaction returns success', () async {
      final request = TransactionExecutionRequest(
        quoteId: 'QUOTE123',
        fundingSource: FundingSource.CARD,
        pinBlock: 'PIN_BLOCK',
        cardToken: 'TOKEN_123',
      );

      final response = await repository.executeTransaction(request);

      expect(response.status, 'SUCCESS');
      expect(response.referenceId, startsWith('REF_'));
    });
    test('performProxyEnquiry returns masked name', () async {
      final name = await repository.performProxyEnquiry('0123456789', 'NRIC');
      
      expect(name, contains('***'));
    });
  });
}
