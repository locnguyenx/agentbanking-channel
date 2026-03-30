import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agentbanking_channel/main.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:agentbanking_channel/core/network/dio_provider.dart';
import 'package:agentbanking_channel/features/auth/providers/auth_provider.dart';
import 'package:agentbanking_channel/features/auth/models/auth_models.dart';
import 'package:agentbanking_channel/features/auth/repositories/auth_repository.dart';
import 'package:agent_api/agent_api.dart';
import 'package:decimal/decimal.dart';
import 'package:mockito/mockito.dart';
import 'package:agentbanking_channel/features/transactions/screens/jompay_form.dart';
import 'manual_mock_dio.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Biller Integration Tests', () {
    late ManualMockDio mockDio;

    setUp(() {
      mockDio = ManualMockDio();
    });

    testWidgets('Successful JomPay transaction with polling', (tester) async {
      // 0. Setup Viewport
      await tester.binding.setSurfaceSize(const Size(1024, 1024));
      
      // 1. Setup Mock Responses
      // Quote Response
      mockDio.setResponse('/api/v1/ledger/quote', {
        'quoteId': 'QUOTE-JOM-123',
        'amount': 100.0,
        'fee': 1.0,
        'total': 101.0,
        'commission': 0.5,
      });

      // Execution Response (PENDING)
      mockDio.setResponse('/api/v1/billpayment/jompay', {
        'status': 'PENDING',
        'transactionId': 'TX-JOM-456',
        'message': 'Transaction pending processing',
      });

      // Status Polling Responses
      // First poll - still pending
      mockDio.setResponse('/api/v1/bill/status/TX-JOM-456', {'status': 'PENDING'});
      
      // 2. Start App
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            dioProvider.overrideWithValue(mockDio),
            authProvider.overrideWith((ref) => AuthNotifierMock()),
          ],
          child: const AgentBankingApp(),
        ),
      );
      await tester.pumpAndSettle();

      // 2.1 Login
      await tester.enterText(find.byType(TextField).at(0), 'AGENT-123');
      await tester.enterText(find.byType(TextField).at(1), 'password');
      await tester.tap(find.text('LOGIN'));
      await tester.pumpAndSettle();
      
      // Wait for navigation animation
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();

      // 3. Navigate to JomPay
      final jompayBtn = find.byKey(const Key('btn_jompay'));
      await tester.ensureVisible(jompayBtn);
      await tester.tap(jompayBtn);
      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 1));

      // 4. Fill Form
      expect(find.byType(JomPayForm), findsOneWidget);
      await tester.enterText(find.widgetWithText(TextFormField, 'Biller Code'), '12345');
      await tester.enterText(find.widgetWithText(TextFormField, 'Ref-1 (Account Number)'), 'ACC-789');
      await tester.enterText(find.widgetWithText(TextFormField, 'Amount (RM)'), '100');
      await tester.tap(find.text('PROCEED'));
      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 1));

      // 5. Confirm Transaction
      expect(find.text('Confirm Details'), findsOneWidget);
      
      // Update mock for next status poll: PENDING then SUCCESS
      mockDio.setResponse('/api/v1/bill/status/TX-JOM-456', [
        {'status': 'PENDING'},
        {'status': 'SUCCESS'},
      ]);
      
      await tester.tap(find.byKey(const Key('btn_confirm')));
      
      // 1. Wait for submission to reach "Processing Biller..." state
      // (Execution -> PENDING -> triggers polling)
      await tester.pump(); 
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pump();

      // Should be in "Processing Biller..." state now
      expect(find.byKey(const Key('status_processing_biller')), findsOneWidget);
      
      // 2. Wait for FIRST poll interval (5s in notifier)
      // The first poll in the test is set to return PENDING again
      await tester.pump(const Duration(seconds: 6));
      await tester.pump(); // Frame state change if any

      // Should STILL be in "Processing Biller..." state
      expect(find.byKey(const Key('status_processing_biller')), findsOneWidget);

      // 3. Wait for SECOND poll interval (SUCCESS response)
      // The queue in ManualMockDio should now return the SUCCESS response
      await tester.pump(const Duration(seconds: 6));
      await tester.pumpAndSettle();

      // 4. Verify Success
      expect(find.byKey(const Key('status_success')), findsOneWidget);
      expect(find.text('Reference ID'), findsOneWidget);
      expect(find.text('TX-JOM-456'), findsOneWidget);
    });
  });
}

class AuthNotifierMock extends AuthNotifier {
  AuthNotifierMock() : super(repository: AuthRepository());

  @override
  Future<void> login(String agentId, String password) async {
    state = state.copyWith(status: AuthStatus.authenticated, user: AuthUser(name: 'Test Agent', agentId: 'AGENT-123', tier: 'Gold'));
  }

  @override
  Future<void> loginBiometric() async {
    state = state.copyWith(status: AuthStatus.authenticated, user: AuthUser(name: 'Test Agent', agentId: 'AGENT-123', tier: 'Gold'));
  }
}
