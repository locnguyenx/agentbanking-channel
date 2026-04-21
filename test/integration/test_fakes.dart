/// Shared lightweight fakes for integration tests.
///
/// These are simple in-memory fakes (not mockito mocks) — each notifier
/// test constructs only the 2-5 fakes it needs.
library;
import 'dart:async';
import 'package:decimal/decimal.dart';
import 'package:dio/dio.dart';
import 'package:agent_api/agent_api.dart';
import 'package:agentbanking_channel/features/hardware/hardware_interfaces.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart' as models;
import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';
import 'package:agentbanking_channel/features/transactions/services/reversal_service.dart';
import 'package:agentbanking_channel/features/settlement/providers/float_provider.dart';
import 'package:agentbanking_channel/features/settlement/models/float_models.dart';
import 'package:agentbanking_channel/features/settlement/repositories/float_repository.dart';
import 'package:agentbanking_channel/features/auth/repositories/auth_repository.dart';
import 'package:agentbanking_channel/features/auth/models/auth_models.dart';
import 'package:agentbanking_channel/features/auth/providers/auth_provider.dart';
import 'package:agentbanking_channel/features/compliance/providers/compliance_provider.dart';
import 'package:agentbanking_channel/features/settlement/services/eod_timer_service.dart';
import 'package:agentbanking_channel/core/offline/offline_queue_service.dart';
import 'package:agentbanking_channel/core/security/secure_storage_manager.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';

// ─── Card Reader ──────────────────────────────────────────────────────────

class FakeCardReader implements ICardReader {
  CardData? cardDataToReturn;
  bool shouldFail = false;

  FakeCardReader({this.cardDataToReturn, this.shouldFail = false}) {
    cardDataToReturn ??= CardData(pan: '4111222233334444', cardToken: 'FAKE_TOKEN');
  }

  @override
  Future<bool> isAvailable() async => !shouldFail;

  @override
  Future<CardData?> readCard() async {
    if (shouldFail) return null;
    return cardDataToReturn;
  }
}

// ─── PIN Pad ──────────────────────────────────────────────────────────────

class FakePinPad implements IPinPad {
  String? pinBlockToReturn;
  bool shouldCancel = false;

  FakePinPad({this.pinBlockToReturn, this.shouldCancel = false}) {
    pinBlockToReturn ??= 'FAKE_PIN_BLOCK';
  }

  @override
  Future<bool> isAvailable() async => !shouldCancel;

  @override
  Future<String?> capturePin() async {
    if (shouldCancel) return null;
    return pinBlockToReturn;
  }
}

// ─── MyKad Scanner ────────────────────────────────────────────────────────

class FakeMyKadScanner implements IMyKadScanner {
  MyKadData? dataToReturn;
  bool shouldFail = false;

  FakeMyKadScanner({this.dataToReturn, this.shouldFail = false}) {
    dataToReturn ??= MyKadData(
      fullName: 'AHMAD BIN ABDULLAH',
      icNumber: '850101-01-5678',
      address: 'LOT 123, JALAN AMPANG',
    );
  }

  @override
  Future<bool> isAvailable() async => !shouldFail;

  @override
  Future<MyKadData?> scanMyKad() async {
    if (shouldFail) return null;
    return dataToReturn;
  }
}

// ─── Transaction Repository ───────────────────────────────────────────────

class FakeTransactionRepository implements TransactionRepository {
  models.TransactionQuoteResponse? quoteToReturn;
  models.TransactionExecutionResponse? executionToReturn;
  String? billerStatusToReturn;
  String? proxyEnquiryNameToReturn;
  Map<String, String>? duitNowStatusToReturn;
  Map<String, String>? qrSaleToReturn;
  models.TransactionExecutionResponse? duitNowInitiateToReturn;

  bool shouldFailQuote = false;
  bool shouldFailExecute = false;
  bool shouldFailProxyEnquiry = false;
  bool shouldTimeout = false;
  int proxyEnquiryCallCount = 0;
  int proxyEnquiryFailUntilAttempt = 0; // fail first N attempts
  int duitNowPollCount = 0;

  FakeTransactionRepository() {
    quoteToReturn = models.TransactionQuoteResponse(
      quoteId: 'FAKE_QUOTE_001',
      amount: Decimal.fromInt(100),
      fee: Decimal.fromInt(1),
      commission: Decimal.parse('0.50'),
      total: Decimal.fromInt(101),
    );
    executionToReturn = models.TransactionExecutionResponse(
      status: 'SUCCESS',
      referenceId: 'FAKE_REF_001',
    );
    billerStatusToReturn = 'SUCCESS';
    proxyEnquiryNameToReturn = 'AHMAD BIN ABDULLAH';
    duitNowStatusToReturn = {'status': 'SUCCESS', 'transactionId': 'DN_REF_001'};
    duitNowInitiateToReturn = models.TransactionExecutionResponse(
      status: 'PENDING',
      referenceId: 'DN_REF_001',
    );
    qrSaleToReturn = {'qrPayload': 'FAKE_QR_PAYLOAD', 'referenceId': 'QR_REF_001'};
  }

  @override
  Future<models.TransactionQuoteResponse> getQuote(models.TransactionQuoteRequest request) async {
    if (shouldFailQuote) throw Exception('Quote failed');
    return quoteToReturn!;
  }

  @override
  Future<models.TransactionExecutionResponse> executeTransaction(
    models.TransactionExecutionRequest request, String agentId, {String? idempotencyKey}) async {
    if (shouldTimeout) {
      throw DioExceptionForTest(type: 'receiveTimeout');
    }
    if (shouldFailExecute) throw Exception('Execution failed');
    return executionToReturn!;
  }

  @override
  Future<String> getBillerStatus(String transactionId) async {
    return billerStatusToReturn!;
  }

  @override
  Future<String> performProxyEnquiry(String proxyId, String proxyType) async {
    proxyEnquiryCallCount++;
    if (shouldFailProxyEnquiry && proxyEnquiryCallCount <= proxyEnquiryFailUntilAttempt) {
      throw Exception('ProxyEnquiry failed');
    }
    return proxyEnquiryNameToReturn!;
  }

  @override
  Future<models.TransactionExecutionResponse> initiateDuitNow({
    required String quoteId,
    required String proxyId,
    required String proxyType,
    required Decimal amount,
    required String agentId,
  }) async {
    duitNowPollCount = 0;
    return duitNowInitiateToReturn!;
  }

  @override
  Future<Map<String, String>> getDuitNowStatus(String referenceId) async {
    duitNowPollCount++;
    if (duitNowPollCount <= 2) {
      return {'status': 'PENDING', 'transactionId': referenceId};
    }
    return duitNowStatusToReturn!;
  }

  @override
  Future<Map<String, String>> generateQrSale(Decimal amount, String agentId) async {
    return qrSaleToReturn!;
  }

  @override
  Future<models.TransactionExecutionResponse> balanceInquiry(
    models.TransactionExecutionRequest request, String merchantId) async {
    if (shouldFailExecute) throw Exception('Balance inquiry failed');
    return executionToReturn!;
  }

  // Stubs for methods we don't test in these focused tests
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

/// Lightweight DioException stand-in for timeout testing (avoids importing dio).
class DioExceptionForTest implements Exception {
  final String type;
  DioExceptionForTest({required this.type});
  @override
  String toString() => 'DioException: $type';
}

// ─── Float Notifier ───────────────────────────────────────────────────────

class FakeFloatRepository extends Mock implements FloatRepository {
  @override
  Future<FloatLedger> getFloatStatus(String agentId) async {
    return FloatLedger(currentBalance: Decimal.fromInt(5000), limit: Decimal.fromInt(10000));
  }
}

class FakeFloatNotifier extends FloatNotifier {
  int fetchCallCount = 0;
  FakeFloatNotifier() : super(FakeFloatRepository(), 'FAKE_AGENT', startTimer: false);

  @override
  Future<void> fetchLatestBalance() async {
    fetchCallCount++;
  }

  void resetFetchCount() {
    fetchCallCount = 0;
  }
}

// ─── Auth Notifier ────────────────────────────────────────────────────────

class FakeAuthRepository extends Mock implements AuthRepository {}

class FakeAuthNotifier extends AuthNotifier {
  FakeAuthNotifier({AuthUser? user}) : super(repository: FakeAuthRepository()) {
    if (user != null) {
      // ignore: invalid_use_of_protected_member
      state = state.copyWith(user: user, status: AuthStatus.authenticated);
    }
  }

  void setUser(AuthUser? user) {
    // ignore: invalid_use_of_protected_member
    state = state.copyWith(user: user, status: user != null ? AuthStatus.authenticated : AuthStatus.unauthenticated);
  }
}

// ─── Reversal Service ─────────────────────────────────────────────────────

class FakeOfflineQueueService extends Mock implements OfflineQueueService {
  final List<Map<String, dynamic>> queuedItems = [];

  @override
  Future<void> init() async {}

  @override
  Future<void> enqueue(Map<String, dynamic> payload, String idempotencyKey) async {
    queuedItems.add(payload);
  }

  @override
  Future<List<Map<String, dynamic>>> getPending() async => queuedItems;

  @override
  Future<void> remove(int id) async {}

  @override
  Future<int> getCount() async => queuedItems.length;

  @override
  Stream<int> get queueCountStream => Stream.value(queuedItems.length);
}

class FakeReversalService extends ReversalService {
  final List<Map<String, dynamic>> queuedReversals = [];

  FakeReversalService() : super(FakeOfflineQueueService());

  @override
  Future<void> queueReversal(Map<String, dynamic> originalRequest) async {
    queuedReversals.add(originalRequest);
  }
}

// ─── Compliance Notifier ──────────────────────────────────────────────────

class FakeComplianceNotifier extends ComplianceNotifier {
  FakeComplianceNotifier({bool frozen = false}) : super() {
    // ignore: invalid_use_of_protected_member
    state = ComplianceState(isFrozen: frozen);
  }

  void setFrozen(bool frozen) {
    // ignore: invalid_use_of_protected_member
    state = state.copyWith(isFrozen: frozen);
  }
}

// ─── EOD Timer Service ────────────────────────────────────────────────────

class FakeEodTimerService extends EodTimerService {
  final bool _isLocked;
  FakeEodTimerService({bool locked = false})
      : _isLocked = locked,
        super(clockOverride: DateTime(2026, 1, 1, 12, 0, 0));

  @override
  EodStatus getCurrentEodStatus() {
    return _isLocked ? EodStatus.locked : EodStatus.open;
  }
}

// ─── Geolocator ───────────────────────────────────────────────────────────

class FakeGeolocator extends GeolocatorPlatform {
  Position positionToReturn = Position(
    latitude: 3.1390,
    longitude: 101.6869,
    timestamp: DateTime.now(),
    accuracy: 10.0,
    altitude: 0.0,
    heading: 0.0,
    speed: 0.0,
    speedAccuracy: 0.0,
    altitudeAccuracy: 0.0,
    headingAccuracy: 0.0,
  );
  bool shouldFail = false;

  @override
  Future<Position> getCurrentPosition({LocationSettings? locationSettings}) async {
    if (shouldFail) throw Exception('GPS unavailable');
    return positionToReturn;
  }
}

// ─── Fake Ref ─────────────────────────────────────────────────────────────

class FakeRef extends Mock implements Ref {
  final Map<ProviderListenable, dynamic> _values = {};
  
  void stubProvider<T>(ProviderListenable<T> provider, T value) {
    _values[provider] = value;
  }

  @override
  T read<T>(ProviderListenable<T> provider) {
    if (_values.containsKey(provider)) return _values[provider] as T;
    throw UnimplementedError('Provider not stubbed in FakeRef: $provider');
  }

  @override
  T watch<T>(ProviderListenable<T> provider) => read(provider);
}

// ─── Secure Storage ───────────────────────────────────────────────────────

class FakeSecureStorage extends Fake implements SecureStorageManager {
  final Map<String, String> _data = {};

  @override
  Future<void> saveJwt(String jwt) async => _data['agent_jwt'] = jwt;

  @override
  Future<String?> readJwt() async => _data['agent_jwt'];

  @override
  Future<void> clearJwt() async => _data.remove('agent_jwt');

  @override
  Future<void> write(String key, String value) async => _data[key] = value;

  @override
  Future<String?> read(String key) async => _data[key];

  @override
  Future<void> delete(String key) async => _data.remove(key);

  @override
  Future<String> getSqlCipherPassphrase() async => 'fake-passphrase';

  @override
  Future<void> setComplianceLock(bool isLocked) async => _data['compliance_locked'] = isLocked.toString();

  @override
  Future<bool> getComplianceLocked() async => _data['compliance_locked'] == 'true';
}

// ─── API Mocks ────────────────────────────────────────────────────────────

class ManualMockOrchestratorApi extends Mock implements OrchestratorControllerOrchestratorServiceApi {
  @override
  Future<Response<TransactionStartResponse>> startTransaction({
    required TransactionStartRequest transactionStartRequest,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return Response(
      data: TransactionStartResponse((b) => b
        ..status = TransactionStartResponseStatusEnum.PENDING
        ..workflowId = 'WORKFLOW_${transactionStartRequest.idempotencyKey ?? "123"}'
      ),
      statusCode: 202,
      requestOptions: RequestOptions(path: ''),
    );
  }

  @override
  Future<Response<TransactionStatusResponse>> getTransactionStatus({
    required String workflowId,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return Response(
      data: TransactionStatusResponse((b) => b
        ..status = TransactionStatusResponseStatusEnum.COMPLETED
        ..workflowId = workflowId
        ..referenceNumber = 'REF_$workflowId'
        ..amount = 100.0
      ),
      statusCode: 200,
      requestOptions: RequestOptions(path: ''),
    );
  }
}

class ManualMockResolutionApi extends Mock implements ResolutionControllerOrchestratorServiceApi {}
