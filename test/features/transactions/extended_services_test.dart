import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:decimal/decimal.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';
import 'package:agentbanking_channel/features/hardware/hardware_interfaces.dart';
import 'package:agentbanking_channel/features/settlement/providers/float_provider.dart';
import 'package:agentbanking_channel/features/transactions/services/reversal_service.dart';
import 'package:agentbanking_channel/features/compliance/providers/compliance_provider.dart';

import 'duitnow_test.mocks.dart';

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
      pollingInterval: const Duration(milliseconds: 1),
      validationDelay: Duration.zero,
    );
  });

  group('JomPAY ON-US routing', () {
    test('billerRouting=ON_US sends correctly in metadata', () async {
      final mockQuote = TransactionQuoteResponse(
        amount: Decimal.parse('100.0'),
        fee: Decimal.zero,
        commission: Decimal.zero,
        total: Decimal.parse('100.0'),
        quoteId: 'QUOTE-123',
      );

      when(mockRepo.getQuote(any)).thenAnswer((_) async => mockQuote);
      when(mockRepo.executeTransaction(any)).thenAnswer((_) async => TransactionExecutionResponse(
        status: 'SUCCESS',
        referenceId: 'REF-123',
      ));

      await notifier.startTransaction(
        Decimal.parse('100.0'),
        'AGENT-001',
        serviceCode: 'BILL_PAYMENT',
        fundingSource: FundingSource.CASH,
        metadata: {'billerRouting': 'ON_US', 'billerCode': '1234'},
      );

      await notifier.confirmConsent();

      expect(notifier.state.status, TransactionStatus.success);
    });
   group('Retail Merchant Services', () {
      test('Retail Sale flow with card completes successfully', () async {
        final amount = Decimal.parse('15.50');
        final mockQuote = TransactionQuoteResponse(
          amount: amount,
          fee: Decimal.zero,
          commission: Decimal.zero,
          total: amount,
          quoteId: 'Q-RETAIL-01',
        );

        when(mockRepo.getQuote(any)).thenAnswer((_) async => mockQuote);
        when(mockCardReader.readCard()).thenAnswer((_) async => CardData(maskedPan: '4111**1111', cardToken: 'TOK-RETAIL'));
        when(mockPinPad.capturePin()).thenAnswer((_) async => 'SECURE_PIN');
        when(mockRepo.executeTransaction(any)).thenAnswer((_) async => TransactionExecutionResponse(
          status: 'SUCCESS',
          referenceId: 'REF-RETAIL-01',
        ));

        await notifier.startTransaction(amount, 'AGENT-001', serviceCode: 'RETAIL_SALE', fundingSource: FundingSource.CARD_EMV);
        await notifier.confirmConsent();
        
        expect(notifier.state.status, TransactionStatus.waitingCard);
        
        await notifier.processCard();
        expect(notifier.state.status, TransactionStatus.success);
      });
    });
  });

  group('Cash-funded Large Amount AML', () {
    test('cash > RM 3,000 triggers MyKad scan', () async {
      final mockQuote = TransactionQuoteResponse(
        amount: Decimal.parse('3500.0'),
        fee: Decimal.zero,
        commission: Decimal.zero,
        total: Decimal.parse('3500.0'),
        quoteId: 'QUOTE-AML',
      );

      when(mockRepo.getQuote(any)).thenAnswer((_) async => mockQuote);
      when(mockMyKadScanner.scanMyKad()).thenAnswer((_) async => MyKadData(
        fullName: 'TEST USER',
        icNumber: '900101-01-5566',
        address: 'KL',
      ));
      when(mockRepo.executeTransaction(any)).thenAnswer((_) async => TransactionExecutionResponse(
        status: 'SUCCESS',
        referenceId: 'REF-AML',
      ));

      await notifier.startTransaction(
        Decimal.parse('3500.0'),
        'AGENT-001',
        serviceCode: 'BILL_PAYMENT',
        fundingSource: FundingSource.CASH,
      );

      await notifier.confirmConsent();

      // Verify intermediate state
      expect(notifier.state.status, TransactionStatus.waitingMyKadScan);
      
      await notifier.scanMyKadForAml();
      expect(notifier.state.status, TransactionStatus.success);
    });
  });

  group('Card-funded dual-handshake', () {
    test('enters validatingService state before card insertion', () async {
      final mockQuote = TransactionQuoteResponse(
        amount: Decimal.parse('100.0'),
        fee: Decimal.zero,
        commission: Decimal.zero,
        total: Decimal.parse('100.0'),
        quoteId: 'QUOTE-CARD',
      );

      when(mockRepo.getQuote(any)).thenAnswer((_) async => mockQuote);
      when(mockCardReader.readCard()).thenAnswer((_) async => CardData(maskedPan: '123', cardToken: 'TOK'));
      when(mockPinPad.capturePin()).thenAnswer((_) async => 'PIN');
      when(mockRepo.executeTransaction(any)).thenAnswer((_) async => TransactionExecutionResponse(
        status: 'SUCCESS',
        referenceId: 'REF-CARD',
      ));

      await notifier.startTransaction(
        Decimal.parse('100.0'),
        'AGENT-001',
        serviceCode: 'BILL_PAYMENT',
        fundingSource: FundingSource.CARD_EMV,
      );

      // confirmConsent with zero delay should land on waitingCard
      await notifier.confirmConsent();
      expect(notifier.state.status, TransactionStatus.waitingCard);
      
      await notifier.processCard();
      expect(notifier.state.status, TransactionStatus.success);
    });
  });
}
