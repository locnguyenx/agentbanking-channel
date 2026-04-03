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
import 'package:geolocator/geolocator.dart';
import 'package:mockito/mockito.dart';
import '../../test_utils.dart';

class FakeFloatRepository extends Fake implements FloatRepository {
  @override
  Future<FloatLedger> getFloatStatus(String agentId) async {
    return FloatLedger(currentBalance: Decimal.parse('5000.0'), limit: Decimal.parse('10000.0'));
  }
}

class ManualMockTransactionRepository extends Mock implements TransactionRepository {
  TransactionQuoteResponse? mockQuote;
  TransactionExecutionResponse? mockExecution;

  @override
  Future<TransactionQuoteResponse> getQuote(TransactionQuoteRequest request) async {
    return mockQuote ?? TransactionQuoteResponse(
      quoteId: 'Q-EXT-001',
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
      referenceId: 'REF-EXT-001',
    );
  }

  @override
  Future<TransactionExecutionResponse> initiateDuitNow({
    required String quoteId,
    required String proxyId,
    required String proxyType,
    required Decimal amount,
  }) async {
    return mockExecution ?? TransactionExecutionResponse(
      status: 'SUCCESS',
      referenceId: 'REF-DUT-001',
    );
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
  @override
  Future<void> queueReversal(Map<String, dynamic> originalRequest) async {}
}

class ManualMyKadScanner implements IMyKadScanner {
  @override
  Future<bool> isAvailable() async => true;
  @override
  Future<MyKadData?> scanMyKad() async => null;
}

class ManualMockGeolocator extends Mock implements GeolocatorPlatform {
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
    mockComplianceNotifier = ManualMockComplianceNotifier();
    mockCardReader = ManualCardReader();
    mockPinPad = ManualPinPad();
    mockFloatNotifier = ManualFloatNotifier();
    mockReversalService = ManualReversalService();
    mockMyKadScanner = ManualMyKadScanner();

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

  group('Extended Services (ESSP)', () {
    test('ESSP Purchase flow sets state to success', () async {
      final amount = Decimal.parse('10.0');
      
      await notifier.startTransaction(amount, 'AGENT-001', 
        serviceCode: 'ESSP_PURCHASE', 
        fundingSource: FundingSource.CASH,
        metadata: {'productCode': 'ESSP_TOKEN'}
      );

      expect(notifier.state.status, TransactionStatus.waitingConsent);

      mockRepo.mockExecution = TransactionExecutionResponse(
        status: 'SUCCESS',
        referenceId: 'REF-ESSP-001',
      );

      await notifier.confirmConsent();

      expect(notifier.state.status, TransactionStatus.success);
      expect(notifier.state.result?.referenceId, 'REF-ESSP-001');
    });

    test('ESSP Purchase failure sets state to failed', () async {
      final amount = Decimal.parse('10.0');
      
      await notifier.startTransaction(amount, 'AGENT-001', 
        serviceCode: 'ESSP_PURCHASE', 
        fundingSource: FundingSource.CASH,
        metadata: {'productCode': 'ESSP_TOKEN'}
      );

      mockRepo.mockExecution = TransactionExecutionResponse(
        status: 'FAILED',
        referenceId: 'REF-ERR-001',
        errorMessage: 'OUT_OF_STOCK',
      );

      await notifier.confirmConsent();

      expect(notifier.state.status, TransactionStatus.failed);
      expect(notifier.state.error, 'OUT_OF_STOCK');
    });
  });
}
