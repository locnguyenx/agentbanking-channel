import 'dart:async';
import 'package:decimal/decimal.dart';
import 'package:geolocator_platform_interface/geolocator_platform_interface.dart';
import 'package:mockito/mockito.dart';
import 'package:agent_api/agent_api.dart' as agent_api;

import 'package:agentbanking_channel/features/auth/models/auth_models.dart';
import 'package:agentbanking_channel/features/auth/repositories/auth_repository.dart';
import 'package:agentbanking_channel/core/security/secure_storage_manager.dart';
import 'package:agentbanking_channel/core/offline/offline_queue_service.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart' as model;
import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';
import 'package:agentbanking_channel/features/settlement/providers/float_provider.dart';
import 'package:agentbanking_channel/features/settlement/models/float_models.dart' as float_model;
import 'package:agentbanking_channel/features/settlement/repositories/float_repository.dart';
import 'package:agentbanking_channel/features/kyc/repositories/kyc_repository.dart';
import 'package:agentbanking_channel/features/kyc/models/kyc_models.dart' as kyc_model;
import 'package:agentbanking_channel/features/agent_onboarding/repositories/agent_onboarding_repository.dart';
import 'package:agentbanking_channel/features/merchant/models/merchant_models.dart' as merchant_model;
import '../../setup/test_credentials.dart';

// ─── Factory Functions ────────────────────────────────────────────────────

MockAuthRepository createMockAuthRepo({
  bool isWhitelisted = true,
  bool shouldFail = false,
}) {
  final repo = MockAuthRepository();
  repo.isDeviceWhitelisted = isWhitelisted;
  return repo;
}

MockSecureStorage createMockSecureStorage({
  String? jwt,
  bool complianceLocked = false,
}) {
  final storage = MockSecureStorage();
  storage.jwt = jwt;
  storage.complianceLocked = complianceLocked;
  return storage;
}

MockTransactionRepository createMockTransactionRepo({bool shouldFail = false}) {
  final repo = MockTransactionRepository();
  repo.shouldFail = shouldFail;
  return repo;
}

MockGeolocator createMockGeolocator({bool shouldThrow = false}) {
  final geo = MockGeolocator();
  geo.shouldThrow = shouldThrow;
  return geo;
}

// ─── Mock Implementations ─────────────────────────────────────────────────

class MockAuthRepository extends Fake implements AuthRepository {
  @override
  bool isDeviceWhitelisted = true;
  
  @override
  late SecureStorageManager secureStorage;

  AuthUser? authUser;
  String? loginBiometricStub;

  @override
  Future<AuthUser> login(String agentId, String password) async {
    if (!isDeviceWhitelisted) throw Exception('ERR_AUTH_DEVICE_NOT_WHITELISTED');
    return AuthUser(
      agentId: agentId, 
      name: 'BDD Tester', 
      tier: 'MICRO',
      registeredLat: 3.1390,
      registeredLng: 101.6869,
    );
  }

  @override
  Future<AuthUser> loginBiometric() async {
    if (!isDeviceWhitelisted) throw Exception('ERR_AUTH_DEVICE_NOT_WHITELISTED');
    final user = AuthUser(
      agentId: TestCredentials.username, 
      name: 'BDD Tester', 
      tier: 'MICRO',
      registeredLat: 3.1390,
      registeredLng: 101.6869,
    );
    await secureStorage.saveJwt('BDD_TEST_JWT_BIO');
    return user;
  }


}

class MockSecureStorage extends Fake implements SecureStorageManager {
  String? jwt;
  bool complianceLocked = false;
  Map<String, bool> complianceLocks = {};

  @override
  Future<String?> readJwt() async => jwt;
  @override
  Future<void> saveJwt(String token) async {
    jwt = token;
  }
  @override
  Future<void> clearJwt() async => jwt = null;
  @override
  Future<bool> getComplianceLocked() async {
    final locked = complianceLocks['compliance_locked'] ?? complianceLocked;
    return locked;
  }
  @override
  Future<void> setComplianceLock(bool locked) async {
    complianceLocked = locked;
    complianceLocks['compliance_locked'] = locked;
  }
  @override
  Future<String> getSqlCipherPassphrase() async => 'bdd-passphrase';


}

class MockTransactionRepository extends Fake implements TransactionRepository {
  Decimal? lastQrAmount;
  bool shouldFail = false;
  Future<model.TransactionQuoteResponse> Function(model.TransactionQuoteRequest)? getQuoteStub;
  Future<model.TransactionExecutionResponse> Function(model.TransactionExecutionRequest, String)? executeTransactionStub;
  Future<String> Function(String, String)? performProxyEnquiryStub;
  Future<model.TransactionExecutionResponse> Function(model.TransactionExecutionRequest, String)? balanceInquiryStub;

  @override
  Future<model.TransactionQuoteResponse> getQuote(model.TransactionQuoteRequest request) async {
    await Future.delayed(Duration.zero);
    if (getQuoteStub != null) return getQuoteStub!(request);
    if (shouldFail) throw Exception('ERR_EXT_BILLER_UNAVAILABLE');
    return model.TransactionQuoteResponse(
      amount: request.amount,
      fee: Decimal.parse('1.00'),
      total: request.amount + Decimal.parse('1.00'),
      commission: Decimal.parse('0.50'),
      quoteId: 'BDD_QUOTE_123',
    );
  }

  @override
  Future<model.TransactionExecutionResponse> executeTransaction(
    model.TransactionExecutionRequest request, String agentId, {String? idempotencyKey}) async {
    await Future.delayed(Duration.zero);
    if (executeTransactionStub != null) return executeTransactionStub!(request, agentId);
    if (shouldFail) throw Exception('INSUFFICIENT_FUNDS');
    return model.TransactionExecutionResponse(status: 'SUCCESS', referenceId: 'REF_123');
  }
  @override
  Future<model.TransactionExecutionResponse> initiateDuitNow({
    required String quoteId,
    required String proxyId,
    required String proxyType,
    required Decimal amount,
    required String agentId,
  }) async {
    lastQrAmount = amount;
    return model.TransactionExecutionResponse(
      status: 'PENDING',
      referenceId: 'DUITNOW_REF_123',
    );
  }

  @override
  Future<Map<String, dynamic>> getDuitNowStatus(String referenceId) async {
    return {
      'status': 'SUCCESS',
      'transactionId': 'TXN_ID_123',
      'netToMerchant': 49.75,
      'mdrAmount': 0.25,
    };
  }

  @override
  Future<String> performProxyEnquiry(String proxyId, String proxyType) async {
    if (performProxyEnquiryStub != null) return performProxyEnquiryStub!(proxyId, proxyType);
    return 'MOHD A***D BIN AL*';
  }

  @override
  Future<String> getBillerStatus(String transactionId) async {
    return 'SUCCESS';
  }

  @override
  Future<model.TransactionExecutionResponse> balanceInquiry(model.TransactionExecutionRequest request, String agentId) async {
    await Future.delayed(Duration.zero);
    if (balanceInquiryStub != null) return balanceInquiryStub!(request, agentId);
    return model.TransactionExecutionResponse(
        status: 'SUCCESS', 
        referenceId: 'BAL_REF_123',
        balance: Decimal.parse('1000.00'),
        currency: 'MYR',
    );
  }

  @override
  Future<merchant_model.RetailSaleResponse> executeRetailSale(Decimal amount, String agentId, {String? pinBlock, String? cardToken}) async {
    await Future.delayed(Duration.zero);
    if (shouldFail) throw Exception('RETAIL_SALE_FAILED');
    return merchant_model.RetailSaleResponse(
      floatCreditAmount: amount * Decimal.parse('0.99'), // 1% MDR
      mdrAmount: amount * Decimal.parse('0.01'),
      receiptReference: 'RETAIL_REF_123',
    );
  }

  @override
  Future<merchant_model.CashbackResponse> executeCashback(Decimal purchaseAmount, Decimal cashbackAmount, String agentId, {String? pinBlock, String? cardToken}) async {
    await Future.delayed(Duration.zero);
    if (shouldFail) throw Exception('CASHBACK_FAILED');
    return merchant_model.CashbackResponse(
      purchaseAmount: purchaseAmount,
      cashBackAmount: cashbackAmount,
      receiptReference: 'CASHBACK_REF_123',
    );
  }

  @override
  Future<merchant_model.PinPurchaseResponse> executePinPurchase(Decimal amount, String agentId, String productCode) async {
    await Future.delayed(Duration.zero);
    if (shouldFail) throw Exception('PIN_PURCHASE_FAILED');
    return merchant_model.PinPurchaseResponse(
      pinCode: '1234-5678-9012-3456',
      receiptReference: 'PIN_REF_123',
      commissionEarned: Decimal.parse('0.50'),
    );
  }

  @override
  Future<Map<String, String>> generateQrSale(Decimal amount, String agentId) async {
    await Future.delayed(Duration.zero);
    return {
      'qrPayload': 'BDD_QR_PAYLOAD',
      'referenceId': 'QR_REF_123',
    };
  }


}

class MockOfflineQueueService extends Fake implements OfflineQueueService {
  int count = 0;
  final List<Map<String, dynamic>> _pending = [];

  @override
  Future<void> init() async {}

  @override
  Future<void> enqueue(Map<String, dynamic> payload, String idempotencyKey) async {
    count++;
    _pending.add({'payload': payload, 'key': idempotencyKey});
  }

  @override
  Future<int> getCount() async => count;

  @override
  Future<List<Map<String, dynamic>>> getPending() async => _pending;

  @override
  Future<void> remove(int id) async {
    if (id >= 0 && id < _pending.length) {
      _pending.removeAt(id);
    }
  }


}

class FakeFloatRepository extends Fake implements FloatRepository {
  @override
  Future<float_model.FloatLedger> getFloatStatus(String agentId) async {
    return float_model.FloatLedger(
      currentBalance: Decimal.fromInt(5000),
      limit: Decimal.fromInt(10000),
    );
  }


}

class FakeFloatNotifier extends FloatNotifier {
  FakeFloatNotifier() : super(FakeFloatRepository(), null, startTimer: false) {
    state = float_model.FloatLedger(
      currentBalance: Decimal.parse('5000.0'),
      limit: Decimal.parse('10000.0'),
    );
  }
  @override
  Future<void> fetchLatestBalance() async {
    state = float_model.FloatLedger(
      currentBalance: Decimal.fromInt(5000),
      limit: Decimal.fromInt(10000),
    );
  }
}

class MockGeolocator extends Fake implements GeolocatorPlatform {
  Position? position;
  bool shouldThrow = false;

  MockGeolocator() {
    position = Position(
      latitude: 3.1390, longitude: 101.6869,
      timestamp: DateTime.now(), accuracy: 1.0, altitude: 0.0, heading: 0.0,
      speed: 0.0, speedAccuracy: 0.0, altitudeAccuracy: 0.0, headingAccuracy: 0.0,
    );
  }

  @override
  Future<Position> getCurrentPosition({LocationSettings? locationSettings}) async {
    if (shouldThrow) throw Exception('GPS_DISABLED');
    return position!;
  }

  @override
  Future<LocationPermission> checkPermission() async => LocationPermission.always;
  @override
  Future<LocationPermission> requestPermission() async => LocationPermission.always;
  @override
  Future<bool> isLocationServiceEnabled() async => true;


}

class FakeKycRepository extends Fake implements KycRepository {
  @override
  Future<kyc_model.KycValidationResponse> validateKyc(kyc_model.KycValidationRequest request) async {
    return kyc_model.KycValidationResponse(isApproved: true, reasons: []);
  }
  @override
  Future<void> openAccount(String icNumber, String productCode) async {}


}

class FakeAgentOnboardingRepository extends Fake implements AgentOnboardingRepository {
  @override
  Future<bool> requestOtp(String phone) async => true;
  @override
  Future<bool> verifyOtp(String phone, String otp) async => otp == '123456';
  @override
  Future<agent_api.AgentResponse?> submitOnboarding({
    required String mykadNumber,
    required String ssmNumber,
    required String businessName,
    required String phoneNumber,
    double? lat,
    double? lng,
  }) async {
    return agent_api.AgentResponse((b) => b
      ..status = agent_api.AgentResponseStatusEnum.ACTIVE
      ..tier = agent_api.AgentResponseTierEnum.MICRO
    );
  }


}
