import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:decimal/decimal.dart';
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

  test('fetchSummary enforces backend API mapping', () async {
    await notifier.fetchSummary();
    
    expect(notifier.state.status, SettlementStatus.error);
    expect(notifier.state.error, contains('Backend API mapping required for settlement summary'));
  });

  test('performSettlement enforces backend API mapping', () async {
    // Manually set summary to bypass early return
    notifier.state = notifier.state.copyWith(summary: SettlementSummary(
      terminalId: 'TM-001',
      timestamp: DateTime.now(),
      services: [],
      netVolume: Decimal.zero,
      totalCommission: Decimal.zero,
    ));

    await notifier.performSettlement();
    expect(notifier.state.status, SettlementStatus.error);
    expect(notifier.state.error, contains('Backend API mapping required for EOD closure'));
  });
}
