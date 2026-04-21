import 'package:flutter_test/flutter_test.dart';
import 'package:decimal/decimal.dart';
import 'package:agent_api/agent_api.dart';
import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';
import 'package:agentbanking_channel/features/settlement/repositories/float_repository.dart';
import 'package:agentbanking_channel/features/auth/repositories/auth_repository.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart' as models;
import 'package:agentbanking_channel/core/security/secure_storage_manager.dart';
import '../features/transactions/manual_mock_dio.dart';
import '../setup/test_credentials.dart';

class FakeSecureStorage extends Fake implements SecureStorageManager {
  String? savedJwt;
  @override
  Future<void> saveJwt(String jwt) async {
    savedJwt = jwt;
  }
}

void main() {
  late ManualMockDio mockDio;
  late FakeSecureStorage fakeStorage;
  late TransactionRepository transactionRepo;
  late FloatRepository floatRepo;
  late AuthRepository authRepo;

  setUp(() {
    mockDio = ManualMockDio();
    fakeStorage = FakeSecureStorage();
    
    transactionRepo = TransactionRepository(
      ledgerApi: LedgerControllerLedgerServiceApi(mockDio, standardSerializers),
      merchantApi: MerchantControllerLedgerServiceApi(mockDio, standardSerializers),
      billerApi: BillerControllerBillerServiceApi(mockDio, standardSerializers),
      switchApi: SwitchControllerBillerServiceApi(mockDio, standardSerializers),
      onboardingApi: OnboardingControllerOnboardingServiceApi(mockDio, standardSerializers),
      esspApi: EsspControllerBillerServiceApi(mockDio, standardSerializers),
      ewalletApi: EWalletControllerBillerServiceApi(mockDio, standardSerializers),
      transactionApi: TransactionControllerRulesServiceApi(mockDio, standardSerializers),
      orchestratorApi: OrchestratorControllerOrchestratorServiceApi(mockDio, standardSerializers),
      complianceApi: ComplianceControllerOnboardingServiceApi(mockDio, standardSerializers),
      dio: mockDio,
    );
    
    final ledgerApi = LedgerControllerLedgerServiceApi(mockDio, standardSerializers);
    floatRepo = FloatRepository(ledgerApi);
    
    final authApi = AuthControllerAuthIamServiceApi(mockDio, standardSerializers);
    authRepo = AuthRepository(
      secureStorage: fakeStorage,
      authApi: authApi,
    );
  });

  group('TransactionRepository Contract Tests', () {
    test('getQuote hits /api/v1/transactions/quote', () async {
      mockDio.setResponse('/api/v1/transactions/quote', {
        'quoteId': 'QT123',
        'amount': '100.0',
        'fee': '1.0',
        'total': '101.0',
        'commission': '0.5',
      });

      final request = models.TransactionQuoteRequest(
        serviceCode: 'CASH_WITHDRAWAL',
        amount: Decimal.parse('100.0'),
        agentId: TestCredentials.username,
        fundingSource: models.FundingSource.CARD_EMV,
      );

      final response = await transactionRepo.getQuote(request);

      expect(response.quoteId, 'QT123');
      expect(response.amount, Decimal.parse('100.0'));
      expect(response.fee, Decimal.parse('1.0'));
    });

    test('performProxyEnquiry hits /api/v1/transfer/proxy/enquiry', () async {
      mockDio.setResponse('/api/v1/transfer/proxy/enquiry.*', 'John Doe');

      final name = await transactionRepo.performProxyEnquiry('0123456789', 'MOBILE');

      expect(name, 'John Doe');
    });

    test('getComplianceStatus hits /api/v1/compliance/status', () async {
      mockDio.setResponse('/api/v1/compliance/status', {'status': 'UNLOCKED'});

      final status = await transactionRepo.getComplianceStatus();

      expect(status, 'UNLOCKED');
    });
  });

  group('FloatRepository Contract Tests', () {
    test('getFloatStatus hits /api/v1/agent/balance', () async {
      mockDio.setResponse('/api/v1/agent/balance.*', {
        'balance': 5000.0,
        'currency': 'MYR',
      });

      final status = await floatRepo.getFloatStatus(TestCredentials.username);

      expect(status.currentBalance, Decimal.parse('5000.0'));
    });
  });

  group('AuthRepository Contract Tests', () {
    test('login hits /api/v1/auth/token', () async {
      mockDio.setResponse('/api/v1/auth/token', {
        'access_token': 'test-token',
        'token_type': 'Bearer',
        'expires_in': 3600,
        'refresh_token': 'refresh-token',
      });

      final user = await authRepo.login(TestCredentials.username, TestCredentials.password);

      expect(user.agentId, TestCredentials.username);
      expect(fakeStorage.savedJwt, 'test-token');
    });
  });
}
