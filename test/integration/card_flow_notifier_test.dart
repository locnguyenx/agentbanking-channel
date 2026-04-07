import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:agentbanking_channel/features/transactions/providers/card_flow_notifier.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/auth/providers/auth_provider.dart';
import 'package:agentbanking_channel/features/auth/models/auth_models.dart';

import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';
import 'package:agentbanking_channel/core/network/dio_provider.dart';
import 'package:agentbanking_channel/core/network/auth_interceptor.dart';
import 'package:agentbanking_channel/core/offline/offline_queue_service.dart';
import 'package:agentbanking_channel/core/security/secure_storage_manager.dart';
import 'package:agentbanking_channel/features/transactions/services/reversal_service.dart';
import 'package:agentbanking_channel/features/settlement/providers/float_provider.dart';
import 'package:agentbanking_channel/features/hardware/hardware_interfaces.dart';
import 'package:agentbanking_channel/features/hardware/hardware_providers.dart';
import 'package:dio/dio.dart';

import 'test_fakes.dart';
import '../setup/test_credentials.dart';

const String apiBaseUrl = String.fromEnvironment('API_BASE_URL', defaultValue: 'http://localhost:8080');

final bool isRealBackend = const bool.fromEnvironment('USE_REAL_BACKEND', defaultValue: false);

void main() {
  late FakeCardReader fakeCardReader;
  late FakePinPad fakePinPad;
  late FakeTransactionRepository fakeRepo;
  late FakeFloatNotifier fakeFloat;
  late FakeReversalService fakeReversal;
  late FakeRef fakeRef;
  late ProviderContainer container;
  late FakeSecureStorage _sharedStorage;

  setUp(() {
    fakeCardReader = FakeCardReader();
    fakePinPad = FakePinPad();
    fakeRepo = FakeTransactionRepository();
    fakeFloat = FakeFloatNotifier();
    fakeReversal = FakeReversalService();
    fakeRef = FakeRef();
    _sharedStorage = FakeSecureStorage();

    // Stub mandatory providers
    fakeRef.stubProvider(authProvider, AuthUser(agentId: 'AGT-001', name: 'TEST', tier: 'GOLD'));

    container = ProviderContainer(overrides: [
      secureStorageManagerProvider.overrideWithValue(_sharedStorage),
      authProvider.overrideWith((ref) => AuthNotifier(repository: ref.watch(authRepositoryProvider))),
    ]);
  });

  tearDown(() {
    container.dispose();
  });

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

  TransactionState quotedState() => TransactionState(
    status: TransactionStatus.waitingCard,
    quote: TransactionQuoteResponse(
      quoteId: 'Q001', amount: Decimal.fromInt(100),
      fee: Decimal.fromInt(1), commission: Decimal.parse('0.50'),
      total: Decimal.fromInt(101),
    ),
    amount: Decimal.fromInt(100),
    serviceCode: 'CASH_WITHDRAWAL',
    fundingSource: FundingSource.CARD_EMV,
    idempotencyKey: 'KEY-CARD-001',
  );

  CardFlowNotifier createNotifier() {
    final dio = Dio(BaseOptions(baseUrl: apiBaseUrl));
    dio.interceptors.add(AuthInterceptor(_sharedStorage));

    final container = ProviderContainer(overrides: [
      secureStorageManagerProvider.overrideWithValue(_sharedStorage),
      authProvider.overrideWith((ref) => AuthNotifier(repository: ref.watch(authRepositoryProvider))),
      dioProvider.overrideWithValue(dio),
    ]);

    return CardFlowNotifier(
      ref: isRealBackend ? container.read(Provider((ref) => ref)) : fakeRef,
      repository: isRealBackend ? container.read(transactionRepositoryProvider) : fakeRepo,
      cardReader: isRealBackend ? container.read(cardReaderProvider) : fakeCardReader,
      pinPad: isRealBackend ? container.read(pinPadProvider) : fakePinPad,
      floatNotifier: isRealBackend ? container.read(floatProvider.notifier) : fakeFloat,
      reversalService: isRealBackend ? container.read(reversalServiceProvider) : fakeReversal,
    );
  }

  group('CardFlowNotifier - Happy Path', () {
    test('startCardFlow transitions to waitingCard', () async {
      final container = ProviderContainer(overrides: [
        authProvider.overrideWith((ref) => AuthNotifier(repository: ref.watch(authRepositoryProvider))),
      ]);
      final notifier = CardFlowNotifier(
        ref: container.read(providerContainerProvider),
        cardReader: isRealBackend ? container.read(cardReaderProvider) : fakeCardReader,
        pinPad: isRealBackend ? container.read(pinPadProvider) : fakePinPad,
        repository: isRealBackend ? container.read(transactionRepositoryProvider) : fakeRepo,
        floatNotifier: isRealBackend ? container.read(floatProvider.notifier) : fakeFloat,
        reversalService: isRealBackend ? container.read(reversalServiceProvider) : fakeReversal,
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

  group('CardFlowNotifier - Withdrawal', () {
    test('happy path: card → pin → poll → success', () async {
      final notifier = createNotifier();
      await _ensureRealLogin(notifier.ref.read(Provider((ref) => ref.container)));

      await notifier.startCardFlow(quotedState());
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
