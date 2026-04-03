import 'package:flutter_test/flutter_test.dart';

import 'package:agentbanking_channel/features/transactions/providers/biller_flow_notifier.dart';
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
  late FakeFloatNotifier fakeFloat;
  late FakeRef fakeRef;
  late FakeGeolocator fakeGeolocator;

  setUp(() {
    fakeRepo = FakeTransactionRepository();
    fakeFloat = FakeFloatNotifier();
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

  TransactionState billerState() => TransactionState(
    status: TransactionStatus.quoting,
    amount: Decimal.fromInt(50),
    serviceCode: 'BILL_PAYMENT',
    fundingSource: FundingSource.CASH,
    metadata: {'billerCode': 'BILLER001', 'ref1': 'REF001'},
    idempotencyKey: 'KEY-BILLER-001',
  );

  BillerFlowNotifier createNotifier() {
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
