import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agentbanking_channel/features/transactions/screens/transaction_flow_screen.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:agentbanking_channel/features/auth/providers/auth_provider.dart';
import 'package:agentbanking_channel/features/auth/repositories/auth_repository.dart';
import 'package:agentbanking_channel/features/auth/models/auth_models.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';

class MockTransactionNotifier extends StateNotifier<TransactionState> implements TransactionNotifier {
  MockTransactionNotifier() : super(TransactionState(status: TransactionStatus.idle));
  
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
  
  @override
  void reset() {}
}

class FakeAuthRepository extends AuthRepository {
  @override
  Future<AuthUser> login(String id, String pass) async => AuthUser(agentId: id, name: 'Test', tier: 'GOLD');
}

void main() {
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
    
    expect(find.text('Balance Inquiry'), findsWidgets);
    expect(find.text('Check customer account balance securely'), findsOneWidget);
    expect(find.text('Enter Amount'), findsNothing);
    expect(find.text('PROCEED'), findsOneWidget);
  });
}
