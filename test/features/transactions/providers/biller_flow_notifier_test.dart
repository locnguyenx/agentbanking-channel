import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:agentbanking_channel/features/transactions/providers/biller_flow_notifier.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/auth/providers/auth_provider.dart';
import 'package:agentbanking_channel/features/auth/models/auth_models.dart';
import 'package:agentbanking_channel/features/compliance/providers/compliance_provider.dart';
import 'package:agentbanking_channel/features/settlement/services/eod_timer_service.dart';
import 'package:decimal/decimal.dart';

import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';
import 'package:agentbanking_channel/core/network/dio_provider.dart';
import 'package:agentbanking_channel/core/network/geolocator_provider.dart';
import 'package:agentbanking_channel/core/network/auth_interceptor.dart';
import 'package:agentbanking_channel/core/offline/offline_queue_service.dart';
import 'package:agentbanking_channel/core/security/secure_storage_manager.dart';
import 'package:agentbanking_channel/features/settlement/providers/float_provider.dart';
import 'package:dio/dio.dart';

import 'test_fakes.dart';
import '../../../setup/test_credentials.dart';

const apiBaseUrl = String.fromEnvironment('API_BASE_URL', defaultValue: 'http://localhost:8080');


void main() {
  late FakeTransactionRepository fakeRepo;
  late FakeFloatNotifier fakeFloat;
  late FakeRef fakeRef;
  late FakeGeolocator fakeGeolocator;
  late ProviderContainer container;
  late FakeSecureStorage _sharedStorage;

  setUp(() {
    fakeRepo = FakeTransactionRepository();
    fakeFloat = FakeFloatNotifier();
    fakeRef = FakeRef();
    fakeGeolocator = FakeGeolocator();
    _sharedStorage = FakeSecureStorage();

    // Stub mandatory providers
    final authNotifier = FakeAuthNotifier(user: AuthUser(agentId: 'AGENT-123', name: 'AHMAD', tier: 'PLATINUM'));
    final complianceNotifier = FakeComplianceNotifier(frozen: false);
    fakeRef.stubProvider(complianceProvider, complianceNotifier.state);
    fakeRef.stubProvider(complianceProvider.notifier, complianceNotifier);
    fakeRef.stubProvider(eodTimerServiceProvider.notifier, FakeEodTimerService(locked: false));
    fakeRef.stubProvider(authProvider, authNotifier.state);
    fakeRef.stubProvider(authProvider.notifier, authNotifier);

    container = ProviderContainer(overrides: [
      secureStorageManagerProvider.overrideWithValue(_sharedStorage),
      authProvider.overrideWith((ref) => AuthNotifier(repository: ref.watch(authRepositoryProvider))),
    ]);
  });

  tearDown(() {
    container.dispose();
  });

  void _dummy() {}

  TransactionState quotedState() => TransactionState(
    status: TransactionStatus.waitingConsent,
    quote: TransactionQuoteResponse(
      quoteId: 'Q001', amount: Decimal.fromInt(100),
      fee: Decimal.fromInt(1), commission: Decimal.parse('0.50'),
      total: Decimal.fromInt(101),
    ),
    amount: Decimal.fromInt(100),
    serviceCode: 'UTILITY_BILL',
    fundingSource: FundingSource.CASH,
    idempotencyKey: 'KEY-BILL-001',
    metadata: {'billerCode': 'TNB001', 'accountNumber': '123456789'},
  );

  TransactionState billerState() => TransactionState(
    status: TransactionStatus.quoting,
    amount: Decimal.fromInt(50),
    serviceCode: 'BILL_PAYMENT',
    fundingSource: FundingSource.CASH,
    metadata: {'billerCode': 'BILLER001', 'ref1': 'REF001'},
    idempotencyKey: 'KEY-BILLER-001',
  );

  BillerFlowNotifier createNotifier() {
    // Pure unit test

    final container = ProviderContainer(overrides: [
      secureStorageManagerProvider.overrideWithValue(_sharedStorage),
      authProvider.overrideWith((ref) => AuthNotifier(repository: ref.watch(authRepositoryProvider))),
    ]);

    return BillerFlowNotifier(
      ref: fakeRef,
      repository: fakeRepo,
      floatNotifier: fakeFloat,
      geolocator: fakeGeolocator,
    );
  }

  group('BillerFlowNotifier - Quote Workflow', () {
    test('executeBillerWorkflow: processing → waitingConsent', () async {
      final notifier = createNotifier();
      final state = billerState();

      await notifier.executeBillerWorkflow(
        amount: state.amount!,
        merchantId: 'AGENT-123',
        serviceCode: state.serviceCode!,
        fundingSource: state.fundingSource!,
        metadata: state.metadata?.cast<String, String>(),
      );

      expect(notifier.state.status, TransactionStatus.waitingConsent);
      expect(notifier.state.quote, isNotNull);
      expect(notifier.state.quote?.quoteId, 'FAKE_QUOTE_001');
      notifier.dispose();
    });

    test('executeBillerWorkflow: quote fails → failed', () async {
      fakeRepo.shouldFailQuote = true;
      final notifier = createNotifier();
      final state = billerState();

      await notifier.executeBillerWorkflow(
        amount: state.amount!,
        merchantId: 'AGENT-123',
        serviceCode: state.serviceCode!,
        fundingSource: state.fundingSource!,
        metadata: state.metadata?.cast<String, String>(),
      );

      expect(notifier.state.status, TransactionStatus.failed);
      expect(notifier.state.error, contains('Quote failed'));
      notifier.dispose();
    });
  });

  group('BillerFlowNotifier - Utility Payment', () {
    test('happy path: initiate → poll → success', () async {
      final notifier = createNotifier();
      // Pure unit test

      await notifier.executeBillerPayment(quotedState());
      notifier.debugSetState(notifier.state.copyWith(status: TransactionStatus.processing));

      fakeFloat.resetFetchCount();
      await notifier.startBillerPolling('TXN_001');

      expect(notifier.state.status, TransactionStatus.success);
      notifier.dispose();
    });
  });

  group('BillerFlowNotifier - Polling', () {
    test('polling returns SUCCESS on first poll → success', () async {
      final notifier = createNotifier();
      notifier.debugSetState(billerState().copyWith(status: TransactionStatus.processing));

      fakeFloat.resetFetchCount();
      await notifier.startBillerPolling('TXN_001');

      expect(notifier.state.status, TransactionStatus.success);
      expect(fakeFloat.fetchCallCount, 1);
      notifier.dispose();
    });

    test('polling returns FAILED → failed', () async {
      fakeRepo.billerStatusToReturn = 'FAILED';
      final notifier = createNotifier();
      notifier.debugSetState(billerState().copyWith(status: TransactionStatus.processing));

      await notifier.startBillerPolling('TXN_001');

      expect(notifier.state.status, TransactionStatus.failed);
      expect(notifier.state.error, 'BILLER_FAILED');
      notifier.dispose();
    });

    test('polling stays PENDING for all iterations → TIMEOUT', () async {
      fakeRepo.billerStatusToReturn = 'PENDING';
      final notifier = createNotifier();
      notifier.debugSetState(billerState().copyWith(status: TransactionStatus.processing));

      await notifier.startBillerPolling('TXN_001');

      expect(notifier.state.status, TransactionStatus.failed);
      expect(notifier.state.error, 'TIMEOUT');
      notifier.dispose();
    });
  });

  group('BillerFlowNotifier - JomPay', () {
    test('JomPay workflow follows same biller path', () async {
      final notifier = createNotifier();
      final jomPayState = billerState().copyWith(serviceCode: 'JOMPAY');

      await notifier.executeBillerWorkflow(
        amount: jomPayState.amount!,
        merchantId: 'AGENT-123',
        serviceCode: jomPayState.serviceCode!,
        fundingSource: jomPayState.fundingSource!,
        metadata: jomPayState.metadata?.cast<String, String>(),
      );

      expect(notifier.state.status, TransactionStatus.waitingConsent);
      notifier.dispose();
    });
  });

  group('BillerFlowNotifier - Reset', () {
    test('reset returns to idle', () async {
      final notifier = createNotifier();
      notifier.debugSetState(billerState().copyWith(status: TransactionStatus.success));

      notifier.reset();

      expect(notifier.state.status, TransactionStatus.idle);
      notifier.dispose();
    });
  });
}

extension DebugBillerFlowNotifier on BillerFlowNotifier {
  void debugSetState(TransactionState newState) {
    // ignore: invalid_use_of_protected_member
    state = newState;
  }
}
