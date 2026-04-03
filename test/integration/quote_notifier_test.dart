import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:agentbanking_channel/features/transactions/providers/quote_notifier.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/auth/providers/auth_provider.dart';
import 'package:agentbanking_channel/features/auth/models/auth_models.dart';
import 'package:agentbanking_channel/features/compliance/providers/compliance_provider.dart';
import 'package:agentbanking_channel/features/settlement/services/eod_timer_service.dart';

import 'test_fakes.dart';
import 'quote_notifier_test_helpers.dart';

void main() {
  late FakeTransactionRepository fakeRepo;
  late FakeGeolocator fakeGeolocator;

  setUp(() {
    fakeRepo = FakeTransactionRepository();
    fakeGeolocator = FakeGeolocator();
  });

  /// Creates a QuoteNotifier wired to a minimal ProviderContainer.
  /// Override compliance/eod/auth as needed via parameters.
  QuoteNotifier createNotifier({
    bool complianceFrozen = false,
    bool eodLocked = false,
    AuthUser? authUser,
  }) {
    final container = ProviderContainer(overrides: [
      complianceProvider.overrideWith((ref) =>
        ComplianceNotifier()..debugSetFrozen(complianceFrozen)),
      eodTimerServiceProvider.overrideWith((ref) =>
        FakeEodTimerService(locked: eodLocked)),
      authProvider.overrideWith((ref) {
        final notifier = AuthNotifier(repository: ref.watch(authRepositoryProvider));
        if (authUser != null) notifier.debugSetAuthenticated(authUser);
        return notifier;
      }),
    ]);

    return QuoteNotifier(
      ref: container.read(Provider((ref) => ref)),
      repository: fakeRepo,
      geolocator: fakeGeolocator,
    );
  }

  group('QuoteNotifier - Happy Path', () {
    test('valid amount → quoting → waitingConsent', () async {
      final notifier = createNotifier();

      await notifier.startQuote(
        Decimal.fromInt(100), 'MERCHANT_001',
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

    test('RM 5,000 exactly → passes validation', () async {
      final notifier = createNotifier();

      await notifier.startQuote(
        Decimal.fromInt(5000), 'MERCHANT_001',
        serviceCode: 'CASH_WITHDRAWAL',
        fundingSource: FundingSource.CARD_EMV,
      );

      expect(notifier.state.status, TransactionStatus.waitingConsent);
      notifier.dispose();
    });

    test('cash > RM 3,000 → waitingMyKadScan (STP threshold)', () async {
      final notifier = createNotifier();

      await notifier.startQuote(
        Decimal.fromInt(3500), 'MERCHANT_001',
        serviceCode: 'CASH_DEPOSIT',
        fundingSource: FundingSource.CASH,
      );

      expect(notifier.state.status, TransactionStatus.waitingMyKadScan);
      expect(notifier.state.error, contains('ERR_VAL_AMOUNT_EXCEEDS_LIMIT'));
      notifier.dispose();
    });

    test('cash RM 3,000 exactly → passes (no MyKad needed)', () async {
      final notifier = createNotifier();

      await notifier.startQuote(
        Decimal.fromInt(3000), 'MERCHANT_001',
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
        Decimal.fromInt(100), 'MERCHANT_001',
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
        Decimal.fromInt(100), 'MERCHANT_001',
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
        Decimal.fromInt(50), 'MERCHANT_001',
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

      await notifier.startQuote(
        Decimal.fromInt(50), 'MERCHANT_001',
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

      await notifier.startQuote(
        Decimal.fromInt(100), 'MERCHANT_001',
        serviceCode: 'CASH_WITHDRAWAL',
        fundingSource: FundingSource.CARD_EMV,
      );

      expect(notifier.state.status, TransactionStatus.failed);
      expect(notifier.state.error, contains('Quote failed'));
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
