import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';
import 'package:agentbanking_channel/features/settlement/providers/float_provider.dart';
import 'package:agentbanking_channel/features/settlement/repositories/float_repository.dart';
import 'package:agentbanking_channel/features/hardware/hardware_interfaces.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/transactions/services/reversal_service.dart';
import 'package:agentbanking_channel/features/compliance/providers/compliance_provider.dart';

import 'transaction_provider_test.mocks.dart';

@GenerateMocks([
  TransactionRepository, 
  FloatRepository, 
  ICardReader, 
  IPinPad, 
  FloatNotifier,
  ReversalService,
  IMyKadScanner,
  ComplianceNotifier,
])
void main() {
  late TransactionNotifier notifier;
  late MockTransactionRepository mockRepo;
  late MockICardReader mockCardReader;
  late MockIPinPad mockPinPad;
  late MockFloatNotifier mockFloatNotifier;
  late MockReversalService mockReversalService;
  late MockIMyKadScanner mockMyKadScanner;
  late MockComplianceNotifier mockComplianceNotifier;

  setUp(() {
    mockRepo = MockTransactionRepository();
    mockCardReader = MockICardReader();
    mockPinPad = MockIPinPad();
    mockFloatNotifier = MockFloatNotifier();
    mockReversalService = MockReversalService();
    mockMyKadScanner = MockIMyKadScanner();
    mockComplianceNotifier = MockComplianceNotifier();
    
    // Default compliance state: not frozen
    when(mockComplianceNotifier.state).thenReturn(ComplianceState(isFrozen: false));

    notifier = TransactionNotifier(
      repository: mockRepo,
      cardReader: mockCardReader,
      pinPad: mockPinPad,
      floatNotifier: mockFloatNotifier,
      reversalService: mockReversalService,
      myKadScanner: mockMyKadScanner,
      complianceNotifier: mockComplianceNotifier,
      pollingInterval: const Duration(milliseconds: 1), // Fast polling for tests
    );
  });

  group('TransactionNotifier State Machine', () {
    test('initial state is idle', () {
      expect(notifier.state.status, TransactionStatus.idle);
    });

    test('startTransaction moves to quoting and then waitingConsent', () async {
      final amount = Decimal.parse('100.0');
      final mockQuote = TransactionQuoteResponse(
        amount: amount,
        fee: Decimal.parse('1.0'),
        commission: Decimal.parse('0.5'),
        total: Decimal.parse('101.0'),
        quoteId: 'Q-999',
      );
      
      when(mockRepo.getQuote(any)).thenAnswer((_) async => mockQuote);
      
      await notifier.startTransaction(amount, 'AGENT007', serviceCode: 'BILL_PAY', fundingSource: FundingSource.CARD_EMV);
      
      expect(notifier.state.status, TransactionStatus.waitingConsent);
      expect(notifier.state.quote?.quoteId, 'Q-999');
    });

    test('Cash transaction skips hardware steps', () async {
      final amount = Decimal.parse('100.0');
      final mockQuote = TransactionQuoteResponse(
        amount: amount,
        fee: Decimal.zero,
        commission: Decimal.zero,
        total: amount,
        quoteId: 'Q-CASH',
      );
      when(mockRepo.getQuote(any)).thenAnswer((_) async => mockQuote);

      await notifier.startTransaction(amount, 'AGENT007', serviceCode: 'CASH_DEP', fundingSource: FundingSource.CASH);
      
      expect(notifier.state.status, TransactionStatus.waitingConsent);
    });
  });

  test('balanceInquiry flow sets state correctly', () async {
    final mockQuote = TransactionQuoteResponse(
      amount: Decimal.zero,
      fee: Decimal.parse('0.0'),
      commission: Decimal.parse('0.0'),
      total: Decimal.parse('0.0'),
      quoteId: 'Q-123',
    );

    final mockResult = TransactionExecutionResponse(
      status: 'SUCCESS',
      referenceId: 'R-456',
      balance: Decimal.parse('1500.0'),
      currency: 'MYR',
    );

    when(mockRepo.getQuote(any)).thenAnswer((_) async => mockQuote);
    when(mockCardReader.readCard()).thenAnswer((_) async => CardData(maskedPan: '123', cardToken: 'tk'));
    when(mockPinPad.capturePin()).thenAnswer((_) async => 'pin');
    when(mockRepo.balanceInquiry(any)).thenAnswer((_) async => mockResult);
    when(mockFloatNotifier.fetchLatestBalance()).thenAnswer((_) async => Future.value());

    await notifier.balanceInquiry('AGENT-001');

    expect(notifier.state.status, TransactionStatus.success);
    expect(notifier.state.result?.balance, equals(Decimal.parse('1500.0')));
    verify(mockFloatNotifier.fetchLatestBalance()).called(1);
  });
}
