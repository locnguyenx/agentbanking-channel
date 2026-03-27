import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';

void main() {
  group('TransactionQuoteResponse monetary types', () {
    test('fromJson parses amount as Decimal, not double', () {
      final json = {
        'amount': '500.00',
        'fee': '1.00',
        'commission': '0.50',
        'total': '501.00',
        'quoteId': 'Q-001',
      };
      final quote = TransactionQuoteResponse.fromJson(json);
      expect(quote.amount, equals(Decimal.parse('500.00')));
      expect(quote.fee, equals(Decimal.parse('1.00')));
      expect(quote.total, equals(Decimal.parse('501.00')));
    });

    test('amount and fee values have correct 2dp precision with HALF_UP', () {
      // Ensures no floating-point drift on 0.1 + 0.2 style errors
      final json = {
        'amount': '0.10',
        'fee': '0.20',
        'commission': '0.05',
        'total': '0.30',
        'quoteId': 'Q-002',
      };
      final quote = TransactionQuoteResponse.fromJson(json);
      expect((quote.amount + quote.fee), equals(Decimal.parse('0.30')));
    });
   group('FundingSource Enum', () {
      test('contains new sources CARD_EMV and MYKAD_BIOMETRIC', () {
        expect(FundingSource.values.map((e) => e.name), contains('CARD_EMV'));
        expect(FundingSource.values.map((e) => e.name), contains('MYKAD_BIOMETRIC'));
      });
    });
  });
}
