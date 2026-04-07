import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:agentbanking_channel/features/hardware/hardware_interfaces.dart';
import 'package:agentbanking_channel/features/settlement/providers/float_provider.dart';
import 'package:agentbanking_channel/features/settlement/repositories/float_repository.dart';
import 'package:agentbanking_channel/features/settlement/models/float_models.dart';
import 'package:agentbanking_channel/features/transactions/services/reversal_service.dart';
import 'package:agentbanking_channel/features/settlement/services/eod_timer_service.dart';
import 'package:agentbanking_channel/features/compliance/providers/compliance_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/mockito.dart';
import '../../test_utils.dart';
import '../../setup/test_credentials.dart';

class FakeFloatRepository extends Fake implements FloatRepository {
  @override
  Future<FloatLedger> getFloatStatus(String agentId) async {
    return FloatLedger(currentBalance: Decimal.parse('5000.0'), limit: Decimal.parse('10000.0'));
  }
}

class ManualMockTransactionRepository extends Mock implements TransactionRepository {
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
  Future<Map<String, dynamic>> getDuitNowStatus(String referenceId) async {
    return {
      'status': mockDuitNowStatus ?? 'COMPLETED',
      'referenceId': referenceId,
    };
  }

  @override
  Future<TransactionExecutionResponse> executeTransaction(TransactionExecutionRequest request, String agentId, {String? idempotencyKey}) async {
    return mockExecution ?? TransactionExecutionResponse(status: 'SUCCESS', referenceId: 'REF-EXE');
  }

  @override
  Future<TransactionExecutionResponse> balanceInquiry(TransactionExecutionRequest request, String agentId) async {
     return mockExecution ?? TransactionExecutionResponse(status: 'SUCCESS', referenceId: 'REF-BAL');
  }
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

class ManualFloatNotifier extends FloatNotifier {
  ManualFloatNotifier() : super(FakeFloatRepository(), null);
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

class ManualMockGeolocator extends Fake implements GeolocatorPlatform {
  @override
  Future<Position> getCurrentPosition({LocationSettings? locationSettings}) async {
    return Position(longitude: 101.0, latitude: 3.0, timestamp: DateTime.now(), accuracy: 1.0, altitude: 1.0, heading: 1.0, speed: 1.0, speedAccuracy: 1.0, altitudeAccuracy: 1.0, headingAccuracy: 1.0);
  }
}

class FakeEodTimerService extends Mock implements EodTimerService {
  @override
  EodStatus getCurrentEodStatus() => EodStatus.open;
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
      ref: ManualMockRef(),
      repository: mockRepo,
      cardReader: mockCardReader,
      pinPad: mockPinPad,
      floatNotifier: mockFloatNotifier,
      reversalService: mockReversalService,
      myKadScanner: mockMyKadScanner,
      complianceNotifier: mockComplianceNotifier,
      eodTimerService: FakeEodTimerService(),
      geolocator: ManualMockGeolocator(),
      pollingInterval: const Duration(milliseconds: 1),
    );
  });

  group('DuitNow Transfer Provider', () {
    test('Mobile Number proxy triggers RTP and enters polling state', () async {
      mockRepo.mockExecution = TransactionExecutionResponse(
        status: 'SUCCESS',
        referenceId: 'REF-DUT-001',
      );

      await notifier.startTransaction(
        Decimal.parse('100.0'),
        TestCredentials.username,
        serviceCode: 'DUITNOW_TRANSFER',
        fundingSource: FundingSource.DUITNOW_MOBILE,
      );

      if (notifier.state.status == TransactionStatus.failed) {
        print('DEBUG: Transaction failed with error: ${notifier.state.error}');
      }
      await notifier.confirmConsent(duitNowProxyId: '0123456789');
      
      // Wait for async polling to finish
      for (int i = 0; i < 20; i++) {
        if (notifier.state.status == TransactionStatus.success) break;
        await Future.delayed(const Duration(milliseconds: 10));
      }
      
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
        TestCredentials.username,
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
        status: 'PENDING',
        referenceId: 'REF-DUT-003',
      );
      
      // Always return PENDING to trigger timeout
      mockRepo.mockDuitNowStatus = 'PENDING';

      await notifier.startTransaction(
        Decimal.parse('100.0'),
        TestCredentials.username,
        serviceCode: 'DUITNOW_TRANSFER',
        fundingSource: FundingSource.DUITNOW_MOBILE,
      );

      await notifier.confirmConsent(duitNowProxyId: '0123456789');

      // Wait for async polling to finish with timeout
      for (int i = 0; i < 40; i++) {
        if (notifier.state.status == TransactionStatus.reversalQueued) break;
        await Future.delayed(const Duration(milliseconds: 10));
      }

      expect(notifier.state.status, equals(TransactionStatus.reversalQueued));
      expect(mockReversalService.lastReversalRequest, isNotNull);
    });
  });
}
