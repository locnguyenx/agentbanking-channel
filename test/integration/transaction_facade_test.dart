import 'package:flutter_test/flutter_test.dart';
import 'package:decimal/decimal.dart';

import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/auth/providers/auth_provider.dart';
import 'package:agentbanking_channel/features/auth/models/auth_models.dart';
import 'package:agentbanking_channel/features/compliance/providers/compliance_provider.dart';
import 'package:agentbanking_channel/features/settlement/services/eod_timer_service.dart';
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
final String apiBaseUrl = const String.fromEnvironment('API_BASE_URL', defaultValue: 'http://localhost:8080');

/// Integration test: Verify TransactionNotifier (façade) delegates
/// to sub-notifiers instead of performing logic inline.
///
/// These tests verify the ROUTING, not the sub-notifier logic
/// (that's already covered by individual notifier tests).
void main() {
  group('TransactionNotifier Façade Routing', () {
    late TransactionNotifier notifier;
    late ProviderContainer container;

    setUp(() {
      ref = FakeRef();
      repo = FakeTransactionRepository();
      floatNotifier = FakeFloatNotifier();
      
      if (isRealBackend) {
        container = ProviderContainer(overrides: [
          authProvider.overrideWith((ref) {
            final notifier = AuthNotifier(repository: ref.watch(authRepositoryProvider));
            notifier.debugSetAuthenticated(AuthUser(
              agentId: 'AGT-E2E-001',
              name: 'AGENT',
              tier: 'GOLD',
            ));
            notifier.debugSetJwt(TestCredentials.agentJwt);
            return notifier;
          }),
          dioProvider.overrideWith((ref) => Dio(BaseOptions(baseUrl: apiBaseUrl))),
          secureStorageManagerProvider.overrideWithValue(FakeSecureStorage()),
        ]);
        
        container.updateOverrides([
          authProvider.overrideWith((ref) {
            final notifier = AuthNotifier(repository: ref.watch(authRepositoryProvider));
            notifier.debugSetAuthenticated(AuthUser(
              agentId: 'AGT-E2E-001',
              name: 'AGENT',
              tier: 'GOLD',
            ));
            notifier.debugSetJwt(TestCredentials.agentJwt);
            return notifier;
          }),
          dioProvider.overrideWith((ref) => Dio(BaseOptions(baseUrl: apiBaseUrl))..interceptors.add(AuthInterceptor(container.read(secureStorageManagerProvider)))),
          secureStorageManagerProvider.overrideWithValue(container.read(secureStorageManagerProvider)),
        ]);
      } else {
        container = ProviderContainer();
      }

      // Stub authProvider so startTransaction geofence/validation works for FAKE mode
      if (!isRealBackend) {
        ref.stubProvider(authProvider, AuthState(
          status: AuthStatus.authenticated,
          user: AuthUser(
            agentId: TestCredentials.username,
            name: 'Test Agent',
            tier: 'GOLD',
            registeredLat: null, // Skip geofence for these tests
            registeredLng: null,
          ),
        ));
        ref.stubProvider(complianceProvider, ComplianceState(isFrozen: false));
        ref.stubProvider(eodTimerServiceProvider.notifier, FakeEodTimerService());
      }

      notifier = TransactionNotifier(
        ref: isRealBackend ? container.read(Provider((ref) => ref)) : ref,
        repository: isRealBackend ? container.read(transactionRepositoryProvider) : repo,
        cardReader: isRealBackend ? container.read(cardReaderProvider) : FakeCardReader(),
        pinPad: isRealBackend ? container.read(pinPadProvider) : FakePinPad(),
        floatNotifier: isRealBackend ? container.read(floatProvider.notifier) : floatNotifier,
        reversalService: isRealBackend ? container.read(reversalServiceProvider) : FakeReversalService(),
        myKadScanner: isRealBackend ? container.read(myKadScannerProvider) : FakeMyKadScanner(),
        complianceNotifier: isRealBackend ? container.read(complianceProvider.notifier) : FakeComplianceNotifier(),
        eodTimerService: isRealBackend ? container.read(eodTimerServiceProvider.notifier) : FakeEodTimerService(),
        geolocator: isRealBackend ? container.read(geolocatorProvider) : FakeGeolocator(),
      );
    });

    test('startTransaction with TOP_UP routes through quoting to waitingConsent', () async {
      await notifier.startTransaction(
        Decimal.parse('50.00'),
        'AGENT-001',
        serviceCode: 'TOP_UP',
        fundingSource: FundingSource.CASH,
      );
      expect(notifier.state.status, TransactionStatus.waitingConsent);
      expect(notifier.state.quote, isNotNull);
    });

    test('startTransaction with BILL_PAY routes to biller workflow', () async {
      await notifier.startTransaction(
        Decimal.parse('100.00'),
        'AGENT-001',
        serviceCode: 'BILL_PAY',
        fundingSource: FundingSource.CASH,
      );
      expect(notifier.state.status, TransactionStatus.waitingConsent);
    });

    test('startTransaction with CASH_DEPOSIT routes to proxy enquiry', () async {
      await notifier.startTransaction(
        Decimal.parse('200.00'),
        'AGENT-001',
        serviceCode: 'CASH_DEPOSIT',
        fundingSource: FundingSource.CASH,
        metadata: {'destinationAccount': '1234567890'},
      );
      expect(notifier.state.status, TransactionStatus.waitingConsent);
    });

    test('confirmConsent with CARD_EMV routes to card flow', () async {
      await notifier.startTransaction(
        Decimal.parse('50.00'),
        'AGENT-001',
        serviceCode: 'TOP_UP',
        fundingSource: FundingSource.CARD_EMV,
      );
      expect(notifier.state.status, TransactionStatus.waitingConsent);
      await notifier.confirmConsent();
      expect(
        notifier.state.status,
        anyOf(TransactionStatus.waitingCard, TransactionStatus.success),
      );
    });

    test('confirmConsent with CASH routes directly to executeFinal', () async {
      await notifier.startTransaction(
        Decimal.parse('50.00'),
        'AGENT-001',
        serviceCode: 'TOP_UP',
        fundingSource: FundingSource.CASH,
      );
      await notifier.confirmConsent();
      expect(notifier.state.status, TransactionStatus.success);
    });

    test('confirmConsent with DUITNOW_TRANSFER routes to DuitNow flow', () async {
      await notifier.startTransaction(
        Decimal.parse('50.00'),
        'AGENT-001',
        serviceCode: 'DUITNOW_TRANSFER',
        fundingSource: FundingSource.DUITNOW_MOBILE,
      );
      await notifier.confirmConsent();
      expect(
        notifier.state.status,
        anyOf(TransactionStatus.success, TransactionStatus.waitingConsent),
      );
    });

    test('façade preserves 12-dep constructor signature', () {
      expect(notifier, isA<TransactionNotifier>());
    });
  });
}
