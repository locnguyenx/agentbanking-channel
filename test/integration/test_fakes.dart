/// Shared lightweight fakes for integration tests.
///
/// These are simple in-memory fakes (not mockito mocks) — each notifier
/// test constructs only the 2-5 fakes it needs.
library;
import 'dart:async';
import 'package:decimal/decimal.dart';
import 'package:agentbanking_channel/features/hardware/hardware_interfaces.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';
import 'package:agentbanking_channel/features/transactions/services/reversal_service.dart';
import 'package:agentbanking_channel/features/settlement/providers/float_provider.dart';
import 'package:agentbanking_channel/features/settlement/models/float_models.dart';
import 'package:agentbanking_channel/features/settlement/repositories/float_repository.dart';
import 'package:agentbanking_channel/core/offline/offline_queue_service.dart';

// ─── Card Reader ──────────────────────────────────────────────────────────

class FakeCardReader implements ICardReader {
  CardData? cardDataToReturn;
  bool shouldFail = false;

  FakeCardReader({this.cardDataToReturn, this.shouldFail = false}) {
    cardDataToReturn ??= CardData(maskedPan: '411111******1111', cardToken: 'FAKE_TOKEN');
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
  TransactionQuoteResponse? quoteToReturn;
  TransactionExecutionResponse? executionToReturn;
  String? billerStatusToReturn;
  String? proxyEnquiryNameToReturn;
  Map<String, String>? duitNowStatusToReturn;
  Map<String, String>? qrSaleToReturn;
  TransactionExecutionResponse? duitNowInitiateToReturn;

  bool shouldFailQuote = false;
  bool shouldFailExecute = false;
  bool shouldFailProxyEnquiry = false;
  bool shouldTimeout = false;
  int proxyEnquiryCallCount = 0;
  int proxyEnquiryFailUntilAttempt = 0; // fail first N attempts

  FakeTransactionRepository() {
    quoteToReturn = TransactionQuoteResponse(
      quoteId: 'FAKE_QUOTE_001',
      amount: Decimal.fromInt(100),
      fee: Decimal.fromInt(1),
      commission: Decimal.parse('0.50'),
      total: Decimal.fromInt(101),
    );
    executionToReturn = TransactionExecutionResponse(
      status: 'SUCCESS',
      referenceId: 'FAKE_REF_001',
    );
    billerStatusToReturn = 'SUCCESS';
    proxyEnquiryNameToReturn = 'AHMAD BIN ABDULLAH';
    duitNowStatusToReturn = {'status': 'SUCCESS', 'transactionId': 'DN_REF_001'};
    duitNowInitiateToReturn = TransactionExecutionResponse(
      status: 'PENDING',
      referenceId: 'DN_REF_001',
    );
    qrSaleToReturn = {'qrPayload': 'FAKE_QR_PAYLOAD', 'referenceId': 'QR_REF_001'};
  }

  @override
  Future<TransactionQuoteResponse> getQuote(TransactionQuoteRequest request) async {
    if (shouldFailQuote) throw Exception('Quote failed');
    return quoteToReturn!;
  }

  @override
  Future<TransactionExecutionResponse> executeTransaction(
    TransactionExecutionRequest request, String agentId, {String? idempotencyKey}) async {
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
  Future<TransactionExecutionResponse> initiateDuitNow({
    required String quoteId,
    required String proxyId,
    required String proxyType,
    required Decimal amount,
  }) async {
    return duitNowInitiateToReturn!;
  }

  @override
  Future<Map<String, String>> getDuitNowStatus(String referenceId) async {
    return duitNowStatusToReturn!;
  }

  @override
  Future<Map<String, String>> generateQrSale(Decimal amount, String agentId) async {
    return qrSaleToReturn!;
  }

  @override
  Future<TransactionExecutionResponse> balanceInquiry(
    TransactionExecutionRequest request, String merchantId) async {
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

class FakeFloatRepository implements FloatRepository {
  @override
  Future<FloatLedger> getFloatStatus(String agentId) async {
    return FloatLedger(currentBalance: Decimal.fromInt(5000), limit: Decimal.fromInt(10000));
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
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

// ─── Reversal Service ─────────────────────────────────────────────────────

class FakeOfflineQueueService implements OfflineQueueService {
  final List<Map<String, dynamic>> queuedItems = [];

  @override
  Future<void> enqueue(Map<String, dynamic> payload, String idempotencyKey) async {
    queuedItems.add(payload);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class FakeReversalService extends ReversalService {
  final List<Map<String, dynamic>> queuedReversals = [];

  FakeReversalService() : super(FakeOfflineQueueService());

  @override
  Future<void> queueReversal(Map<String, dynamic> originalRequest) async {
    queuedReversals.add(originalRequest);
  }
}
