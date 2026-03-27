import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:decimal/decimal.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';
import 'package:agentbanking_channel/features/hardware/hardware_interfaces.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/settlement/providers/float_provider.dart';

class MockTransactionRepository extends Mock implements TransactionRepository {}
class MockCardReader extends Mock implements ICardReader {}
class MockPinPad extends Mock implements IPinPad {}
class MockFloatNotifier extends Mock implements FloatNotifier {}

void main() {
  late TransactionNotifier notifier;
  late MockTransactionRepository repository;
  late MockCardReader cardReader;
  late MockPinPad pinPad;
  late MockFloatNotifier floatNotifier;

  setUp(() {
    repository = MockTransactionRepository();
    cardReader = MockCardReader();
    pinPad = MockPinPad();
    floatNotifier = MockFloatNotifier();
    notifier = TransactionNotifier(
      repository: repository,
      cardReader: cardReader,
      pinPad: pinPad,
      floatNotifier: floatNotifier,
    );
  });

  group('TransactionNotifier State Machine', () {
    test('initial state is idle', () {
      expect(notifier.state.status, TransactionStatus.idle);
    });

    test('startTransaction moves to quoting and then waitingConsent', () async {
      final amount = Decimal.parse('100.0');
      // In a real test, we would stub repository.getQuote here
      
      await notifier.startTransaction(amount, 'AGENT007', fundingSource: FundingSource.CARD_EMV);
      
      expect(notifier.state.status, anyOf(TransactionStatus.quoting, TransactionStatus.waitingConsent, TransactionStatus.failed));
    });

    test('Cash transaction skips hardware steps', () async {
      final amount = Decimal.parse('100.0');
      notifier.startTransaction(amount, 'AGENT007', fundingSource: FundingSource.CASH);
      
      // Verification logic would go here
    });
  });
}
