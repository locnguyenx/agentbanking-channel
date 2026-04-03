import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:agentbanking_channel/features/transactions/screens/transaction_flow_screen.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:agentbanking_channel/features/auth/providers/auth_provider.dart';
import 'package:agentbanking_channel/features/auth/repositories/auth_repository.dart';
import 'package:agentbanking_channel/features/auth/models/auth_models.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';
import 'package:agentbanking_channel/features/hardware/hardware_interfaces.dart';
import 'package:agentbanking_channel/features/settlement/providers/float_provider.dart';
import 'package:agentbanking_channel/features/transactions/services/reversal_service.dart';
import 'package:agentbanking_channel/features/compliance/providers/compliance_provider.dart';
import 'package:agentbanking_channel/features/settlement/services/eod_timer_service.dart';
import 'package:geolocator/geolocator.dart';


class MockTransactionNotifier extends StateNotifier<TransactionState> implements TransactionNotifier {
  MockTransactionNotifier([TransactionState? state]) : super(state ?? TransactionState(status: TransactionStatus.idle));

  @override
  Ref get ref => throw UnimplementedError();
  @override
  TransactionRepository get repository => throw UnimplementedError();
  @override
  ICardReader get cardReader => throw UnimplementedError();
  @override
  IPinPad get pinPad => throw UnimplementedError();
  @override
  FloatNotifier get floatNotifier => throw UnimplementedError();
  @override
  ReversalService get reversalService => throw UnimplementedError();
  @override
  IMyKadScanner get myKadScanner => throw UnimplementedError();
  @override
  ComplianceNotifier get complianceNotifier => throw UnimplementedError();
  @override
  EodTimerService get eodTimerService => throw UnimplementedError();
  @override
  GeolocatorPlatform get geolocator => throw UnimplementedError();
  @override
  Duration get pollingInterval => Duration.zero;
  @override
  Duration get cardTimerDelay => Duration.zero;

  @override
  void reset() {}
  @override
  Future<void> confirmConsent({String? duitNowProxyId}) async {}
  @override
  String getPollingStatusLabel() => 'Processing...';
  @override
  Future<void> startTransaction(Decimal amount, String merchantId, {required String serviceCode, required FundingSource fundingSource, Map<String, String>? metadata, String? idempotencyKey}) async {}
  @override
  Future<void> balanceInquiry(String agentId) async {}
  @override
  Future<void> jomPay(String billerCode, String ref1, String? ref2, Decimal amount, String agentId) async {}
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class FakeAuthRepository extends Fake implements AuthRepository {
  @override
  Future<AuthUser> login(String id, String pass) async => AuthUser(agentId: id, name: 'Test', tier: 'GOLD');
}

void main() {
  setUpAll(() async {
    await initializeDateFormatting('en_MY', null);
  });

  testWidgets('renders initial state for Cash Withdrawal', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authProvider.overrideWith((ref) => AuthNotifier(repository: FakeAuthRepository())..state = AuthState(
            status: AuthStatus.authenticated,
            user: AuthUser(agentId: 'AGENT01', name: 'Test Agent', tier: 'GOLD'),
          )),
          transactionProvider.overrideWith((ref) => MockTransactionNotifier()),
        ],
        child: const MaterialApp(
          home: TransactionFlowScreen(title: 'Withdrawal', serviceCode: 'CASH_WITHDRAWAL'),
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text('Withdrawal'), findsWidgets);
    expect(find.text('Enter Amount'), findsOneWidget);
    expect(find.text('GET QUOTE'), findsOneWidget);
  });

  testWidgets('hides amount input for Balance Inquiry', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authProvider.overrideWith((ref) => AuthNotifier(repository: FakeAuthRepository())..state = AuthState(
            status: AuthStatus.authenticated,
            user: AuthUser(agentId: 'AGENT01', name: 'Test Agent', tier: 'GOLD'),
          )),
          transactionProvider.overrideWith((ref) => MockTransactionNotifier()),
        ],
        child: const MaterialApp(
          home: TransactionFlowScreen(title: 'Balance Inquiry', serviceCode: 'BALANCE_INQUIRY'),
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.textContaining('Balance Inquiry'), findsWidgets);
    expect(find.textContaining('customer account balance'), findsOneWidget);
    expect(find.text('Enter Amount'), findsNothing);
    expect(find.text('PROCEED'), findsOneWidget);
  });
}
