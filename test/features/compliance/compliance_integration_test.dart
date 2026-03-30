import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:decimal/decimal.dart';
import 'package:mockito/annotations.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/compliance/providers/compliance_provider.dart';

import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';
import 'package:agentbanking_channel/features/hardware/hardware_interfaces.dart';
import 'package:agentbanking_channel/features/settlement/providers/float_provider.dart';
import 'package:agentbanking_channel/features/transactions/services/reversal_service.dart';
import 'package:agentbanking_channel/features/hardware/mock_hardware_impl.dart';


class ManualMockTransactionRepository extends Mock implements TransactionRepository {
  TransactionQuoteResponse? mockQuote;

  @override
  Future<TransactionQuoteResponse> getQuote(TransactionQuoteRequest request) async {
    return mockQuote ?? TransactionQuoteResponse(
      quoteId: 'Q1', 
      amount: request.amount, 
      fee: Decimal.zero, 
      commission: Decimal.zero,
      total: request.amount
    );
  }
}

class MockICardReader extends Mock implements ICardReader {}
class MockIPinPad extends Mock implements IPinPad {}
class MockFloatNotifier extends Mock implements FloatNotifier {}
class MockReversalService extends Mock implements ReversalService {}
class MockMyKadScanner extends Mock implements IMyKadScanner {}

void main() {
  late TransactionNotifier notifier;
  late ComplianceNotifier complianceNotifier;
  late ManualMockTransactionRepository mockRepo;
  late MockICardReader mockCardReader;
  late MockIPinPad mockPinPad;
  late MockFloatNotifier mockFloatNotifier;
  late MockReversalService mockReversalService;

  setUp(() {
    mockRepo = ManualMockTransactionRepository();
    mockCardReader = MockICardReader();
    mockPinPad = MockIPinPad();
    mockFloatNotifier = MockFloatNotifier();
    mockReversalService = MockReversalService();
    complianceNotifier = ComplianceNotifier();

    notifier = TransactionNotifier(
      repository: mockRepo,
      cardReader: mockCardReader,
      pinPad: mockPinPad,
      floatNotifier: mockFloatNotifier,
      reversalService: mockReversalService,
      myKadScanner: MockMyKadScanner(),
      complianceNotifier: complianceNotifier,
    );
  });

  test('Locked merchant cannot start transaction', () async {
    // 1. Freeze
    complianceNotifier.freeze('VELOCITY_EXCEEDED');
    expect(complianceNotifier.state.isFrozen, true);

    // 2. Try start transaction
    await notifier.startTransaction(
      Decimal.parse('10.0'), 
      'MERCHANT-1', 
      serviceCode: 'BILL_PAYMENT', 
      fundingSource: FundingSource.CASH
    );

    expect(notifier.state.status, TransactionStatus.failed);
    expect(notifier.state.error, contains('ERR_COMPLIANCE_FROZEN'));
  });

  test('Webhook simulation unlocks merchant and enables transactions', () async {
    // 1. Freeze
    complianceNotifier.freeze('VELOCITY_EXCEEDED');
    
    // 2. Simulate Webhook (async)
    final unlockFuture = complianceNotifier.simulateWebhookUnlock();
    
    // During delay, still frozen
    expect(complianceNotifier.state.isFrozen, true);
    
    await unlockFuture;
    expect(complianceNotifier.state.isFrozen, false);

    // 3. Start transaction now should work
    mockRepo.mockQuote = TransactionQuoteResponse(
      quoteId: 'Q1', 
      amount: Decimal.parse('10.0'), 
      fee: Decimal.zero, 
      commission: Decimal.zero,
      total: Decimal.parse('10.0')
    );

    await notifier.startTransaction(
      Decimal.parse('10.0'), 
      'MERCHANT-1', 
      serviceCode: 'BILL_PAYMENT', 
      fundingSource: FundingSource.CASH
    );

    expect(notifier.state.status, TransactionStatus.waitingConsent);
  });
}
