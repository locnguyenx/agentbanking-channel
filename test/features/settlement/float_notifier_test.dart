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

    test('initial balance is correct', () {
      expect(notifier.state.currentBalance, Decimal.parse('5000.0'));
    });
  });
}
