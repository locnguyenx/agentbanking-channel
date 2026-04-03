import 'package:flutter_test/flutter_test.dart';

import 'package:agentbanking_channel/features/transactions/providers/proxy_deposit_notifier.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/auth/providers/auth_provider.dart';
import 'package:agentbanking_channel/features/auth/models/auth_models.dart';
import 'package:agentbanking_channel/features/compliance/providers/compliance_provider.dart';
import 'package:agentbanking_channel/features/settlement/services/eod_timer_service.dart';
import 'package:decimal/decimal.dart';

import 'test_fakes.dart';

void main() {
  late FakeTransactionRepository fakeRepo;
  late FakeMyKadScanner fakeMyKadScanner;
  late FakeRef fakeRef;
  late FakeGeolocator fakeGeolocator;

  setUp(() {
    fakeRepo = FakeTransactionRepository();
    fakeMyKadScanner = FakeMyKadScanner();
    fakeRef = FakeRef();
    fakeGeolocator = FakeGeolocator();

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
    return ProxyDepositNotifier(
      ref: fakeRef,
      repository: fakeRepo,
      myKadScanner: fakeMyKadScanner,
      geolocator: fakeGeolocator,
    );
  }

  group('ProxyDepositNotifier - ProxyEnquiry Happy Path', () {
    test('successful lookup → waitingConsent with customer name', () async {
      final notifier = createNotifier();
      final state = depositState();

      await notifier.executeProxyEnquiry(
        amount: state.amount!,
        merchantId: 'AGENT-123',
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
