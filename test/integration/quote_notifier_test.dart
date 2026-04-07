import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:agentbanking_channel/features/transactions/providers/quote_notifier.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/auth/providers/auth_provider.dart';
import 'package:agentbanking_channel/features/auth/models/auth_models.dart';
import 'package:agentbanking_channel/features/compliance/providers/compliance_provider.dart';
import 'package:agentbanking_channel/features/settlement/services/eod_timer_service.dart';
import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';
import 'package:agentbanking_channel/core/network/geolocator_provider.dart';
import 'package:agentbanking_channel/core/network/dio_provider.dart';
import 'package:agentbanking_channel/core/offline/offline_queue_service.dart';
import 'package:agentbanking_channel/core/security/secure_storage_manager.dart';
import 'package:dio/dio.dart';
import 'package:agentbanking_channel/core/network/auth_interceptor.dart';

import 'test_fakes.dart';
import 'quote_notifier_test_helpers.dart';
import '../setup/test_credentials.dart';

final bool isRealBackend = const bool.fromEnvironment('USE_REAL_BACKEND', defaultValue: false);
final String apiBaseUrl = const String.fromEnvironment('API_BASE_URL', defaultValue: 'http://localhost:8080');

void main() {
  late FakeTransactionRepository fakeRepo;
  late FakeGeolocator fakeGeolocator;
  late FakeSecureStorage _sharedStorage;

  setUp(() {
    fakeRepo = FakeTransactionRepository();
    fakeGeolocator = FakeGeolocator();
    _sharedStorage = FakeSecureStorage();
  });

  /// Creates a QuoteNotifier wired to a minimal ProviderContainer.
  /// Override compliance/eod/auth as needed via parameters.
  Future<AuthUser?> _ensureRealLogin(ProviderContainer container) async {
    if (!isRealBackend) return null;
    try {
      final repo = container.read(authRepositoryProvider);
      final user = await repo.login(TestCredentials.username, TestCredentials.password);
      final token = await _sharedStorage.readJwt();
      print('DEBUG: Real login successful for ${user.agentId}, token: ${token?.substring(0, 10)}...');
      return user;
    } catch (e) {
      print('DEBUG: Real login failed: $e');
      return null;
    }
  }

  QuoteNotifier createNotifier({
    bool complianceFrozen = false,
    bool eodLocked = false,
    AuthUser? authUser,
  }) {
    // 1. Create a Dio instance with the interceptor using OUR shared storage
    final dio = Dio(BaseOptions(baseUrl: apiBaseUrl));
    dio.interceptors.add(AuthInterceptor(_sharedStorage));
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      requestHeader: true,
      logPrint: (obj) => print('DIO_DEBUG: $obj'),
    ));

    final container = ProviderContainer(overrides: [
      complianceProvider.overrideWith((ref) =>
        ComplianceNotifier()..debugSetFrozen(complianceFrozen)),
      eodTimerServiceProvider.overrideWith((ref) =>
        FakeEodTimerService(locked: eodLocked)),
      
      // Override the core building blocks
      secureStorageManagerProvider.overrideWithValue(_sharedStorage),
      dioProvider.overrideWithValue(dio),

      authProvider.overrideWith((ref) {
        final notifier = AuthNotifier(repository: ref.watch(authRepositoryProvider));
        if (authUser != null) {
           notifier.debugSetAuthenticated(authUser);
        } else if (isRealBackend) {
           notifier.debugSetAuthenticated(AuthUser(agentId: TestCredentials.username, name: 'AGENT', tier: 'GOLD'));
        }
        return notifier;
      }),
    ]);
    
    return QuoteNotifier(
      ref: container.read(Provider((ref) => ref)),
      repository: isRealBackend ? container.read(transactionRepositoryProvider) : fakeRepo,
      geolocator: isRealBackend ? container.read(geolocatorProvider) : fakeGeolocator,
    );
  }

  group('QuoteNotifier - Happy Path', () {
    test('valid amount → quoting → waitingConsent', () async {
      final notifier = createNotifier();
      final user = await _ensureRealLogin(notifier.ref.read(Provider((ref) => ref.container)));
      final effectiveAgentId = user != null ? user.agentId : TestCredentials.username;

      await notifier.startQuote(
        Decimal.fromInt(100), effectiveAgentId,
        serviceCode: 'CASH_WITHDRAWAL',
        fundingSource: FundingSource.CARD_EMV,
      );

      expect(notifier.state.status, TransactionStatus.waitingConsent);
      expect(notifier.state.quote, isNotNull);
      expect(notifier.state.quote?.quoteId, 'FAKE_QUOTE_001');
      expect(notifier.state.idempotencyKey, isNotEmpty);
      notifier.dispose();
    });
  });

  group('QuoteNotifier - Amount Validation', () {
    test('amount > RM 5,000 → failed with ERR_VAL_AMOUNT_EXCEEDS_LIMIT', () async {
      final notifier = createNotifier();

      await notifier.startQuote(
        Decimal.fromInt(5001), 'MERCHANT_001',
        serviceCode: 'CASH_WITHDRAWAL',
        fundingSource: FundingSource.CARD_EMV,
      );

      expect(notifier.state.status, TransactionStatus.failed);
      expect(notifier.state.error, contains('ERR_VAL_AMOUNT_EXCEEDS_LIMIT'));
      notifier.dispose();
    });

    test('RM 3,000 exactly for Card → passes validation', () async {
      final notifier = createNotifier();
      await _ensureRealLogin(notifier.ref.read(Provider((ref) => ref.container)));

      await notifier.startQuote(
        Decimal.fromInt(3000), TestCredentials.username,
        serviceCode: 'CASH_WITHDRAWAL',
        fundingSource: FundingSource.CARD_EMV,
      );

      expect(notifier.state.status, TransactionStatus.waitingConsent);
      notifier.dispose();
    });

    test('cash > RM 3,000 → waitingMyKadScan (STP threshold)', () async {
      final notifier = createNotifier();

      await notifier.startQuote(
        Decimal.fromInt(3500), TestCredentials.username,
        serviceCode: 'CASH_DEPOSIT',
        fundingSource: FundingSource.CASH,
      );

      expect(notifier.state.status, TransactionStatus.waitingMyKadScan);
      // No error should be present for valid STP interrupt
      expect(notifier.state.error, isNull);
      notifier.dispose();
    });

    test('cash RM 3,000 exactly → triggers MyKad Scan (STP threshold)', () async {
      final notifier = createNotifier();

      await notifier.startQuote(
        Decimal.fromInt(3000), TestCredentials.username,
        serviceCode: 'CASH_DEPOSIT',
        fundingSource: FundingSource.CASH,
      );

      expect(notifier.state.status, TransactionStatus.waitingMyKadScan);
      notifier.dispose();
    });

    test('cash RM 2,999 → passes (no MyKad needed)', () async {
      final notifier = createNotifier();
      await _ensureRealLogin(notifier.ref.read(Provider((ref) => ref.container)));

      await notifier.startQuote(
        Decimal.fromInt(2999), TestCredentials.username,
        serviceCode: 'CASH_DEPOSIT',
        fundingSource: FundingSource.CASH,
      );

      expect(notifier.state.status, TransactionStatus.waitingConsent);
      notifier.dispose();
    });
  });

  group('QuoteNotifier - Guard Checks', () {
    test('compliance frozen → failed with ERR_COMPLIANCE_FROZEN', () async {
      final notifier = createNotifier(complianceFrozen: true);

      await notifier.startQuote(
        Decimal.fromInt(100), TestCredentials.username,
        serviceCode: 'CASH_WITHDRAWAL',
        fundingSource: FundingSource.CARD_EMV,
      );

      expect(notifier.state.status, TransactionStatus.failed);
      expect(notifier.state.error, 'ERR_COMPLIANCE_FROZEN');
      notifier.dispose();
    });

    test('EOD locked → failed with ERR_EOD_LOCKED', () async {
      final notifier = createNotifier(eodLocked: true);

      await notifier.startQuote(
        Decimal.fromInt(100), TestCredentials.username,
        serviceCode: 'CASH_WITHDRAWAL',
        fundingSource: FundingSource.CARD_EMV,
      );

      expect(notifier.state.status, TransactionStatus.failed);
      expect(notifier.state.error, 'ERR_EOD_LOCKED');
      notifier.dispose();
    });
  });

  group('QuoteNotifier - Phone Validation', () {
    test('invalid phone for TOP_UP → ERR_VAL_INVALID_PHONE_FORMAT', () async {
      final notifier = createNotifier();

      await notifier.startQuote(
        Decimal.fromInt(50), TestCredentials.username,
        serviceCode: 'TOP_UP',
        fundingSource: FundingSource.CASH,
        metadata: {'mobileNumber': '01234'}, // too short
      );

      expect(notifier.state.status, TransactionStatus.failed);
      expect(notifier.state.error, 'ERR_VAL_INVALID_PHONE_FORMAT');
      notifier.dispose();
    });

    test('valid phone for TOP_UP → passes', () async {
      final notifier = createNotifier();
      await _ensureRealLogin(notifier.ref.read(Provider((ref) => ref.container)));

      await notifier.startQuote(
        Decimal.fromInt(50), TestCredentials.username,
        serviceCode: 'TOP_UP',
        fundingSource: FundingSource.CASH,
        metadata: {'mobileNumber': '0123456789'},
      );

      expect(notifier.state.status, TransactionStatus.waitingConsent);
      notifier.dispose();
    });
  });

  group('QuoteNotifier - Backend Failure', () {
    test('repository throws → failed', () async {
      fakeRepo.shouldFailQuote = true;
      final notifier = createNotifier();
      await _ensureRealLogin(notifier.ref.read(Provider((ref) => ref.container)));

      await notifier.startQuote(
        Decimal.fromInt(100), TestCredentials.username,
        serviceCode: 'CASH_WITHDRAWAL',
        fundingSource: FundingSource.CARD_EMV,
      );

      expect(notifier.state.status, TransactionStatus.failed);
      expect(notifier.state.error, anyOf(contains('Quote failed'), contains('401')));
      notifier.dispose();
    });
  });

  group('QuoteNotifier - Reset', () {
    test('reset returns to idle', () {
      final notifier = createNotifier();
      notifier.reset();
      expect(notifier.state.status, TransactionStatus.idle);
      notifier.dispose();
    });
  });
}
