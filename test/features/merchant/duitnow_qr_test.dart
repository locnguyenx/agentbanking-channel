import 'package:agentbanking_channel/core/network/dio_provider.dart';
import 'package:agentbanking_channel/features/auth/models/auth_models.dart';
import 'package:agentbanking_channel/features/auth/providers/auth_provider.dart';
import 'package:agentbanking_channel/features/auth/repositories/auth_repository.dart';
import 'package:agentbanking_channel/features/merchant/providers/merchant_provider.dart';
import 'package:agentbanking_channel/features/merchant/screens/retail_sale_screen.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import '../transactions/manual_mock_dio.dart';

class MockAuthRepository extends AuthRepository {}

void main() {
  late ManualMockDio mockDio;

  setUp(() {
    mockDio = ManualMockDio();
  });

  Widget createTestWidget() {
    return ProviderScope(
      overrides: [
        dioProvider.overrideWith((ref) => mockDio),
        authProvider.overrideWith((ref) {
          final notifier = AuthNotifier(repository: MockAuthRepository());
          notifier.state = AuthState(
            status: AuthStatus.authenticated,
            user: AuthUser(agentId: 'AGENT-123', name: 'Test Agent', tier: 'AGENT'),
          );
          return notifier;
        }),
      ],
      child: const MaterialApp(
        home: RetailSaleScreen(),
      ),
    );
  }

  testWidgets('DuitNow QR Retail Sale polling success flow', (tester) async {
    await tester.pumpWidget(createTestWidget());

    // 1. Enter amount
    await tester.enterText(find.byType(TextField), '50.00');
    
    // 2. Select DuitNow QR
    await tester.tap(find.byType(DropdownButtonFormField<FundingSource>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('DuitNow QR (MDR 0.5%)').last);
    await tester.pumpAndSettle();

    // 3. Start Sale
    await tester.tap(find.text('PROCEED'));
    await tester.pump(); // Start quote
    await tester.pump(const Duration(seconds: 1)); // Quoting delay
    await tester.pump(); // Enter QR display state

    expect(find.text('Scan to Pay'), findsOneWidget);
    expect(find.byKey(const Key('qr_code_display')), findsOneWidget);

    // 4. Setup Mock Responses for Polling
    // We expect 3 polls: PENDING, PENDING, then SUCCESS
    mockDio.setResponse('/api/v1/transfer/duitnow/status/.*', [
      {'status': 'PENDING'},
      {'status': 'PENDING'},
      {'status': 'SUCCESS'},
    ]);

    // Setup final execution response
    mockDio.setResponse('/api/v1/retail/sale', {
      'status': 'SUCCESS',
      'transactionId': 'TXN-QR-999',
      'mdrAmount': 0.25,
      'netToMerchant': 49.75,
    });

    // Mock balance inquiry after success
    mockDio.setResponse('/api/v1/agent/balance', {
      'availableBalance': 1000.0,
      'currency': 'MYR'
    });

    // 5. Advance time to trigger polls
    // 1st Poll (5s)
    await tester.pump(const Duration(seconds: 5));
    expect(find.text('Waiting for customer payment...'), findsOneWidget);

    // 2nd Poll (5s)
    await tester.pump(const Duration(seconds: 5));
    expect(find.text('Waiting for customer payment...'), findsOneWidget);

    // 3rd Poll (5s) -> Transitions to Success
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();

    // 6. Verify Success Screen
    expect(find.text('Sale Success'), findsOneWidget);
    expect(find.textContaining('49.75'), findsOneWidget);
    expect(find.textContaining('0.25'), findsOneWidget);
  });

  testWidgets('DuitNow QR Retail Sale polling timeout flow', (tester) async {
    await tester.pumpWidget(createTestWidget());

    // Enter amount and start sale
    await tester.enterText(find.byType(TextField), '10.00');
    await tester.tap(find.byType(DropdownButtonFormField<FundingSource>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('DuitNow QR (MDR 0.5%)').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('PROCEED'));
    await tester.pumpAndSettle();

    // Setup constant PENDING response
    mockDio.setResponse('/api/v1/transfer/duitnow/status/.*', {'status': 'PENDING'});

    // Fast forward 3 minutes (36 * 5s)
    for (int i = 0; i < 36; i++) {
       await tester.pump(const Duration(seconds: 5));
    }
    await tester.pumpAndSettle();

    // Verify Timeout Error
    expect(find.text('Error: QR_PAYMENT_TIMEOUT'), findsOneWidget);
  });
}
