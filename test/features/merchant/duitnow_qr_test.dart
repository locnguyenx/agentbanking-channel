import 'package:agentbanking_channel/core/network/dio_provider.dart';
import 'package:agentbanking_channel/features/auth/models/auth_models.dart';
import 'package:agentbanking_channel/features/auth/providers/auth_provider.dart';
import 'package:agentbanking_channel/features/auth/repositories/auth_repository.dart';
import 'package:agentbanking_channel/features/merchant/screens/retail_sale_screen.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart' as mockito;
import '../transactions/manual_mock_dio.dart';

class MockAuthRepository extends mockito.Fake implements AuthRepository {}

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
    await tester.pumpAndSettle();

    // Mock QR Generation
    mockDio.setResponse('/api/v1/retail/qr', {
      'qrPayload': 'duitnow-qr-payload-for-QR_TEST_123',
      'referenceId': 'QR_TEST_123',
    });

    // We expect 3 polls: PENDING, PENDING, then SUCCESS
    mockDio.setResponse('/api/v1/transfer/duitnow/status/.*', [
      {'status': 'PENDING'},
      {'status': 'PENDING'},
      {
        'status': 'SUCCESS',
        'mdrAmount': 0.25,
        'netToMerchant': 49.75,
        'transactionId': 'TXN-QR-999',
      },
    ]);

    // Mock balance inquiry after success
    mockDio.setResponse('/api/v1/agent/balance', {
      'availableBalance': 1000.0,
      'currency': 'MYR'
    });

    // 1. Enter amount
    await tester.enterText(find.byKey(const Key('input_amount')), '50.00');
    
    // 2. Select DuitNow QR
    await tester.tap(find.byType(DropdownButtonFormField<FundingSource>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('DuitNow QR (MDR 0.5%)').last);
    await tester.pumpAndSettle();

    // 3. Start Sale
    await tester.tap(find.text('PROCEED'));
    await tester.pump(); // Start quote
    await tester.pump(const Duration(seconds: 1)); // Quoting delay
    await tester.pump(); // Finish quote delay and start QR generation
    await tester.pump(); // Finish QR generation and update state to displayingQr

    expect(find.text('Scan to Pay'), findsOneWidget);
    expect(find.byKey(const Key('qr_code_display')), findsOneWidget);

    // 4. Advance time to trigger polls
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

    // Setup Mock Responses
    // Setup QR Generation Response
    mockDio.setResponse('/api/v1/retail/qr', {
      'qrPayload': 'duitnow-qr-payload-TIMEOUT',
      'referenceId': 'QR_TIMEOUT_123',
    });

    // Setup constant    // Polling Response - Stay PENDING to trigger timeout
    mockDio.setResponse('/api/v1/transfer/duitnow/status/.*', {
      'status': 'PENDING',
    });

    await tester.pumpAndSettle();

    // Enter amount and start sale
    await tester.enterText(find.byKey(const Key('input_amount')), '10.00');
    await tester.tap(find.byType(DropdownButtonFormField<FundingSource>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('DuitNow QR (MDR 0.5%)').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('PROCEED'));
    await tester.pump(); // Start quote
    await tester.pump(const Duration(seconds: 1)); // Quoting delay
    await tester.pump(); // Finish quote delay and start QR generation
    await tester.pump(); // Finish QR generation and update state to displayingQr

    // Fast forward 3 minutes (36 * 5s)
    for (int i = 0; i < 36; i++) {
       await tester.pump(const Duration(seconds: 5));
       await tester.pump(); // Allow polling result handling
    }
    await tester.pump(const Duration(seconds: 1)); // Final settling pump
    await tester.pumpAndSettle();

    // Verify Timeout Error
    expect(find.text('Error: QR_PAYMENT_TIMEOUT'), findsOneWidget);
  });
}
