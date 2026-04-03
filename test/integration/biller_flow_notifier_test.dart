import 'package:flutter_test/flutter_test.dart';

import 'package:agentbanking_channel/features/transactions/providers/biller_flow_notifier.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';

import 'test_fakes.dart';

void main() {
  late FakeTransactionRepository fakeRepo;
  late FakeFloatNotifier fakeFloat;

  setUp(() {
    fakeRepo = FakeTransactionRepository();
    fakeFloat = FakeFloatNotifier();
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
      repository: fakeRepo,
      floatNotifier: fakeFloat,
    );
  }

  group('BillerFlowNotifier - Quote Workflow', () {
    test('executeBillerWorkflow: processing → waitingConsent', () async {
      final notifier = createNotifier();

      await notifier.executeBillerWorkflow(billerState());

      expect(notifier.state.status, TransactionStatus.waitingConsent);
      expect(notifier.state.quote, isNotNull);
      expect(notifier.state.quote?.quoteId, 'FAKE_QUOTE_001');
      notifier.dispose();
    });

    test('executeBillerWorkflow: quote fails → failed', () async {
      fakeRepo.shouldFailQuote = true;
      final notifier = createNotifier();

      await notifier.executeBillerWorkflow(billerState());

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

      await notifier.executeBillerWorkflow(jomPayState);

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
