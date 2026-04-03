import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/compliance/providers/compliance_provider.dart';
import 'package:agentbanking_channel/features/settlement/services/eod_timer_service.dart';

import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';
import 'package:agentbanking_channel/features/hardware/hardware_interfaces.dart';
import 'package:geolocator/geolocator.dart';
import 'package:agentbanking_channel/features/settlement/providers/float_provider.dart';
import 'package:agentbanking_channel/features/transactions/services/reversal_service.dart';
import 'package:agentbanking_channel/core/security/secure_storage_manager.dart';
import '../../test_utils.dart';

class FakeSecureStorageManager implements SecureStorageManager {
  final Map<String, String> _data = {};

  @override
  Future<void> saveJwt(String jwt) async => _data['agent_jwt'] = jwt;
  @override
  Future<void> clearJwt() async => _data.remove('agent_jwt');
  @override
  Future<String?> readJwt() async => _data['agent_jwt'];
  
  @override
  Future<void> setComplianceLock(bool isLocked) async => _data['compliance_locked'] = isLocked.toString();
  @override
  Future<bool> getComplianceLocked() async => _data['compliance_locked'] == 'true';

  @override
  Future<String> getSqlCipherPassphrase() async => 'test-pass';
  
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}


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

  @override
  Future<TransactionExecutionResponse> executeTransaction(TransactionExecutionRequest request, String agentId, {String? idempotencyKey}) async {
    return TransactionExecutionResponse(status: 'SUCCESS', referenceId: 'REF1');
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
  late FakeSecureStorageManager fakeStorage;
  late FakeEodTimerService fakeEodTimer;

  setUp(() {
    mockRepo = ManualMockTransactionRepository();
    mockCardReader = MockICardReader();
    mockPinPad = MockIPinPad();
    mockFloatNotifier = MockFloatNotifier();
    mockReversalService = MockReversalService();
    fakeStorage = FakeSecureStorageManager();
    complianceNotifier = ComplianceNotifier(secureStorage: fakeStorage);

    fakeEodTimer = FakeEodTimerService();

    notifier = TransactionNotifier(
      ref: ManualMockRef(),
      repository: mockRepo,
      cardReader: mockCardReader,
      pinPad: mockPinPad,
      floatNotifier: mockFloatNotifier,
      reversalService: mockReversalService,
      myKadScanner: MockMyKadScanner(),
      complianceNotifier: complianceNotifier,
      eodTimerService: fakeEodTimer,
      geolocator: ManualMockGeolocator(),
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

  test('LOCKED state persists across app restarts (BDD @US-CA-16 FR-CA-6.3)', () async {
    // 1. Freeze using one notifier instance
    complianceNotifier.freeze('VELOCITY_EXCEEDED');
    expect(complianceNotifier.state.isFrozen, true);

    // 2. Simulate app restart: create a new notifier with the same storage
    final newComplianceNotifier = ComplianceNotifier(secureStorage: fakeStorage);
    
    // Initial state of new notifier should be unfrozen
    expect(newComplianceNotifier.state.isFrozen, false);
    
    // 3. Restore state
    await newComplianceNotifier.init();
    
    // Now it should be frozen
    expect(newComplianceNotifier.state.isFrozen, true);
    expect(newComplianceNotifier.state.reason, 'PERSISTED_LOCK');
  });
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
