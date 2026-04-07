import 'package:flutter_test/flutter_test.dart';

import 'package:agentbanking_channel/features/transactions/providers/proxy_deposit_notifier.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/auth/providers/auth_provider.dart';
import 'package:agentbanking_channel/features/auth/models/auth_models.dart';
import 'package:agentbanking_channel/features/compliance/providers/compliance_provider.dart';
import 'package:agentbanking_channel/features/settlement/services/eod_timer_service.dart';
import 'package:decimal/decimal.dart';

import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';
import 'package:agentbanking_channel/core/network/geolocator_provider.dart';
import 'package:agentbanking_channel/features/hardware/hardware_interfaces.dart';
import 'package:agentbanking_channel/features/hardware/hardware_providers.dart';
import 'package:agentbanking_channel/core/network/dio_provider.dart';
import 'package:agentbanking_channel/core/network/auth_interceptor.dart';
import 'package:agentbanking_channel/core/offline/offline_queue_service.dart';
import 'package:agentbanking_channel/core/security/secure_storage_manager.dart';
import 'package:dio/dio.dart';

import 'test_fakes.dart';
import '../setup/test_credentials.dart';

final bool isRealBackend = const bool.fromEnvironment('USE_REAL_BACKEND', defaultValue: false);

void main() {
  late FakeTransactionRepository fakeRepo;
  late FakeMyKadScanner fakeMyKadScanner;
  late FakeRef fakeRef;
  late FakeGeolocator fakeGeolocator;
  late ProviderContainer container;

  setUp(() {
    fakeRepo = FakeTransactionRepository();
    fakeMyKadScanner = FakeMyKadScanner();
    fakeRef = FakeRef();
    fakeGeolocator = FakeGeolocator();
    container = ProviderContainer();

    // Stub mandatory providers for TransactionGuardMixin
    final authNotifier = FakeAuthNotifier(user: AuthUser(agentId: 'AGENT-123', name: 'AHMAD', tier: 'PLATINUM'));
    final complianceNotifier = FakeComplianceNotifier(frozen: false);
    fakeRef.stubProvider(complianceProvider, complianceNotifier.state);
    fakeRef.stubProvider(complianceProvider.notifier, complianceNotifier);
    fakeRef.stubProvider(eodTimerServiceProvider.notifier, FakeEodTimerService(locked: false));
    fakeRef.stubProvider(authProvider, authNotifier.state);
    fakeRef.stubProvider(authProvider.notifier, authNotifier);
  });

  TransactionState depositState({Decimal? amount}) => TransactionState(
    status: TransactionStatus.quoting,
    amount: amount ?? Decimal.fromInt(500),
    serviceCode: 'CASH_DEPOSIT',
    fundingSource: FundingSource.CASH,
    metadata: {'destinationAccount': '1234567890'},
    idempotencyKey: 'KEY-DEP-001',
  );

  ProxyDepositNotifier createNotifier() {
    final container = ProviderContainer(overrides: [
      authProvider.overrideWith((ref) {
        final notifier = AuthNotifier(repository: ref.watch(authRepositoryProvider));
        if (isRealBackend) {
           notifier.debugSetAuthenticated(AuthUser(agentId: 'AGT-E2E-001', name: 'AGENT', tier: 'GOLD'));
           notifier.debugSetJwt(TestCredentials.agentJwt);
        }
        return notifier;
      }),
      dioProvider.overrideWith((ref) => Dio(BaseOptions(baseUrl: apiBaseUrl))),
      secureStorageManagerProvider.overrideWithValue(FakeSecureStorage()),
    ]);

    if (isRealBackend) {
      container.updateOverrides([
        authProvider.overrideWith((ref) {
          final notifier = AuthNotifier(repository: ref.watch(authRepositoryProvider));
          if (isRealBackend) {
             notifier.debugSetAuthenticated(AuthUser(agentId: 'AGT-E2E-001', name: 'AGENT', tier: 'GOLD'));
             notifier.debugSetJwt(TestCredentials.agentJwt);
          }
          return notifier;
        }),
        dioProvider.overrideWith((ref) => Dio(BaseOptions(baseUrl: apiBaseUrl))..interceptors.add(AuthInterceptor(container.read(secureStorageManagerProvider)))),
        secureStorageManagerProvider.overrideWithValue(container.read(secureStorageManagerProvider)),
      ]);
    }

    return ProxyDepositNotifier(
      ref: isRealBackend ? container.read(Provider((ref) => ref)) : fakeRef,
      repository: isRealBackend ? container.read(transactionRepositoryProvider) : fakeRepo,
      myKadScanner: isRealBackend ? container.read(myKadScannerProvider) : fakeMyKadScanner,
      geolocator: isRealBackend ? container.read(geolocatorProvider) : fakeGeolocator,
    );
  }

  group('ProxyDepositNotifier - ProxyEnquiry Happy Path', () {
    test('successful lookup → waitingConsent with customer name', () async {
      final notifier = createNotifier();
      final state = depositState();

      await notifier.executeProxyEnquiry(
        amount: state.amount!,
        merchantId: 'AGENT-123',
        fundingSource: FundingSource.CASH,
        metadata: state.metadata?.cast<String, String>(),
      );

      expect(notifier.state.status, TransactionStatus.waitingConsent);
      expect(notifier.state.metadata?['customerName'], 'AHMAD BIN ABDULLAH');
      expect(notifier.state.quote, isNotNull);
      expect(notifier.state.quote!.quoteId, startsWith('PQ_'));
      notifier.dispose();
    });
  });

  group('ProxyDepositNotifier - ProxyEnquiry Retry', () {
    test('fails first 2 attempts, succeeds on 3rd → waitingConsent', () async {
      fakeRepo.shouldFailProxyEnquiry = true;
      fakeRepo.proxyEnquiryFailUntilAttempt = 2;

      final notifier = createNotifier();
      final state = depositState();
      await notifier.executeProxyEnquiry(
        amount: state.amount!,
        merchantId: 'AGENT-123',
        fundingSource: FundingSource.CASH,
        metadata: state.metadata?.cast<String, String>(),
      );

      expect(notifier.state.status, TransactionStatus.waitingConsent);
      expect(fakeRepo.proxyEnquiryCallCount, 3);
      notifier.dispose();
    });

    test('fails all 4 attempts → failed', () async {
      fakeRepo.shouldFailProxyEnquiry = true;
      fakeRepo.proxyEnquiryFailUntilAttempt = 10; // fail all

      final notifier = createNotifier();
      final state = depositState();
      await notifier.executeProxyEnquiry(
        amount: state.amount!,
        merchantId: 'AGENT-123',
        fundingSource: FundingSource.CASH,
        metadata: state.metadata?.cast<String, String>(),
      );

      expect(notifier.state.status, TransactionStatus.failed);
      expect(fakeRepo.proxyEnquiryCallCount, 3);
      notifier.dispose();
    });
  });


  group('ProxyDepositNotifier - Reset', () {
    test('reset returns to idle', () async {
      final notifier = createNotifier();
      notifier.debugSetState(depositState().copyWith(status: TransactionStatus.success));

      notifier.reset();

      expect(notifier.state.status, TransactionStatus.idle);
      notifier.dispose();
    });
  });
}

extension DebugProxyDepositNotifier on ProxyDepositNotifier {
  void debugSetState(TransactionState newState) {
    // ignore: invalid_use_of_protected_member
    state = newState;
  }
}
