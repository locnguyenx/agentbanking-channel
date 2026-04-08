import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';
import 'package:agentbanking_channel/features/settlement/providers/float_provider.dart';
import 'package:agentbanking_channel/features/settlement/repositories/float_repository.dart';
import 'package:agentbanking_channel/features/settlement/models/float_models.dart';
import 'package:agentbanking_channel/features/hardware/hardware_interfaces.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/transactions/services/reversal_service.dart';
import 'package:agentbanking_channel/features/compliance/providers/compliance_provider.dart';
import 'package:agentbanking_channel/features/settlement/services/eod_timer_service.dart';
import 'package:mockito/mockito.dart' as mockito;
import 'package:geolocator/geolocator.dart';
import 'package:geolocator_platform_interface/geolocator_platform_interface.dart';
import '../../../test_utils.dart';
import '../../../setup/test_credentials.dart';

class FakeFloatRepository extends mockito.Fake implements FloatRepository {
  @override
  Future<FloatLedger> getFloatStatus(String agentId) async {
    return FloatLedger(currentBalance: Decimal.parse('5000.0'), limit: Decimal.parse('10000.0'));
  }
}

class ManualMockTransactionRepository extends mockito.Mock implements TransactionRepository {
  TransactionQuoteResponse? mockQuote;
  TransactionExecutionResponse? mockExecution;

  @override
  Future<TransactionQuoteResponse> getQuote(TransactionQuoteRequest request) async {
    return mockQuote ?? TransactionQuoteResponse(
      quoteId: 'Q-TEST-001',
      amount: request.amount,
      fee: Decimal.zero,
      commission: Decimal.zero,
      total: request.amount,
    );
  }

  @override
  Future<TransactionExecutionResponse> executeTransaction(TransactionExecutionRequest request, String agentId, {String? idempotencyKey}) async {
    return mockExecution ?? TransactionExecutionResponse(
      status: 'SUCCESS',
      referenceId: 'REF-TEST-001',
    );
  }

  @override
  Future<TransactionExecutionResponse> balanceInquiry(TransactionExecutionRequest request, String agentId) async {
    return mockExecution ?? TransactionExecutionResponse(
      status: 'SUCCESS',
      referenceId: 'REF-BAL-001',
      balance: Decimal.parse('1500.0'),
      currency: 'MYR',
    );
  }

  @override
  Future<TransactionExecutionResponse> initiateDuitNow({
    required String quoteId,
    required String proxyId,
    required String proxyType,
    required Decimal amount,
    required String agentId,
  }) async {
    return mockExecution ?? TransactionExecutionResponse(
      status: 'SUCCESS',
      referenceId: 'REF-DUT-001',
    );
  }
  
  @override
  Future<String> performProxyEnquiry(String proxyId, String proxyType) async => 'MOHD A***D BIN AL*';
  
  @override
  Future<String> getBillerStatus(String transactionId) async => 'SUCCESS';
}

class ManualMockComplianceNotifier extends ComplianceNotifier {
  ManualMockComplianceNotifier() : super();
  @override
  void freeze(String reason) => state = ComplianceState(isFrozen: true, reason: reason);
  @override
  void unlock() => state = ComplianceState(isFrozen: false);
  @override
  Future<void> simulateWebhookUnlock() async => unlock();
}

class ManualCardReader implements ICardReader {
  @override
  Future<CardData?> readCard() async => CardData(maskedPan: '123', cardToken: 'tk');
  @override
  Future<bool> isAvailable() async => true;
}

class ManualPinPad implements IPinPad {
  @override
  Future<String?> capturePin() async => 'pin';
  @override
  Future<bool> isAvailable() async => true;
}

class ManualFloatNotifier extends FloatNotifier {
  bool fetchLatestCalled = false;
  ManualFloatNotifier() : super(FakeFloatRepository(), null);
  @override
  Future<void> fetchLatestBalance() async {
    fetchLatestCalled = true;
  }
}

class ManualReversalService implements ReversalService {
  @override
  Future<void> queueReversal(Map<String, dynamic> originalRequest) async {}
}

class ManualMyKadScanner implements IMyKadScanner {
  @override
  Future<bool> isAvailable() async => true;
  @override
  Future<MyKadData?> scanMyKad() async => null;
}

class FakeGeolocatorPlatform extends mockito.Fake implements GeolocatorPlatform {
  Position position = Position(
    latitude: 3.1390, longitude: 101.6869,
    timestamp: DateTime.now(), accuracy: 1.0, altitude: 0.0, heading: 0.0, speed: 0.0, speedAccuracy: 0.0,
    altitudeAccuracy: 0.0, headingAccuracy: 0.0,
  );
  @override
  Future<Position> getCurrentPosition({LocationSettings? locationSettings}) async => position;
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
  late FakeEodTimerService fakeEodTimer;

  setUp(() {
    mockRepo = ManualMockTransactionRepository();
    mockComplianceNotifier = ManualMockComplianceNotifier();
    mockCardReader = ManualCardReader();
    mockPinPad = ManualPinPad();
    mockFloatNotifier = ManualFloatNotifier();
    mockReversalService = ManualReversalService();
    mockMyKadScanner = ManualMyKadScanner();
    fakeEodTimer = FakeEodTimerService();
    
    notifier = TransactionNotifier(
      ref: ManualMockRef(),
      repository: mockRepo,
      cardReader: mockCardReader,
      pinPad: mockPinPad,
      floatNotifier: mockFloatNotifier,
      reversalService: mockReversalService,
      myKadScanner: mockMyKadScanner,
      complianceNotifier: mockComplianceNotifier,
      eodTimerService: fakeEodTimer,
      geolocator: FakeGeolocatorPlatform(),
      pollingInterval: const Duration(milliseconds: 1),
    );
  });

  group('TransactionNotifier State Machine', () {
    test('initial state is idle', () {
      expect(notifier.state.status, TransactionStatus.idle);
    });

    test('startTransaction moves to quoting and then waitingConsent', () async {
      final amount = Decimal.parse('100.0');
      mockRepo.mockQuote = TransactionQuoteResponse(
        amount: amount,
        fee: Decimal.parse('1.0'),
        commission: Decimal.parse('0.5'),
        total: Decimal.parse('101.0'),
        quoteId: 'Q-999',
      );
      
      await notifier.startTransaction(amount, TestCredentials.username, serviceCode: 'BILL_PAY', fundingSource: FundingSource.CARD_EMV);
      
      expect(notifier.state.status, TransactionStatus.waitingConsent);
      expect(notifier.state.quote?.quoteId, 'Q-999');
    });

    test('Cash transaction skips hardware steps', () async {
      final amount = Decimal.parse('100.0');
      mockRepo.mockQuote = TransactionQuoteResponse(
        amount: amount,
        fee: Decimal.zero,
        commission: Decimal.zero,
        total: amount,
        quoteId: 'Q-CASH',
      );

      await notifier.startTransaction(amount, 'AGENT007', serviceCode: 'CASH_DEPOSIT', fundingSource: FundingSource.CASH);
      
      expect(notifier.state.status, TransactionStatus.waitingConsent);
    });
  });

  test('balanceInquiry flow sets state correctly', () async {
    mockRepo.mockQuote = TransactionQuoteResponse(
      amount: Decimal.zero,
      fee: Decimal.parse('0.0'),
      commission: Decimal.parse('0.0'),
      total: Decimal.parse('0.0'),
      quoteId: 'Q-123',
    );

    mockRepo.mockExecution = TransactionExecutionResponse(
      status: 'SUCCESS',
      referenceId: 'R-456',
      balance: Decimal.parse('1500.0'),
      currency: 'MYR',
    );

    await notifier.balanceInquiry('AGENT-001');

    expect(notifier.state.status, TransactionStatus.success);
    expect(notifier.state.result?.balance, equals(Decimal.parse('1500.0')));
    expect(mockFloatNotifier.fetchLatestCalled, isFalse);
  });
}

class FakeEodTimerService extends mockito.Mock implements EodTimerService {
  @override
  EodStatus getCurrentEodStatus() => EodStatus.open;
}
