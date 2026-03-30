import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:decimal/decimal.dart';
import 'package:mockito/annotations.dart';
import 'package:agentbanking_channel/features/settlement/providers/settlement_provider.dart';
import 'package:agentbanking_channel/features/settlement/models/settlement_models.dart';
import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';


class ManualMockTransactionRepository extends Mock implements TransactionRepository {
  @override
  Future<TransactionQuoteResponse> getQuote(TransactionQuoteRequest request) async {
    return TransactionQuoteResponse(
      quoteId: 'Q1', 
      amount: request.amount, 
      fee: Decimal.zero, 
      commission: Decimal.zero,
      total: request.amount
    );
  }
}

void main() {
  late SettlementNotifier notifier;
  late ManualMockTransactionRepository mockRepo;

  setUp(() {
    mockRepo = ManualMockTransactionRepository();
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
