import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:agentbanking_channel/features/hardware/hardware_interfaces.dart';
import 'package:agentbanking_channel/features/settlement/providers/float_provider.dart';
import 'package:agentbanking_channel/features/settlement/models/float_models.dart';
import 'package:agentbanking_channel/features/transactions/services/reversal_service.dart';
import 'package:agentbanking_channel/features/compliance/providers/compliance_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ManualMockTransactionRepository implements TransactionRepository {
  TransactionQuoteResponse? mockQuote;
  TransactionExecutionResponse? mockExecution;
  String? mockDuitNowStatus;

  @override
  Future<TransactionQuoteResponse> getQuote(TransactionQuoteRequest request) async {
    return mockQuote ?? TransactionQuoteResponse(
      amount: request.amount,
      fee: Decimal.zero,
      commission: Decimal.zero,
      total: request.amount,
      quoteId: 'MOCK-Q-123',
    );
  }

  @override
  Future<TransactionExecutionResponse> initiateDuitNow({
    required String quoteId,
    required String proxyId,
    required String proxyType,
    required Decimal amount,
  }) async {
    if (mockExecution == null) throw UnimplementedError('mockExecution not set');
    return mockExecution!;
  }

  @override
  Future<String> getDuitNowStatus(String referenceId) async {
    return mockDuitNowStatus ?? 'COMPLETED';
  }

  @override
  Future<TransactionExecutionResponse> executeTransaction(TransactionExecutionRequest request) async {
    return mockExecution ?? TransactionExecutionResponse(status: 'SUCCESS', referenceId: 'REF-EXE');
  }

  @override
  Future<TransactionExecutionResponse> balanceInquiry(TransactionExecutionRequest request) async {
     return mockExecution ?? TransactionExecutionResponse(status: 'SUCCESS', referenceId: 'REF-BAL');
  }
  
  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError(invocation.memberName.toString());
}

class ManualMockComplianceNotifier extends StateNotifier<ComplianceState> implements ComplianceNotifier {
  ManualMockComplianceNotifier() : super(ComplianceState(isFrozen: false));
  @override
  void freeze(String reason) => state = ComplianceState(isFrozen: true, reason: reason);
  @override
  void unlock() => state = ComplianceState(isFrozen: false);
  @override
  Future<void> simulateWebhookUnlock() async => unlock();
}

class ManualCardReader implements ICardReader {
  @override
  Future<CardData?> readCard() async => null;
  @override
  Future<bool> isAvailable() async => true;
}

class ManualPinPad implements IPinPad {
  @override
  Future<String?> capturePin() async => null;
  @override
  Future<bool> isAvailable() async => true;
}

class ManualFloatNotifier extends StateNotifier<FloatLedger> implements FloatNotifier {
  ManualFloatNotifier() : super(FloatLedger(currentBalance: Decimal.zero, limit: Decimal.zero));
  @override
  Future<void> fetchLatestBalance() async {}
}

class ManualReversalService implements ReversalService {
  Map<String, dynamic>? lastReversalRequest;
  @override
  Future<void> queueReversal(Map<String, dynamic> originalRequest) async {
    lastReversalRequest = originalRequest;
  }
}

class ManualMyKadScanner implements IMyKadScanner {
  @override
  Future<bool> isAvailable() async => true;
  @override
  Future<MyKadData?> scanMyKad() async => null;
}

void main() {
  late TransactionNotifier notifier;
  late ManualMockTransactionRepository mockRepo;
  late ManualCardReader mockCardReader;
  late ManualPinPad mockPinPad;
  late ManualFloatNotifier mockFloatNotifier;
  late ManualReversalService mockReversalService;
  late ManualMyKadScanner mockMyKadScanner;
  late ManualMockComplianceNotifier mockComplianceNotifier;

  setUp(() {
    mockRepo = ManualMockTransactionRepository();
    mockCardReader = ManualCardReader();
    mockPinPad = ManualPinPad();
    mockFloatNotifier = ManualFloatNotifier();
    mockReversalService = ManualReversalService();
    mockMyKadScanner = ManualMyKadScanner();
    mockComplianceNotifier = ManualMockComplianceNotifier();

    notifier = TransactionNotifier(
      repository: mockRepo,
      cardReader: mockCardReader,
      pinPad: mockPinPad,
      floatNotifier: mockFloatNotifier,
      reversalService: mockReversalService,
      myKadScanner: mockMyKadScanner,
      complianceNotifier: mockComplianceNotifier,
      pollingInterval: const Duration(milliseconds: 1),
    );
  });

  group('DuitNow Transfer Provider', () {
    test('Mobile Number proxy triggers RTP and enters polling state', () async {
      await notifier.startTransaction(
        Decimal.parse('100.0'),
        'AGENT-001',
        serviceCode: 'DUITNOW_TRANSFER',
        fundingSource: FundingSource.DUITNOW_MOBILE,
      );

      expect(notifier.state.status, equals(TransactionStatus.waitingConsent));

      mockRepo.mockExecution = TransactionExecutionResponse(
        status: 'SUCCESS',
        referenceId: 'REF-DUT-001',
      );

      await notifier.confirmConsent(duitNowProxyId: '0123456789');

      expect(notifier.state.status, equals(TransactionStatus.success));
    });

    test('DuitNow Transfer Provider DuitNow failure transitions to failed state', () async {
      mockRepo.mockExecution = TransactionExecutionResponse(
        status: 'FAILED',
        referenceId: 'REF-ERR-001',
        errorMessage: 'INSUFFICIENT_FUNDS',
      );

      await notifier.startTransaction(
        Decimal.parse('100.0'),
        'AGENT-001',
        serviceCode: 'DUITNOW_TRANSFER',
        fundingSource: FundingSource.DUITNOW_MOBILE,
      );

      await notifier.confirmConsent(duitNowProxyId: '0123456789');

      expect(notifier.state.status, equals(TransactionStatus.failed));
      expect(notifier.state.error, equals('INSUFFICIENT_FUNDS'));
    });

    test('DuitNow Transfer Provider DuitNow customer approval timeout triggers MTI 0400 reversal', () async {
      mockRepo.mockQuote = TransactionQuoteResponse(
        amount: Decimal.parse('100.0'),
        fee: Decimal.parse('1.0'),
        commission: Decimal.parse('0.5'),
        total: Decimal.parse('101.0'),
        quoteId: 'Q-DUT-003',
      );

      mockRepo.mockExecution = TransactionExecutionResponse(
        status: 'SUCCESS',
        referenceId: 'REF-DUT-003',
      );
      
      // Always return PENDING to trigger timeout
      mockRepo.mockDuitNowStatus = 'PENDING';

      await notifier.startTransaction(
        Decimal.parse('100.0'),
        'AGENT-001',
        serviceCode: 'DUITNOW_TRANSFER',
        fundingSource: FundingSource.DUITNOW_MOBILE,
      );

      await notifier.confirmConsent(duitNowProxyId: '0123456789');

      expect(notifier.state.status, equals(TransactionStatus.reversalQueued));
      expect(mockReversalService.lastReversalRequest, isNotNull);
    });
  });
}
