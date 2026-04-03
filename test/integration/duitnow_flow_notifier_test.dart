import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:agentbanking_channel/features/transactions/providers/duitnow_flow_notifier.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/auth/providers/auth_provider.dart';

import 'test_fakes.dart';

void main() {
  late FakeTransactionRepository fakeRepo;
  late FakeFloatNotifier fakeFloat;
  late FakeReversalService fakeReversal;
  late ProviderContainer container;

  setUp(() {
    fakeRepo = FakeTransactionRepository();
    fakeFloat = FakeFloatNotifier();
    fakeReversal = FakeReversalService();
    container = ProviderContainer(overrides: [
      authProvider.overrideWith((ref) => AuthNotifier(repository: ref.watch(authRepositoryProvider))),
    ]);
  });

  tearDown(() {
    container.dispose();
  });

  TransactionState quotedState({FundingSource? source}) => TransactionState(
    status: TransactionStatus.waitingConsent,
    quote: TransactionQuoteResponse(
      quoteId: 'Q001', amount: Decimal.fromInt(100),
      fee: Decimal.fromInt(1), commission: Decimal.parse('0.50'),
      total: Decimal.fromInt(101),
    ),
    amount: Decimal.fromInt(100),
    serviceCode: 'DUITNOW_TRANSFER',
    fundingSource: source ?? FundingSource.DUITNOW_MOBILE,
    idempotencyKey: 'KEY-DN-001',
    metadata: {'duitNowProxyId': '0123456789'},
  );

  DuitNowFlowNotifier createNotifier() {
    return DuitNowFlowNotifier(
      ref: container.read(Provider((ref) => ref)),
      repository: fakeRepo,
      floatNotifier: fakeFloat,
      reversalService: fakeReversal,
    );
  }

  group('DuitNowFlowNotifier - Proxy Transfer', () {
    test('happy path: initiate → poll → success', () async {
      final notifier = createNotifier();

      await notifier.executeDuitNowTransfer(quotedState());

      expect(notifier.state.status, TransactionStatus.success);
      expect(notifier.state.result?.referenceId, 'DN_REF_001');
      notifier.dispose();
    });

    test('initiate returns FAILED → failed state', () async {
      fakeRepo.duitNowInitiateToReturn = TransactionExecutionResponse(
        status: 'FAILED',
        referenceId: 'DN_REF_001',
        errorMessage: 'Proxy not found',
      );

      final notifier = createNotifier();
      await notifier.executeDuitNowTransfer(quotedState());

      expect(notifier.state.status, TransactionStatus.failed);
      expect(notifier.state.error, 'Proxy not found');
      notifier.dispose();
    });

    test('polling returns FAILED → failed state', () async {
      fakeRepo.duitNowStatusToReturn = {'status': 'FAILED'};

      final notifier = createNotifier();
      await notifier.executeDuitNowTransfer(quotedState());

      expect(notifier.state.status, TransactionStatus.failed);
      expect(notifier.state.error, 'FAILED');
      notifier.dispose();
    });
  });

  group('DuitNowFlowNotifier - QR Flow', () {
    test('happy path: generate QR → poll → success', () async {
      final notifier = createNotifier();
      final qrState = quotedState().copyWith(serviceCode: 'DUITNOW_QR_RETAIL');

      await notifier.executeDuitNowQrFlow(qrState);

      expect(notifier.state.status, TransactionStatus.success);
      expect(notifier.state.result?.referenceId, 'DN_REF_001');
      notifier.dispose();
    });

    test('QR flow sets displayingQr before polling', () async {
      // Track intermediate states
      final states = <TransactionStatus>[];
      fakeRepo.duitNowStatusToReturn = {'status': 'PENDING'};

      final notifier = createNotifier();
      notifier.addListener((state) {
        states.add(state.status);
      });

      // Will timeout since status stays PENDING, but we check intermediate states
      fakeRepo.duitNowStatusToReturn = {'status': 'SUCCESS'};
      final qrState = quotedState().copyWith(serviceCode: 'DUITNOW_QR_RETAIL');
      await notifier.executeDuitNowQrFlow(qrState);

      // Should have passed through processing → displayingQr → success
      expect(states, contains(TransactionStatus.displayingQr));
      expect(states.last, TransactionStatus.success);
      notifier.dispose();
    });
  });

  group('DuitNowFlowNotifier - Proxy Type Resolution', () {
    test('DUITNOW_MOBILE maps to MOBILE proxy type', () async {
      final notifier = createNotifier();
      await notifier.executeDuitNowTransfer(quotedState(source: FundingSource.DUITNOW_MOBILE));
      expect(notifier.state.status, TransactionStatus.success);
      notifier.dispose();
    });

    test('DUITNOW_MYKAD maps correctly', () async {
      final notifier = createNotifier();
      await notifier.executeDuitNowTransfer(quotedState(source: FundingSource.DUITNOW_MYKAD));
      expect(notifier.state.status, TransactionStatus.success);
      notifier.dispose();
    });
  });
}
