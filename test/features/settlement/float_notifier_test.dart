import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:decimal/decimal.dart';
import 'package:agentbanking_channel/features/settlement/providers/float_provider.dart';
import 'package:agentbanking_channel/features/settlement/models/float_models.dart';
import 'package:agentbanking_channel/features/settlement/repositories/float_repository.dart';

class MockFloatRepository extends Mock implements FloatRepository {}

void main() {
  late FloatNotifier notifier;
  late MockFloatRepository mockRepository;

  setUp(() {
    mockRepository = MockFloatRepository();
    notifier = FloatNotifier(mockRepository); 
  });

  group('FloatNotifier', () {
    test('initial balance is correct', () {
      expect(notifier.state.currentBalance, Decimal.parse('5000.0'));
    });

    test('creditFloat increases balance and adds entry', () {
      final amount = Decimal.parse('500.0');
      notifier.creditFloat(amount, 'TX123');
      expect(notifier.state.currentBalance, Decimal.parse('5500.0'));
      expect(notifier.state.entries.length, 1);
      expect(notifier.state.entries.first.type, FloatEntryType.CREDIT);
    });

    test('debitFloat decreases balance and adds entry', () {
      final amount = Decimal.parse('200.0');
      notifier.debitFloat(amount, 'TX456');
      expect(notifier.state.currentBalance, Decimal.parse('4800.0'));
      expect(notifier.state.entries.length, 1);
      expect(notifier.state.entries.first.type, FloatEntryType.DEBIT);
    });
  });
}
