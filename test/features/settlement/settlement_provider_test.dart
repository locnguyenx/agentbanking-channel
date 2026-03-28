import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:decimal/decimal.dart';
import 'package:mockito/annotations.dart';
import 'package:agentbanking_channel/features/settlement/providers/settlement_provider.dart';
import 'package:agentbanking_channel/features/settlement/models/settlement_models.dart';
import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';

@GenerateMocks([TransactionRepository])
import 'settlement_provider_test.mocks.dart';

void main() {
  late SettlementNotifier notifier;
  late MockTransactionRepository mockRepo;

  setUp(() {
    mockRepo = MockTransactionRepository();
    notifier = SettlementNotifier(repository: mockRepo);
  });

  test('fetchSummary populates state with daily totals', () async {
    await notifier.fetchSummary();
    
    expect(notifier.state.status, SettlementStatus.ready);
    expect(notifier.state.summary, isNotNull);
    expect(notifier.state.summary!.services.length, 3);
    expect(notifier.state.summary!.totalCommission, Decimal.parse('17.0'));
  });

  test('performSettlement transitions to settled state on success', () async {
    await notifier.fetchSummary();
    expect(notifier.state.status, SettlementStatus.ready);

    final settlementFuture = notifier.performSettlement();
    expect(notifier.state.status, SettlementStatus.processing);

    await settlementFuture;
    expect(notifier.state.status, SettlementStatus.settled);
    expect(notifier.state.result?.success, true);
    expect(notifier.state.result?.batchNumber, startsWith('B-'));
  });
}
