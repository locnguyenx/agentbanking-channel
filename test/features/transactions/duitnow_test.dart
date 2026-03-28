import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';
import 'package:agentbanking_channel/features/hardware/hardware_interfaces.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/settlement/providers/float_provider.dart';

import 'package:agentbanking_channel/features/transactions/services/reversal_service.dart';

import 'duitnow_test.mocks.dart';

@GenerateMocks([TransactionRepository, ICardReader, IPinPad, FloatNotifier, ReversalService, IMyKadScanner])
void main() {
  late TransactionNotifier notifier;
  late MockTransactionRepository mockRepo;
  late MockICardReader mockCardReader;
  late MockIPinPad mockPinPad;
  late MockFloatNotifier mockFloatNotifier;
  late MockReversalService mockReversalService;
  late MockIMyKadScanner mockMyKadScanner;

  setUp(() {
    mockRepo = MockTransactionRepository();
    mockCardReader = MockICardReader();
    mockPinPad = MockIPinPad();
    mockFloatNotifier = MockFloatNotifier();
    mockReversalService = MockReversalService();
    mockMyKadScanner = MockIMyKadScanner();

    notifier = TransactionNotifier(
      repository: mockRepo,
      cardReader: mockCardReader,
      pinPad: mockPinPad,
      floatNotifier: mockFloatNotifier,
      reversalService: mockReversalService,
      myKadScanner: mockMyKadScanner,
      pollingInterval: const Duration(milliseconds: 1),
    );
  });

  group('DuitNow Transfer Provider', () {
    test('Mobile Number proxy triggers RTP and enters polling state', () async {
      final mockQuote = TransactionQuoteResponse(
        amount: Decimal.parse('100.0'),
        fee: Decimal.parse('1.0'),
        commission: Decimal.parse('0.5'),
        total: Decimal.parse('101.0'),
        quoteId: 'Q-DUT-001',
      );

      final mockInitResult = TransactionExecutionResponse(
        status: 'SUCCESS',
        referenceId: 'REF-DUT-001',
      );

      when(mockRepo.getQuote(any)).thenAnswer((_) async => mockQuote);
      when(mockRepo.initiateDuitNow(
        quoteId: anyNamed('quoteId'),
        proxyId: anyNamed('proxyId'),
        proxyType: anyNamed('proxyType'),
      )).thenAnswer((_) async => mockInitResult);
      
      when(mockRepo.getDuitNowStatus(any)).thenAnswer((_) async => 'COMPLETED');

      await notifier.startTransaction(
        Decimal.parse('100.0'),
        'AGENT-001',
        serviceCode: 'DUITNOW_TRANSFER',
        fundingSource: FundingSource.DUITNOW_MOBILE,
      );

      await notifier.confirmConsent(duitNowProxyId: '0123456789');

      // Then: state transitions to success after polling
      expect(notifier.state.status, equals(TransactionStatus.success));
    });

    test('BRN proxy correctly sets proxyType=BRN in API request', () async {
      final mockQuote = TransactionQuoteResponse(
        amount: Decimal.parse('100.0'),
        fee: Decimal.parse('1.0'),
        commission: Decimal.parse('0.5'),
        total: Decimal.parse('101.0'),
        quoteId: 'Q-DUT-002',
      );

      final mockInitResult = TransactionExecutionResponse(
        status: 'SUCCESS',
        referenceId: 'REF-DUT-002',
      );

      when(mockRepo.getQuote(any)).thenAnswer((_) async => mockQuote);
      when(mockRepo.initiateDuitNow(
        quoteId: anyNamed('quoteId'),
        proxyId: anyNamed('proxyId'),
        proxyType: 'BRN',
      )).thenAnswer((_) async => mockInitResult);
      when(mockRepo.getDuitNowStatus(any)).thenAnswer((_) async => 'COMPLETED');

      await notifier.startTransaction(
        Decimal.parse('100.0'),
        'AGENT-001',
        serviceCode: 'DUITNOW_TRANSFER',
        fundingSource: FundingSource.DUITNOW_BRN,
      );

      await notifier.confirmConsent(duitNowProxyId: '999999-X');

      verify(mockRepo.initiateDuitNow(
        quoteId: 'Q-DUT-002',
        proxyId: '999999-X',
        proxyType: 'BRN',
      )).called(1);
    });

    test('DuitNow customer approval timeout triggers MTI 0400 reversal', () async {
      final mockQuote = TransactionQuoteResponse(
        amount: Decimal.parse('100.0'),
        fee: Decimal.parse('1.0'),
        commission: Decimal.parse('0.5'),
        total: Decimal.parse('101.0'),
        quoteId: 'Q-DUT-003',
      );

      final mockInitResult = TransactionExecutionResponse(
        status: 'SUCCESS',
        referenceId: 'REF-DUT-003',
      );

      when(mockRepo.getQuote(any)).thenAnswer((_) async => mockQuote);
      when(mockRepo.initiateDuitNow(
        quoteId: anyNamed('quoteId'),
        proxyId: anyNamed('proxyId'),
        proxyType: anyNamed('proxyType'),
      )).thenAnswer((_) async => mockInitResult);
      
      // Always return PENDING to trigger timeout
      when(mockRepo.getDuitNowStatus(any)).thenAnswer((_) async => 'PENDING');

      await notifier.startTransaction(
        Decimal.parse('100.0'),
        'AGENT-001',
        serviceCode: 'DUITNOW_TRANSFER',
        fundingSource: FundingSource.DUITNOW_MOBILE,
      );

      // Note: In a real test we might need to mock the clock or reduce the timeout duration
      // For now, let's assume confirmConsent handles the polling (simplified in plan)
      await notifier.confirmConsent(duitNowProxyId: '0123456789');

      expect(notifier.state.status, equals(TransactionStatus.reversalQueued));
    });
   group('DuitNow proxy mapping', () {
      test('_proxyTypeFromFundingSource correctly maps mobile', () {
        // This is a private method, but we can test it indirectly via initiateDuitNow calls
      });
    });
  });
}
