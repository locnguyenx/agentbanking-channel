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

@GenerateMocks([TransactionRepository, ICardReader, IPinPad, FloatNotifier, ReversalService])
import 'compliance_integration_test.mocks.dart';

void main() {
  late TransactionNotifier notifier;
  late ComplianceNotifier complianceNotifier;
  late MockTransactionRepository mockRepo;
  late MockICardReader mockCardReader;
  late MockIPinPad mockPinPad;
  late MockFloatNotifier mockFloatNotifier;
  late MockReversalService mockReversalService;

  setUp(() {
    mockRepo = MockTransactionRepository();
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
    // We use a shorter delay for testing if we wanted, but let's test the real one
    final unlockFuture = complianceNotifier.simulateWebhookUnlock();
    
    // During delay, still frozen
    expect(complianceNotifier.state.isFrozen, true);
    
    await unlockFuture;
    expect(complianceNotifier.state.isFrozen, false);

    // 3. Start transaction now should work
    when(mockRepo.getQuote(any)).thenAnswer((_) async => TransactionQuoteResponse(
      quoteId: 'Q1', 
      amount: Decimal.parse('10.0'), 
      fee: Decimal.zero, 
      commission: Decimal.zero,
      total: Decimal.parse('10.0')
    ));

    await notifier.startTransaction(
      Decimal.parse('10.0'), 
      'MERCHANT-1', 
      serviceCode: 'BILL_PAYMENT', 
      fundingSource: FundingSource.CASH
    );

    expect(notifier.state.status, TransactionStatus.waitingConsent);
  });
}
