import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';

void main() {
  group('Transaction Models', () {
    test('TransactionQuoteRequest includes fundingSource in JSON', () {
      final request = TransactionQuoteRequest(
        serviceCode: 'CASH_DEP',
        amount: 100.0,
        agentId: 'AGENT007',
        fundingSource: FundingSource.CASH,
      );
      
      final json = request.toJson();
      expect(json['fundingSource'], 'CASH');
    });

    test('TransactionExecutionRequest supports CASH funding without card data', () {
      final request = TransactionExecutionRequest(
        quoteId: 'QUOTE123',
        fundingSource: FundingSource.CASH,
      );
      
      final json = request.toJson();
      expect(json['fundingSource'], 'CASH');
      expect(json['pinBlock'], isNull);
      expect(json['cardToken'], isNull);
    });

    test('TransactionExecutionRequest supports DIGITAL_DUITNOW funding', () {
      final request = TransactionExecutionRequest(
        quoteId: 'QUOTE456',
        fundingSource: FundingSource.DIGITAL_DUITNOW,
        duitNowProxyId: '0123456789',
      );
      
      final json = request.toJson();
      expect(json['fundingSource'], 'DIGITAL_DUITNOW');
      expect(json['duitNowProxyId'], '0123456789');
    });
  });
}
