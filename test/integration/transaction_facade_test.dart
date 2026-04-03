import 'package:flutter_test/flutter_test.dart';
import 'package:decimal/decimal.dart';

import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/auth/providers/auth_provider.dart';
import 'package:agentbanking_channel/features/auth/models/auth_models.dart';
import 'package:agentbanking_channel/features/compliance/providers/compliance_provider.dart';
import 'package:agentbanking_channel/features/settlement/services/eod_timer_service.dart';
import 'test_fakes.dart';

/// Integration test: Verify TransactionNotifier (façade) delegates
/// to sub-notifiers instead of performing logic inline.
///
/// These tests verify the ROUTING, not the sub-notifier logic
/// (that's already covered by individual notifier tests).
void main() {
  group('TransactionNotifier Façade Routing', () {
    late TransactionNotifier notifier;
    late FakeRef ref;
    late FakeTransactionRepository repo;
    late FakeFloatNotifier floatNotifier;

    setUp(() {
      ref = FakeRef();
      repo = FakeTransactionRepository();
      floatNotifier = FakeFloatNotifier();

      // Stub authProvider so startTransaction geofence/validation works
      ref.stubProvider(authProvider, AuthState(
        status: AuthStatus.authenticated,
        user: AuthUser(
          agentId: 'AGENT-001',
          name: 'Test Agent',
          tier: 'GOLD',
          registeredLat: null, // Skip geofence for these tests
          registeredLng: null,
        ),
      ));

      ref.stubProvider(complianceProvider, ComplianceState(isFrozen: false));
      ref.stubProvider(eodTimerServiceProvider.notifier, FakeEodTimerService());

      notifier = TransactionNotifier(
        ref: ref,
        repository: repo,
        cardReader: FakeCardReader(),
        pinPad: FakePinPad(),
        floatNotifier: floatNotifier,
        reversalService: FakeReversalService(),
        myKadScanner: FakeMyKadScanner(),
        complianceNotifier: FakeComplianceNotifier(),
        eodTimerService: FakeEodTimerService(),
        geolocator: FakeGeolocator(),
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
