import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agentbanking_channel/features/transactions/screens/transaction_flow_screen.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:agentbanking_channel/features/auth/providers/auth_provider.dart';
import 'package:agentbanking_channel/features/auth/models/auth_models.dart';
import 'package:agentbanking_channel/features/auth/repositories/auth_repository.dart';
import 'package:agentbanking_channel/core/offline/offline_queue_service.dart';
import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/hardware/hardware_interfaces.dart';
import 'package:agentbanking_channel/features/settlement/providers/float_provider.dart';
import 'package:agentbanking_channel/core/settlement/settlement_service.dart';
import 'package:dio/dio.dart';

// Mocks
class FakeTransactionRepository implements TransactionRepository {
  @override
  Dio get dio => throw UnimplementedError();
  @override
  Future<TransactionExecutionResponse> executeTransaction(TransactionExecutionRequest request) async => throw UnimplementedError();
  @override
  Future<TransactionQuoteResponse> getQuote(TransactionQuoteRequest request) async => throw UnimplementedError();
  @override
  Future<String> performProxyEnquiry(String proxyId, String proxyType) async => throw UnimplementedError();
}

class FakeCardReader implements ICardReader {
  @override
  Future<CardData?> readCard() async => null;
  @override
  Future<bool> isAvailable() async => true;
}

class FakePinPad implements IPinPad {
  @override
  Future<String?> capturePin() async => null;
  @override
  Future<bool> isAvailable() async => true;
}

class MockTransactionNotifier extends TransactionNotifier {
  MockTransactionNotifier() : super(
    repository: FakeTransactionRepository(),
    cardReader: FakeCardReader(),
    pinPad: FakePinPad(),
    floatNotifier: FloatNotifier(), // Using real notifier as mock here for simplicity
  );
}

class FakeAuthRepository implements AuthRepository {
  @override
  Future<AuthUser> login(String agentId, String password) async => throw UnimplementedError();
  @override
  Future<AuthUser> loginBiometric() async => throw UnimplementedError();
}

void main() {
  testWidgets('renders amount input for Withdrawal', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authProvider.overrideWith((ref) => AuthNotifier(repository: FakeAuthRepository())..state = AuthState(
            status: AuthStatus.authenticated,
            user: AuthUser(agentId: 'AGENT01', name: 'Test Agent', tier: 'GOLD'),
          )),
          transactionProvider.overrideWith((ref) => MockTransactionNotifier()),
          pendingQueueCountProvider.overrideWith((ref) => const Stream.empty()),
        ],
        child: const MaterialApp(
          home: TransactionFlowScreen(title: 'Cash Withdrawal', serviceCode: 'CASH_WDL'),
        ),
      ),
    );

    await tester.pumpAndSettle();
    
    expect(find.text('Cash Withdrawal'), findsWidgets); // Can find in AppBar and Body
    expect(find.text('Enter Amount'), findsOneWidget);
    expect(find.text('GET QUOTE'), findsOneWidget);
  });

  testWidgets('hides amount input for Balance Inquiry', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authProvider.overrideWith((ref) => AuthNotifier(repository: FakeAuthRepository())..state = AuthState(
            status: AuthStatus.authenticated,
            user: AuthUser(agentId: 'AGENT01', name: 'Test Agent', tier: 'GOLD'),
          )),
          transactionProvider.overrideWith((ref) => MockTransactionNotifier()),
          pendingQueueCountProvider.overrideWith((ref) => const Stream.empty()),
        ],
        child: const MaterialApp(
          home: TransactionFlowScreen(title: 'Balance Inquiry', serviceCode: 'BAL_INQ'),
        ),
      ),
    );

    await tester.pumpAndSettle();
    
    expect(find.text('Balance Inquiry'), findsWidgets); // Found in AppBar and Body
    expect(find.text('Check customer account balance securely'), findsOneWidget);
    expect(find.text('Enter Amount'), findsNothing);
    expect(find.text('PROCEED'), findsOneWidget);
  });
}
