import 'package:flutter_test/flutter_test.dart';
import 'package:decimal/decimal.dart';
import 'package:agentbanking_channel/features/settlement/providers/float_provider.dart';
import 'package:agentbanking_channel/features/settlement/models/float_models.dart';
import 'package:agentbanking_channel/features/settlement/repositories/float_repository.dart';

class FakeFloatRepository extends Fake implements FloatRepository {
  @override
  Future<FloatLedger> getFloatStatus(String agentId) async {
    return FloatLedger(
      currentBalance: Decimal.parse('5000.0'),
      limit: Decimal.parse('10000.0'),
    );
  }
}

void main() {
  late FloatNotifier notifier;
  late FakeFloatRepository mockRepository;

  setUp(() {
    mockRepository = FakeFloatRepository();
    notifier = FloatNotifier(mockRepository, 'AGENT-123');
  });

  group('FloatNotifier', () {
    test('initial balance is correct after fetch', () async {
      await notifier.fetchLatestBalance();
      expect(notifier.state.currentBalance, Decimal.parse('5000.0'));
    });
  });
}
