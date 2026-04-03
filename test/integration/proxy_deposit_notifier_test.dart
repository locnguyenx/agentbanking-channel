import 'package:flutter_test/flutter_test.dart';

import 'package:agentbanking_channel/features/transactions/providers/proxy_deposit_notifier.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';

import 'test_fakes.dart';

void main() {
  late FakeTransactionRepository fakeRepo;
  late FakeMyKadScanner fakeMyKadScanner;

  setUp(() {
    fakeRepo = FakeTransactionRepository();
    fakeMyKadScanner = FakeMyKadScanner();
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
      repository: fakeRepo,
      myKadScanner: fakeMyKadScanner,
    );
  }

  group('ProxyDepositNotifier - ProxyEnquiry Happy Path', () {
    test('successful lookup → waitingConsent with customer name', () async {
      final notifier = createNotifier();

      await notifier.executeProxyEnquiry(depositState());

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
      await notifier.executeProxyEnquiry(depositState());

      expect(notifier.state.status, TransactionStatus.waitingConsent);
      expect(fakeRepo.proxyEnquiryCallCount, 3);
      notifier.dispose();
    });

    test('fails all 4 attempts → failed', () async {
      fakeRepo.shouldFailProxyEnquiry = true;
      fakeRepo.proxyEnquiryFailUntilAttempt = 10; // fail all

      final notifier = createNotifier();
      await notifier.executeProxyEnquiry(depositState());

      expect(notifier.state.status, TransactionStatus.failed);
      expect(fakeRepo.proxyEnquiryCallCount, 4);
      notifier.dispose();
    });
  });

  group('ProxyDepositNotifier - MyKad Scan', () {
    test('successful scan → waitingConsent with IC data', () async {
      final notifier = createNotifier();
      // Set initial state as if waiting for MyKad
      notifier.debugSetState(depositState(amount: Decimal.fromInt(3500))
        .copyWith(status: TransactionStatus.waitingMyKadScan));

      await notifier.processMyKadScan();

      expect(notifier.state.status, TransactionStatus.waitingConsent);
      expect(notifier.state.metadata?['myKadIcNumber'], '850101-01-5678');
      expect(notifier.state.metadata?['myKadFullName'], 'AHMAD BIN ABDULLAH');
      notifier.dispose();
    });

    test('scan cancelled → failed', () async {
      fakeMyKadScanner.shouldFail = true;
      final notifier = createNotifier();
      notifier.debugSetState(depositState().copyWith(status: TransactionStatus.waitingMyKadScan));

      await notifier.processMyKadScan();

      expect(notifier.state.status, TransactionStatus.failed);
      expect(notifier.state.error, 'MyKad Scan Cancelled');
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
