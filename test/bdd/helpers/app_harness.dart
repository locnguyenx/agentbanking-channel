/// BddAppHarness — builder-pattern replacement for pumpBddApp().
///
/// Usage:
/// ```dart
/// await BddAppHarness(tester)
///   .withAuth(authenticated: true)
///   .withFloat(balance: Decimal.fromInt(5000))
///   .withEod(clock: DateTime(2026, 1, 1, 23, 59, 59))
///   .build();
/// ```
///
/// Each `.with*()` adds only the Riverpod overrides needed.
/// Default behavior is "happy path" — authenticated, within geofence,
/// no compliance lock, standard float balance.
library;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:agent_api/agent_api.dart' as agent_api;
import 'package:agentbanking_channel/core/network/auth_interceptor.dart';

import 'package:agentbanking_channel/main.dart';
import 'package:agentbanking_channel/api/api_providers.dart';
import 'package:agentbanking_channel/features/settlement/repositories/float_repository.dart';
import 'package:agentbanking_channel/features/auth/models/auth_models.dart';
import 'package:agentbanking_channel/features/auth/providers/auth_provider.dart';
import 'package:agentbanking_channel/core/offline/offline_queue_service.dart';
import 'package:agentbanking_channel/core/network/dio_provider.dart';
import 'package:agentbanking_channel/core/network/retry_interceptor.dart';
import 'package:agentbanking_channel/core/network/gps_interceptor.dart';
import 'package:agentbanking_channel/core/network/idempotency_interceptor.dart';
import 'package:agentbanking_channel/core/settlement/settlement_service.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:agentbanking_channel/features/transactions/providers/duitnow_flow_notifier.dart';
import 'package:agentbanking_channel/features/transactions/providers/biller_flow_notifier.dart';
import 'package:agentbanking_channel/features/transactions/providers/card_flow_notifier.dart';
import 'package:agentbanking_channel/features/transactions/providers/proxy_deposit_notifier.dart';
import 'package:agentbanking_channel/features/settlement/providers/float_provider.dart';
import 'package:agentbanking_channel/features/kyc/providers/onboarding_provider.dart';
import 'package:agentbanking_channel/features/agent_onboarding/providers/agent_onboarding_provider.dart';
import 'package:agentbanking_channel/features/merchant/providers/merchant_provider.dart';
import 'package:agentbanking_channel/features/hardware/hardware_providers.dart';
import 'package:agentbanking_channel/features/transactions/services/reversal_service.dart';
import 'package:agentbanking_channel/features/settlement/services/eod_timer_service.dart';
import 'package:agentbanking_channel/features/kyc/providers/onboarding_provider.dart';
import 'package:agentbanking_channel/features/kyc/repositories/kyc_repository.dart';
import '../../setup/test_mocks.dart';
import 'package:agentbanking_channel/features/agent_onboarding/repositories/agent_onboarding_repository.dart';
import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';
import 'package:agentbanking_channel/features/hardware/hardware_interfaces.dart';
import 'package:agentbanking_channel/features/compliance/providers/compliance_provider.dart';
import 'package:agentbanking_channel/features/hardware/mock_hardware_impl.dart';

import 'package:agentbanking_channel/core/network/geolocator_provider.dart';

import '../../setup/test_credentials.dart';
import 'mock_factory.dart';

/// The current container for the active BDD scenario.
/// Exposed for step files that need to read/mutate providers.
ProviderContainer? bddContainerVar;

ProviderContainer get bddContainer {
  if (bddContainerVar == null) {
    throw Exception('bddContainer not initialized — call BddAppHarness.build() first');
  }
  return bddContainerVar!;
}

bool get isRealBackend => const bool.fromEnvironment('USE_REAL_BACKEND', defaultValue: false);

/// Builder-pattern harness for BDD tests.
///
/// Defaults to a happy-path authenticated agent within geofence,
/// with standard float, no compliance lock, and open EOD.
/// Each `.with*()` overrides only what the scenario needs.
class _RealHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final old = HttpOverrides.current;
    HttpOverrides.global = null;
    try {
      return HttpClient(context: context)
        ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    } finally {
      HttpOverrides.global = old;
    }
  }
}

class BddAppHarness {
  final WidgetTester tester;

  // Defaults — happy path
  bool _isAuthenticated = true;
  bool _complianceLocked = false;
  DateTime? _eodClock;

  // Fresh mocks per scenario
  late final MockAuthRepository _authRepo;
  late final MockSecureStorage _secureStorage;
  late final MockTransactionRepository _txnRepo;
  late final MockGeolocator _geolocator;

  BddAppHarness(this.tester, {
    MockAuthRepository? authRepo,
    MockSecureStorage? secureStorage,
    MockTransactionRepository? txnRepo,
    MockGeolocator? geolocator,
  }) {
    _authRepo = authRepo ?? createMockAuthRepo();
    _secureStorage = secureStorage ?? createMockSecureStorage();
    _txnRepo = txnRepo ?? createMockTransactionRepo();
    _geolocator = geolocator ?? createMockGeolocator();
  }

  // ─── Builder Methods ──────────────────────────────────────────────────

  BddAppHarness withAuth({bool authenticated = true, bool whitelisted = true}) {
    _isAuthenticated = authenticated;
    _authRepo.isDeviceWhitelisted = whitelisted;
    return this;
  }

  BddAppHarness withComplianceLock({bool locked = true}) {
    _complianceLocked = locked;
    return this;
  }

  BddAppHarness withEod({DateTime? clock}) {
    _eodClock = clock;
    return this;
  }

  BddAppHarness withGps({bool unavailable = false}) {
    _geolocator.shouldThrow = unavailable;
    return this;
  }

  BddAppHarness withTransactions({bool shouldFail = false}) {
    _txnRepo.shouldFail = shouldFail;
    return this;
  }

  /// Exposes the mock transaction repo for scenario-specific stubbing.
  MockTransactionRepository get transactionRepo => _txnRepo;

  /// Exposes the mock geolocator for scenario-specific stubbing.
  MockGeolocator get geolocator => _geolocator;

  /// Exposes the mock auth repo for scenario-specific stubbing.
  MockAuthRepository get authRepo => _authRepo;

  /// Exposes the mock secure storage for scenario-specific stubbing.
  MockSecureStorage get secureStorage => _secureStorage;

  // ─── Build ────────────────────────────────────────────────────────────

  Future<void> build() async {
    setupTestMocks();
    _authRepo.secureStorage = _secureStorage;
    
    if (isRealBackend) {
      HttpOverrides.global = _RealHttpOverrides();
    }
    
    // Set a standard logical size for POS/Tablet layout
    tester.view.physicalSize = const Size(1280, 1024);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());
    addTearDown(() => tester.view.resetDevicePixelRatio());
    
    // Only set if explicitly requested via with* methods or if we want happy path defaults
    // But don't overwrite if it's already there (to allow persistence tests)
    if (_secureStorage.jwt == null && _isAuthenticated && !isRealBackend) {
      _secureStorage.jwt = 'BDD_TEST_JWT';
    } else if (!_isAuthenticated) {
      _secureStorage.jwt = null;
    }

    if (_complianceLocked) {
      _secureStorage.complianceLocks['compliance_locked'] = true;
    }
    // If _complianceLocked is false, we DON'T explicitly set it to false in storage 
    // to allow persistence of a 'true' value from a previous step during "restart".

    print('BDD_DEBUG: build() starting. physicalSize=${tester.view.physicalSize}');
    
    late final ProviderContainer container;

    print('BDD_DEBUG: Creating ProviderContainer with overrides...');
    container = ProviderContainer(
      overrides: [
        // Auth
        if (!isRealBackend) ...[
          authRepositoryProvider.overrideWithValue(_authRepo),
          authProvider.overrideWith((ref) {
            final notifier = AuthNotifier(repository: _authRepo);
            if (_isAuthenticated) {
              notifier.debugSetAuthenticated(
                AuthUser(
                  agentId: TestCredentials.username,
                  name: 'BDD Tester', 
                  tier: 'MICRO',
                  registeredLat: 3.1390,
                  registeredLng: 101.6869,
                ),
              );
            }
            return notifier;
          }),
        ],
        geolocatorProvider.overrideWithValue(_geolocator),
        secureStorageManagerProvider.overrideWithValue(_secureStorage),
        complianceProvider.overrideWith((ref) {
          final secureStorage = ref.watch(secureStorageManagerProvider);
          return ComplianceNotifier(secureStorage: secureStorage);
        }),

        // Float
        floatRepositoryProvider.overrideWith((ref) {
          if (isRealBackend) {
            final ledgerApi = ref.watch(ledgerApiProvider);
            return FloatRepository(ledgerApi);
          }
          return FakeFloatRepository();
        }),
        floatProvider.overrideWith((ref) {
          if (isRealBackend) {
            final repo = ref.watch(floatRepositoryProvider);
            final authState = ref.watch(authProvider);
            return FloatNotifier(repo, authState.user?.agentId, startTimer: true);
          }
          // Use FakeFloatNotifier which has immediate state initialization
          return FakeFloatNotifier();
        }),

        // Network
        dioProvider.overrideWith((ref) {
          final baseUrl = const String.fromEnvironment('API_BASE_URL', defaultValue: 'http://localhost:8080');
          final dio = Dio(BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
          ));

          if (isRealBackend) {
            debugPrint('BDD_DEBUG: Forcing real HttpClient in AppHarness override');
            (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (client) {
              return HttpClient()..badCertificateCallback = (cert, host, port) => true;
            };
            
            dio.interceptors.addAll([
              InterceptorsWrapper(
                onRequest: (options, handler) {
                  debugPrint('DIO_RAW_DEBUG: onRequest to ${options.path}');
                  handler.next(options);
                },
              ),
              LogInterceptor(requestBody: true, responseBody: true, logPrint: (obj) => debugPrint('DIO_DEBUG: $obj')),
              AuthInterceptor(_secureStorage),
              RetryInterceptor(dio: dio),
              GpsInterceptor(geolocator: _geolocator),
            ]);
          } else {
            dio.interceptors.addAll([
              GpsInterceptor(geolocator: _geolocator),
              IdempotencyInterceptor(),
            ]);
          }
          return dio;
        }),

        authApiProvider.overrideWith((ref) {
          final dio = ref.watch(dioProvider);
          debugPrint('BDD_DEBUG: authApiProvider.overrideWith - creating API with dio: $dio');
          return agent_api.AuthControllerAuthIamServiceApi(dio, agent_api.standardSerializers);
        }),

        offlineQueueServiceProvider.overrideWithValue(MockOfflineQueueService()),

        // Transactions
        if (!isRealBackend) ...[
          transactionRepositoryProvider.overrideWith((ref) => _txnRepo),
        ],

        // EOD
        eodTimerServiceProvider.overrideWith(
          (ref) => EodTimerService(clockOverride: _eodClock),
        ),

        // KYC / Onboarding
        if (!isRealBackend) ...[
          kycRepositoryProvider.overrideWithValue(FakeKycRepository()),
          onboardingProvider.overrideWith((ref) => OnboardingNotifier(
            kycRepository: FakeKycRepository(),
            myKadScanner: MockMyKadScanner(),
          )),
          agentOnboardingRepositoryProvider.overrideWithValue(FakeAgentOnboardingRepository()),
          agentOnboardingProvider.overrideWith((ref) => AgentOnboardingNotifier(
            repository: ref.watch(agentOnboardingRepositoryProvider),
            myKadScanner: MockMyKadScanner(),
          )),
        ],

        // Transaction state machine
        transactionProvider.overrideWith((ref) => TransactionNotifier(
          ref: ref,
          repository: ref.watch(transactionRepositoryProvider),
          cardReader: MockCardReader(),
          pinPad: MockPinPad(),
          floatNotifier: ref.watch(floatProvider.notifier),
          reversalService: ref.watch(reversalServiceProvider),
          myKadScanner: MockMyKadScanner(),
          complianceNotifier: ref.watch(complianceProvider.notifier),
          eodTimerService: ref.watch(eodTimerServiceProvider.notifier),
          geolocator: _geolocator,
          pollingInterval: Duration.zero,
          cardTimerDelay: Duration.zero,
        )),
        duitNowFlowNotifierProvider.overrideWith((ref) => DuitNowFlowNotifier(
          ref: ref,
          repository: ref.watch(transactionRepositoryProvider),
          floatNotifier: ref.watch(floatProvider.notifier),
          reversalService: ref.watch(reversalServiceProvider),
          pollingInterval: Duration.zero,
        )),
        billerFlowNotifierProvider.overrideWith((ref) => BillerFlowNotifier(
          ref: ref,
          repository: ref.watch(transactionRepositoryProvider),
          floatNotifier: ref.watch(floatProvider.notifier),
          geolocator: _geolocator,
          pollingInterval: Duration.zero,
        )),
        cardFlowNotifierProvider.overrideWith((ref) => CardFlowNotifier(
          ref: ref,
          cardReader: MockCardReader(),
          pinPad: MockPinPad(),
          repository: ref.watch(transactionRepositoryProvider),
          floatNotifier: ref.watch(floatProvider.notifier),
          reversalService: ref.watch(reversalServiceProvider),
          cardTimerDelay: Duration.zero,
        )),
        proxyDepositNotifierProvider.overrideWith((ref) => ProxyDepositNotifier(
          ref: ref,
          repository: ref.watch(transactionRepositoryProvider),
          myKadScanner: MockMyKadScanner(),
          geolocator: _geolocator,
          pollingInterval: Duration.zero,
        )),
        settlementStatusProvider.overrideWith(
          (ref) => SettlementNotifier(startMonitor: false),
        ),
        merchantProvider.overrideWith((ref) => MerchantNotifier(
          ref: ref,
          repository: ref.watch(transactionRepositoryProvider),
          cardReader: MockCardReader(),
          pinPad: MockPinPad(),
          merchantTerminal: MockMerchantTerminal(),
          floatNotifier: ref.watch(floatProvider.notifier),
          complianceNotifier: ref.watch(complianceProvider.notifier),
          agentId: 'AGENT-001',
          pollingInterval: Duration.zero,
        )),
      ],
    );

    print('BDD_DEBUG: ProviderContainer created.');
    bddContainerVar = container;
    await container.read(complianceProvider.notifier).init();

    if (_complianceLocked) {
      container.read(complianceProvider.notifier).freeze('BDD_PERSISTED_LOCK');
    }

    addTearDown(() async {
      if (isRealBackend) {
        HttpOverrides.global = null;
      }
      // 1. Dispose the container explicitly to halt all timers in notifiers
      container.dispose();
      bddContainerVar = null;

      // 2. Unmount the widget tree
      await tester.pumpWidget(const SizedBox());
      
      // 3. Flush microtasks only, NO clock advancement to avoid re-triggering timers
      await tester.pump();

      debugPrint('AppHarness Teardown Complete');
    });

    print('BDD_DEBUG: Calling pumpWidget...');
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const AgentBankingApp(),
      ),
    );
    print('BDD_DEBUG: pumpWidget finished.');
    await tester.pump();
  }
}
