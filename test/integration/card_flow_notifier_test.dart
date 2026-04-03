import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:agentbanking_channel/features/transactions/providers/card_flow_notifier.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/auth/providers/auth_provider.dart';

import 'test_fakes.dart';

void main() {
  late FakeCardReader fakeCardReader;
  late FakePinPad fakePinPad;
  late FakeTransactionRepository fakeRepo;
  late FakeFloatNotifier fakeFloat;
  late FakeReversalService fakeReversal;

  setUp(() {
    fakeCardReader = FakeCardReader();
    fakePinPad = FakePinPad();
    fakeRepo = FakeTransactionRepository();
    fakeFloat = FakeFloatNotifier();
    fakeReversal = FakeReversalService();
  });

  CardFlowNotifier createNotifier() {
    final container = ProviderContainer(overrides: [
      authProvider.overrideWith((ref) => AuthNotifier(repository: ref.watch(authRepositoryProvider))),
    ]);
    return CardFlowNotifier(
      ref: container.read(providerContainerProvider),
      cardReader: fakeCardReader,
      pinPad: fakePinPad,
      repository: fakeRepo,
      floatNotifier: fakeFloat,
      reversalService: fakeReversal,
    );
  }

  TransactionState quotedState() => TransactionState(
    status: TransactionStatus.waitingConsent,
    quote: TransactionQuoteResponse(
      quoteId: 'Q001', amount: Decimal.fromInt(100),
      fee: Decimal.fromInt(1), commission: Decimal.parse('0.50'),
      total: Decimal.fromInt(101),
    ),
    amount: Decimal.fromInt(100),
    serviceCode: 'CASH_WITHDRAWAL',
    fundingSource: FundingSource.CARD_EMV,
    idempotencyKey: 'KEY-001',
  );

  group('CardFlowNotifier - Happy Path', () {
    test('startCardFlow transitions to waitingCard', () async {
      final container = ProviderContainer(overrides: [
        authProvider.overrideWith((ref) => AuthNotifier(repository: ref.watch(authRepositoryProvider))),
      ]);
      final notifier = CardFlowNotifier(
        ref: container.read(providerContainerProvider),
        cardReader: fakeCardReader,
        pinPad: fakePinPad,
        repository: fakeRepo,
        floatNotifier: fakeFloat,
        reversalService: fakeReversal,
        cardTimerDelay: const Duration(days: 365), // prevent auto-processCard
      );

      await notifier.startCardFlow(quotedState());
      expect(notifier.state.status, TransactionStatus.waitingCard);
      expect(notifier.state.quote?.quoteId, 'Q001');
      notifier.dispose();
    });

    test('processCard: card → PIN → execute → success', () async {
      final container = ProviderContainer(overrides: [
        authProvider.overrideWith((ref) => AuthNotifier(repository: ref.watch(authRepositoryProvider))),
      ]);
      final notifier = CardFlowNotifier(
        ref: container.read(providerContainerProvider),
        cardReader: fakeCardReader,
        pinPad: fakePinPad,
        repository: fakeRepo,
        floatNotifier: fakeFloat,
        reversalService: fakeReversal,
        cardTimerDelay: const Duration(days: 365),
      );

      // Set up initial state
      notifier.debugSetState(quotedState().copyWith(status: TransactionStatus.waitingCard));
      fakeFloat.resetFetchCount();
      await notifier.processCard();

      expect(notifier.state.status, TransactionStatus.success);
      expect(notifier.state.result?.referenceId, 'FAKE_REF_001');
      expect(fakeFloat.fetchCallCount, 1); // float refreshed on success
      notifier.dispose();
    });
  });

  group('CardFlowNotifier - Card Failure', () {
    test('card read returns null → failed', () async {
      fakeCardReader.shouldFail = true;
      final container = ProviderContainer(overrides: [
        authProvider.overrideWith((ref) => AuthNotifier(repository: ref.watch(authRepositoryProvider))),
      ]);
      final notifier = CardFlowNotifier(
        ref: container.read(providerContainerProvider),
        cardReader: fakeCardReader,
        pinPad: fakePinPad,
        repository: fakeRepo,
        floatNotifier: fakeFloat,
        reversalService: fakeReversal,
        cardTimerDelay: const Duration(days: 365),
      );

      notifier.debugSetState(quotedState().copyWith(status: TransactionStatus.waitingCard));
      await notifier.processCard();

      expect(notifier.state.status, TransactionStatus.failed);
      expect(notifier.state.error, 'Card Read Failed');
      notifier.dispose();
    });
  });

  group('CardFlowNotifier - PIN Cancellation', () {
    test('PIN entry cancelled → failed', () async {
      fakePinPad.shouldCancel = true;
      final container = ProviderContainer(overrides: [
        authProvider.overrideWith((ref) => AuthNotifier(repository: ref.watch(authRepositoryProvider))),
      ]);
      final notifier = CardFlowNotifier(
        ref: container.read(providerContainerProvider),
        cardReader: fakeCardReader,
        pinPad: fakePinPad,
        repository: fakeRepo,
        floatNotifier: fakeFloat,
        reversalService: fakeReversal,
        cardTimerDelay: const Duration(days: 365),
      );

      notifier.debugSetState(quotedState().copyWith(status: TransactionStatus.waitingCard));
      await notifier.processCard();

      expect(notifier.state.status, TransactionStatus.failed);
      expect(notifier.state.error, 'PIN Entry Cancelled');
      notifier.dispose();
    });
  });

  group('CardFlowNotifier - Balance Inquiry', () {
    test('happy path: card → PIN → inquiry → success', () async {
      final container = ProviderContainer(overrides: [
        authProvider.overrideWith((ref) => AuthNotifier(repository: ref.watch(authRepositoryProvider))),
      ]);
      final notifier = CardFlowNotifier(
        ref: container.read(providerContainerProvider),
        cardReader: fakeCardReader,
        pinPad: fakePinPad,
        repository: fakeRepo,
        floatNotifier: fakeFloat,
        reversalService: fakeReversal,
      );

      fakeRepo.executionToReturn = TransactionExecutionResponse(
        status: 'SUCCESS',
        referenceId: 'BAL_REF_001',
        balance: Decimal.fromInt(1500),
      );

      fakeFloat.resetFetchCount();
      await notifier.balanceInquiry('MERCHANT_001');

      expect(notifier.state.status, TransactionStatus.success);
      expect(notifier.state.result?.balance, Decimal.fromInt(1500));
      expect(fakeFloat.fetchCallCount, 0); // balance inquiry doesn't refresh float
      notifier.dispose();
    });
  });
}

/// Provides a fake container-level Ref for notifiers that need ref.read().
/// This is a minimal workaround — in production, Riverpod wires this automatically.
final providerContainerProvider = Provider<Ref>((ref) => ref);

extension DebugCardFlowNotifier on CardFlowNotifier {
  void debugSetState(TransactionState newState) {
    // ignore: invalid_use_of_protected_member
    state = newState;
  }
}
