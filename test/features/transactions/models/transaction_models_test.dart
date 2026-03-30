import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';

void main() {
  group('TransactionQuoteResponse monetary types', () {
    test('Constructor correctly assigns Decimal values', () {
      final quote = TransactionQuoteResponse(
        amount: Decimal.parse('500.00'),
        fee: Decimal.parse('1.00'),
        commission: Decimal.parse('0.50'),
        total: Decimal.parse('501.00'),
        quoteId: 'Q-001',
      );
      expect(quote.amount, equals(Decimal.parse('500.00')));
      expect(quote.fee, equals(Decimal.parse('1.00')));
      expect(quote.total, equals(Decimal.parse('501.00')));
    });

    test('amount and fee values have correct precision', () {
      // Ensures no floating-point drift on 0.1 + 0.2 style errors
      final quote = TransactionQuoteResponse(
        amount: Decimal.parse('0.10'),
        fee: Decimal.parse('0.20'),
        commission: Decimal.parse('0.05'),
        total: Decimal.parse('0.30'),
        quoteId: 'Q-002',
      );
      expect((quote.amount + quote.fee), equals(Decimal.parse('0.30')));
    });
  });

  group('FundingSource Enum', () {
    test('contains new sources CARD_EMV and MYKAD_BIOMETRIC', () {
      expect(FundingSource.values.map((e) => e.name), contains('CARD_EMV'));
      expect(FundingSource.values.map((e) => e.name), contains('MYKAD_BIOMETRIC'));
    });
  });
}
