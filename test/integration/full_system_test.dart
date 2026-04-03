import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:agentbanking_channel/main.dart';
import 'package:agentbanking_channel/core/network/dio_provider.dart';
import 'package:agentbanking_channel/features/auth/providers/auth_provider.dart';
import 'package:agentbanking_channel/features/auth/repositories/auth_repository.dart';
import 'package:agentbanking_channel/features/auth/models/auth_models.dart';

import 'full_system_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
  });

  testWidgets('JomPay Full Flow - Contract Verification', (tester) async {
    // 1. Setup Mock responses
    when(mockDio.options).thenReturn(BaseOptions());
    
    // Set surface size to ensure all widgets are "on screen" for the robot
    tester.view.physicalSize = const Size(1200, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    // Quote Response
    when(mockDio.post('/api/v1/transactions/quote', data: anyNamed('data')))
      .thenAnswer((_) async => Response(
        requestOptions: RequestOptions(path: '/api/v1/transactions/quote'),
        data: {
          'fee': '1.00',
          'commission': '0.50',
          'total': '101.00',
          'quoteId': 'Q-REAL-123',
        },
        statusCode: 200,
      ));

    // JomPay Execution Response
    when(mockDio.request<Object>(
      any,
      data: anyNamed('data'),
      options: anyNamed('options'),
      cancelToken: anyNamed('cancelToken'),
      onSendProgress: anyNamed('onSendProgress'),
      onReceiveProgress: anyNamed('onReceiveProgress'),
    )).thenAnswer((_) async => Response<Object>(
        requestOptions: RequestOptions(path: '/api/v1/billpayment/jompay'),
        data: {
          'status': 'SUCCESS',
          'transactionId': 'TXN-JOM-999',
          'message': 'Accepted',
        },
        statusCode: 200,
      ));

    // 2. Build App with Mock Overrides
    await tester.pumpWidget(ProviderScope(
      overrides: [
        dioProvider.overrideWithValue(mockDio),
        // Pre-auth the user
        authProvider.overrideWith((ref) => AuthNotifierMock()),
      ],
      child: const AgentBankingApp(),
    ));
    await tester.pumpAndSettle();

    // 3. Login
    await tester.enterText(find.widgetWithText(TextField, 'Agent ID'), 'REAL-AGENT-456');
    await tester.enterText(find.widgetWithText(TextField, 'Password'), 'password123');
    await tester.tap(find.text('LOGIN'));
    await tester.pumpAndSettle();

    // 4. Navigate to JomPay
    final jompayBtn = find.byKey(const Key('btn_jompay'));
    await tester.ensureVisible(jompayBtn);
    await tester.tap(jompayBtn);
    await tester.pumpAndSettle();

    // 4. Fill Form
    await tester.enterText(find.widgetWithText(TextFormField, 'Biller Code'), '5454');
    await tester.enterText(find.widgetWithText(TextFormField, 'Ref-1'), '1234567890');
    await tester.enterText(find.widgetWithText(TextFormField, 'Amount'), '100.00');
    
    await tester.tap(find.byKey(const Key('btn_main_action')));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // 5. Verify Quote and Confirm
    expect(find.textContaining('Confirm Details'), findsOneWidget);
    expect(find.textContaining('RM 1.00'), findsOneWidget); // Fee
    
    await tester.tap(find.byKey(const Key('btn_confirm')));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // 6. Verify Execution Result
    expect(find.byKey(const Key('status_success')), findsOneWidget);
    expect(find.textContaining('TXN-JOM-999'), findsOneWidget);

    // 7. Verify the last request payload (Idempotency Key format)
    final verification = verify(mockDio.request<Object>(
      captureAny,
      data: captureAnyNamed('data'),
      options: anyNamed('options'),
      cancelToken: anyNamed('cancelToken'),
      onSendProgress: anyNamed('onSendProgress'),
      onReceiveProgress: anyNamed('onReceiveProgress'),
    ));
    
    final capturedPaths = verification.captured.whereType<String>().toList();
    final capturedData = verification.captured.where((e) => e is! String).toList();

    // Find the JomPay request data
    dynamic jomPayData;
    for (int i = 0; i < capturedPaths.length; i++) {
       if (capturedPaths[i].contains('jompay')) {
         jomPayData = capturedData[i];
         break;
       }
    }

    String? idempotencyKey;
    String? billerCode;

    if (jomPayData is Map) {
      idempotencyKey = jomPayData['idempotencyKey'];
      billerCode = jomPayData['billerCode'];
    } else if (jomPayData is Iterable) {
      final list = jomPayData.toList();
      for (int i = 0; i < list.length; i += 2) {
        if (list[i] == 'idempotencyKey') idempotencyKey = list[i+1] as String?;
        if (list[i] == 'billerCode') billerCode = list[i+1] as String?;
      }
    }
    
    expect(idempotencyKey, isNotNull, reason: 'idempotencyKey should not be null for jompay request');
    final uuidRegex = RegExp(r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$');
    expect(uuidRegex.hasMatch(idempotencyKey!), isTrue, reason: 'idempotencyKey should be a valid UUID');
    expect(billerCode, '5454');
  });
}

class AuthNotifierMock extends AuthNotifier {
  AuthNotifierMock() : super(repository: FakeAuthRepository());

  @override
  Future<void> login(String agentId, String password) async {
    state = AuthState(
      status: AuthStatus.authenticated,
      user: AuthUser(agentId: 'REAL-AGENT-456', name: 'Test Agent', tier: 'PREMIER'),
    );
  }

  @override
  Future<void> loginBiometric() async {
    await login('fake', 'fake');
  }
}

class FakeAuthRepository extends Mock implements AuthRepository {}
