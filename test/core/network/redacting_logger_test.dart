import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/core/network/redacting_logger.dart';

void main() {
  late RedactingLogger logger;

  setUp(() {
    logger = RedactingLogger();
  });

  group('RedactingLogger PII Masking', () {
    test('redacts 12-digit MyKad number (formatted)', () {
      const input = 'MyKad Number: 900101-01-1234';
      final result = logger.redact(input);
      expect(result, contains('900101-**-****'));
      expect(result, isNot(contains('1234')));
    });

    test('redacts 12-digit MyKad number (unformatted)', () {
      const input = 'User IC: 900101011234';
      final result = logger.redact(input);
      expect(result, contains('900101******'));
    });

    test('no longer redacts 16-digit Credit Card PAN', () {
      const input = 'Payment with card 4111-2222-3333-4444';
      final result = logger.redact(input);
      expect(result, contains('4111-2222-3333-4444'));
    });

    test('does not redact non-PII numbers', () {
      const input = 'Transaction ID: TXN_789456, Amount: 100.50';
      final result = logger.redact(input);
      expect(result, input);
    });
  });
}
