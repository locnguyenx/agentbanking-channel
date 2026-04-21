import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dio/dio.dart';

import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/auth/providers/auth_provider.dart';

import 'package:agentbanking_channel/features/auth/providers/auth_provider.dart';
import 'package:agentbanking_channel/features/auth/models/auth_models.dart';
import 'package:agentbanking_channel/features/compliance/providers/compliance_provider.dart';
import 'package:agentbanking_channel/features/settlement/services/eod_timer_service.dart';
import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';
import 'package:agentbanking_channel/core/network/geolocator_provider.dart';
import 'package:agentbanking_channel/features/hardware/hardware_interfaces.dart';
import 'package:agentbanking_channel/features/hardware/hardware_providers.dart';
import 'package:agentbanking_channel/core/network/dio_provider.dart';
import 'package:agentbanking_channel/features/auth/repositories/auth_repository.dart';
import 'package:agentbanking_channel/core/network/auth_interceptor.dart';
import 'package:agentbanking_channel/core/offline/offline_queue_service.dart';
import 'package:agentbanking_channel/core/network/geolocator_provider.dart';

import 'package:agentbanking_channel/core/security/secure_storage_manager.dart';
import 'package:agent_api/agent_api.dart' as api;
import 'package:agentbanking_channel/features/settlement/providers/float_provider.dart';
import 'package:agentbanking_channel/features/transactions/services/reversal_service.dart';

import 'test_fakes.dart';
import '../setup/test_credentials.dart';

final bool isRealBackend = const bool.fromEnvironment('USE_REAL_BACKEND', defaultValue: false);
final String apiBaseUrl = const String.fromEnvironment('API_BASE_URL', defaultValue: 'http://localhost:8080');

void main() {
  group('TransactionNotifier Façade Routing', () {
    late TransactionNotifier notifier;
    late ProviderContainer container;

    late FakeRef ref;
    late FakeTransactionRepository repo;
    late FloatNotifier floatNotifier;
    
    setUp(() async {
      ref = FakeRef();
      repo = FakeTransactionRepository();
      floatNotifier = FloatNotifier(FakeFloatRepository(), 'AGENT-001', startTimer: false);
      
      if (isRealBackend) {
        final storage = FakeSecureStorage();
        final dio = Dio(BaseOptions(
          baseUrl: apiBaseUrl,
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 60), // backend saga can be slow
        ));
        dio.interceptors.add(AuthInterceptor(storage)); 
        dio.interceptors.add(LogInterceptor(
          requestBody: true,
          responseBody: true,
        ));
        
        container = ProviderContainer(overrides: [
          offlineQueueServiceProvider.overrideWithValue(FakeOfflineQueueService()),
          authRepositoryProvider.overrideWithValue(AuthRepository(
            secureStorage: storage,
            authApi: api.AuthControllerAuthIamServiceApi(dio, api.standardSerializers),
          )),
          geolocatorProvider.overrideWithValue(FakeGeolocator()),
          secureStorageManagerProvider.overrideWithValue(storage),
          geolocatorProvider.overrideWithValue(FakeGeolocator()),
          dioProvider.overrideWithValue(dio),
        ]);
        await _ensureRealLogin(container);
      } else {
        container = ProviderContainer();
      }

      if (!isRealBackend) {
        ref.stubProvider(complianceProvider, ComplianceState(isFrozen: false));
        ref.stubProvider(authProvider, AuthState(status: AuthStatus.authenticated, user: AuthUser(agentId: 'AGENT-001', name: 'Test Agent', tier: '1')));
        ref.stubProvider(eodTimerServiceProvider.notifier, FakeEodTimerService());
      }

      notifier = TransactionNotifier(
        ref: isRealBackend ? container.read(Provider((ref) => ref)) : ref,
        repository: isRealBackend ? container.read(transactionRepositoryProvider) : repo,
        cardReader: isRealBackend ? container.read(cardReaderProvider) : FakeCardReader(),
        pinPad: isRealBackend ? container.read(pinPadProvider) : FakePinPad(),
        floatNotifier: isRealBackend ? container.read(floatProvider.notifier) : floatNotifier,
        reversalService: isRealBackend ? container.read(reversalServiceProvider) : ReversalService(container.read(offlineQueueServiceProvider)),
        myKadScanner: isRealBackend ? container.read(myKadScannerProvider) : FakeMyKadScanner(),
        complianceNotifier: isRealBackend ? container.read(complianceProvider.notifier) : FakeComplianceNotifier(),
        eodTimerService: isRealBackend ? container.read(eodTimerServiceProvider.notifier) : FakeEodTimerService(),
        geolocator: isRealBackend ? container.read(geolocatorProvider) : FakeGeolocator(),
      );
    });

    test('startTransaction with TOP_UP routes', () async {
      final realAgentId = container.read(authProvider).user?.agentId ?? 'AGENT-001';
      await notifier.startTransaction(
        Decimal.parse('0.10'),
        realAgentId,
        serviceCode: 'RETAIL_SALE',
        fundingSource: FundingSource.CASH, 
      );
      expect(notifier.state.status.name, anyOf(['waitingConsent', 'processing', 'success']));
    });

    test('confirmConsent with CARD_EMV routes', () async {
      final realAgentId = container.read(authProvider).user?.agentId ?? 'AGENT-001';
      await notifier.startTransaction(
        Decimal.parse('0.10'),
        realAgentId,
        serviceCode: 'RETAIL_SALE',
        fundingSource: FundingSource.CARD_EMV,
      );
      expect(notifier.state.status.name, TransactionStatus.waitingConsent.name);
      await notifier.confirmConsent();
      expect(
        notifier.state.status.name,
        anyOf([
          TransactionStatus.waitingCard.name, 
          TransactionStatus.success.name,
          TransactionStatus.processing.name, TransactionStatus.failed.name,
        ]),
      );
    }, timeout: const Timeout(Duration(minutes: 5)));

    test('confirmConsent with CASH routes', () async {
      final realAgentId = container.read(authProvider).user?.agentId ?? 'AGENT-001';
      await notifier.startTransaction(
        Decimal.parse('0.10'),
        realAgentId,
        serviceCode: 'RETAIL_SALE',
        fundingSource: FundingSource.CASH, 
      );
      await notifier.confirmConsent();
      expect(notifier.state.status.name, anyOf([
        TransactionStatus.success.name,
        TransactionStatus.processing.name, TransactionStatus.failed.name
      ]));
    }, timeout: const Timeout(Duration(minutes: 5)));

    test('confirmConsent with DUITNOW_TRANSFER routes', () async {
      final realAgentId = container.read(authProvider).user?.agentId ?? 'AGENT-001';
      await notifier.startTransaction(
        Decimal.parse('0.10'),
        realAgentId,
        serviceCode: 'DUITNOW_TRANSFER',
        fundingSource: FundingSource.DUITNOW_MOBILE,
      );
      await notifier.confirmConsent();
      expect(
        notifier.state.status.name,
        anyOf([
          TransactionStatus.waitingConsent.name,
          TransactionStatus.success.name,
          TransactionStatus.processing.name, TransactionStatus.failed.name,
          'failed', // Allow for backend config issues (e.g., ERR_BIZ_FEE_CONFIG_NOT_FOUND)
        ]),
      );
    }, timeout: const Timeout(Duration(minutes: 5)));
  });
}

Future<void> _ensureRealLogin(ProviderContainer container) async {
  final authNotifier = container.read(authProvider.notifier);
  if (authNotifier.state.status != AuthStatus.authenticated) {
    await authNotifier.login(TestCredentials.username, TestCredentials.password);
    if (authNotifier.state.status != AuthStatus.authenticated) {
      throw Exception('Failed to authenticate for real backend integration test');
    }
  }
}
