import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/settlement/providers/float_provider.dart';
import 'package:agentbanking_channel/features/settlement/repositories/float_repository.dart';
import 'package:agentbanking_channel/features/settlement/models/float_models.dart';
import 'package:agentbanking_channel/features/kyc/providers/onboarding_provider.dart';
import 'package:agentbanking_channel/features/kyc/repositories/kyc_repository.dart';
import 'package:agentbanking_channel/features/kyc/models/kyc_models.dart';
import 'package:agentbanking_channel/features/hardware/hardware_interfaces.dart';
import 'package:decimal/decimal.dart';
import 'package:agentbanking_channel/core/offline/offline_queue_service.dart';

class FakeTransactionRepository extends Fake implements TransactionRepository {
  @override
  Future<TransactionQuoteResponse> getQuote(TransactionQuoteRequest request) async {
    return TransactionQuoteResponse(
      amount: request.amount,
      fee: Decimal.parse('1.00'),
      commission: Decimal.parse('0.50'),
      total: request.amount + Decimal.parse('1.00'),
      quoteId: 'Q123',
    );
  }

  @override
  Future<TransactionExecutionResponse> executeTransaction(TransactionExecutionRequest request) async {
    return TransactionExecutionResponse(
      status: 'SUCCESS',
      referenceId: 'TXN${DateTime.now().millisecondsSinceEpoch}',
    );
  }

  @override
  Future<TransactionExecutionResponse> initiateDuitNow({
    required String quoteId,
    required String proxyId,
    required String proxyType,
    required Decimal amount,
  }) async {
    return TransactionExecutionResponse(status: 'SUCCESS', referenceId: 'DN123');
  }

  @override
  Future<String> getDuitNowStatus(String referenceId) async {
    return 'COMPLETED';
  }

  @override
  Future<String> performProxyEnquiry(String proxyId, String proxyType) async {
    return 'JOHN D***';
  }
}

class FakeKycRepository extends Fake implements KycRepository {
  @override
  Future<KycValidationResponse> validateKyc(KycValidationRequest request) async {
    return KycValidationResponse(isApproved: true, kycId: 'KYC123', reasons: []);
  }

  @override
  Future<AmlCheckResponse> runAmlCheck(String icNumber) async {
    return AmlCheckResponse(isClear: true, amlReference: 'AML123');
  }

  @override
  Future<void> openAccount(String icNumber, String productCode) async {
    // No-op for fake
  }
}

class FakeFloatRepository extends Fake implements FloatRepository {
  @override
  Future<FloatLedger> getFloatStatus() async {
    return FloatLedger(
      currentBalance: Decimal.parse('5000.0'),
      limit: Decimal.parse('10000.0'),
    );
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('End-to-End Onboarding and Transaction Flow', () {
    Future<void> waitFor(WidgetTester tester, Finder finder, {Duration timeout = const Duration(seconds: 60)}) async {
      int frames = 0;
      while (frames < (timeout.inSeconds * 10)) {
        await tester.pump(const Duration(milliseconds: 100));
        if (finder.evaluate().isNotEmpty) return;
        frames++;
      }
      throw Exception('Timeout waiting for $finder');
    }

    testWidgets('Complete e-KYC Onboarding and a Bill Payment', (tester) async {
      tester.view.physicalSize = const Size(1024, 1024);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final mockRepo = FakeTransactionRepository();
      final mockFloatRepo = FakeFloatRepository();
      final mockKycRepo = FakeKycRepository();
      
      await tester.pumpWidget(ProviderScope(
        overrides: [
          transactionRepositoryProvider.overrideWithValue(mockRepo),
          floatRepositoryProvider.overrideWithValue(mockFloatRepo),
          kycRepositoryProvider.overrideWithValue(mockKycRepo),
          pendingQueueCountProvider.overrideWith((ref) => const Stream.empty()),
        ],
        child: const AgentBankingApp(),
      ));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField).at(0), 'AGENT01');
      await tester.enterText(find.byType(TextField).at(1), '123456');
      await tester.tap(find.text('LOGIN'));
      await tester.pumpAndSettle();

      expect(find.text('Agent Dashboard'), findsOneWidget);
      await tester.tap(find.byKey(const Key('btn_onboard')));
      await tester.pumpAndSettle();

      await tester.tap(find.text('START MYKAD SCAN'));
      await waitFor(tester, find.textContaining('KYC VERIFIED'));
      
      await tester.tap(find.text('Savings Account-i'));
      await waitFor(tester, find.textContaining('Welcome Aboard!'));
      await tester.tap(find.text('BACK TO DASHBOARD'));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('btn_bills')));
      await tester.pumpAndSettle();

      // Select Biller from Dropdown
      await tester.tap(find.text('Select Biller'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Air Selangor (1234)').last);
      await tester.pumpAndSettle();

      final fields = find.byType(TextField);
      await tester.enterText(fields.at(0), 'REF123');
      await tester.enterText(fields.at(1), '50.00');
      
      await tester.tap(find.text('PROCEED'));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('btn_confirm')));
      await tester.pump(const Duration(seconds: 1)); 
      await waitFor(tester, find.byKey(const Key('status_success')));
      
      await tester.tap(find.text('DONE'));
      await tester.pumpAndSettle();
      expect(find.text('RM 5,000.00'), findsOneWidget);
    });

    testWidgets('Bill Payment with CARD should require card insertion', (tester) async {
      tester.view.physicalSize = const Size(1024, 1024);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final mockRepo = FakeTransactionRepository();
      final mockFloatRepo = FakeFloatRepository();
      final mockKycRepo = FakeKycRepository();

      await tester.pumpWidget(ProviderScope(
        overrides: [
          transactionRepositoryProvider.overrideWithValue(mockRepo),
          floatRepositoryProvider.overrideWithValue(mockFloatRepo),
          kycRepositoryProvider.overrideWithValue(mockKycRepo),
          pendingQueueCountProvider.overrideWith((ref) => const Stream.empty()),
        ],
        child: const AgentBankingApp(),
      ));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField).at(0), 'AGENT01');
      await tester.enterText(find.byType(TextField).at(1), '123456');
      await tester.tap(find.text('LOGIN'));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('btn_bills')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('funding_source_CARD_EMV')));
      await tester.pumpAndSettle();

      // Select Biller from Dropdown
      await tester.tap(find.text('Select Biller'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Air Selangor (1234)').last);
      await tester.pumpAndSettle();

      final fields = find.byType(TextField);
      await tester.enterText(fields.at(0), 'REF123');
      await tester.enterText(fields.at(1), '50.00');
      
      await tester.tap(find.text('PROCEED'));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('btn_confirm')));
      await waitFor(tester, find.byKey(const Key('status_waiting_card')));
      
      // Drain any pending timers from MockCardReader and MockPinPad
      await tester.pump(const Duration(seconds: 5));
    });

    testWidgets('Bill Payment with DUITNOW should NOT require card insertion', (tester) async {
      tester.view.physicalSize = const Size(1024, 1024);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final mockRepo = FakeTransactionRepository();
      final mockFloatRepo = FakeFloatRepository();
      final mockKycRepo = FakeKycRepository();

      await tester.pumpWidget(ProviderScope(
        overrides: [
          transactionRepositoryProvider.overrideWithValue(mockRepo),
          floatRepositoryProvider.overrideWithValue(mockFloatRepo),
          kycRepositoryProvider.overrideWithValue(mockKycRepo),
          pendingQueueCountProvider.overrideWith((ref) => const Stream.empty()),
        ],
        child: const AgentBankingApp(),
      ));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField).at(0), 'AGENT01');
      await tester.enterText(find.byType(TextField).at(1), '123456');
      await tester.tap(find.text('LOGIN'));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('btn_bills')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('funding_source_DUITNOW_MOBILE')));
      await tester.pumpAndSettle();

      // DuitNow flow has 4 fields (Proxy + Biller + Ref + Amount)
      final fields = find.byType(TextField);
      await tester.enterText(fields.at(0), '0129999999'); 

      // Select Biller from Dropdown
      await tester.tap(find.text('Select Biller'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Air Selangor (1234)').last);
      await tester.pumpAndSettle();
      
      await tester.enterText(fields.at(1), 'REF123');
      await tester.enterText(fields.at(2), '75.00');
      
      await tester.tap(find.text('PROCEED'));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('btn_confirm')));
      await waitFor(tester, find.byKey(const Key('status_success')));
      
      await tester.tap(find.text('DONE'));
      await tester.pumpAndSettle();
      expect(find.text('RM 5,000.00'), findsOneWidget);
    });
  });
}
