import 'dart:io';
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
import 'package:agentbanking_channel/core/network/geolocator_provider.dart';
import 'package:agentbanking_channel/core/offline/offline_queue_service.dart';
import 'package:agentbanking_channel/core/security/secure_storage_manager.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import '../setup/test_credentials.dart';
import 'test_fakes.dart';

import 'full_system_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  HttpOverrides.global = null;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
  });

  testWidgets('JomPay Full Flow - Contract Verification', (tester) async {
    final bool isRealBackend = const bool.fromEnvironment('USE_REAL_BACKEND', defaultValue: false);
    
    // 1. Setup Mock responses
    when(mockDio.options).thenReturn(BaseOptions());
    
    // Set surface size to ensure all widgets are "on screen" for the robot
    tester.view.physicalSize = const Size(1200, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    // Flexible Quote Response
    when(mockDio.request<Object>(
      any,
      data: anyNamed('data'),
      options: anyNamed('options'),
      cancelToken: anyNamed('cancelToken'),
      onSendProgress: anyNamed('onSendProgress'),
      onReceiveProgress: anyNamed('onReceiveProgress'),
    )).thenAnswer((_) async => Response<Object>(
        requestOptions: RequestOptions(path: '/api/v1/transactions/quote'),
        data: {
          'quoteId': 'Q-REAL-123',
          'amount': '100.0',
          'fee': '1.0',
          'commission': '0.5',
          'total': '101.0',
        },
        statusCode: 200,
      ));

    // Flexible Execution Response
    when(mockDio.request<Object>(
      argThat(allOf(contains('/api/v1/transactions'), isNot(contains('/quote')), isNot(contains('/status')))),
      data: anyNamed('data'),
      options: anyNamed('options'),
      cancelToken: anyNamed('cancelToken'),
      onSendProgress: anyNamed('onSendProgress'),
      onReceiveProgress: anyNamed('onReceiveProgress'),
    )).thenAnswer((_) async => Response<Object>(
        requestOptions: RequestOptions(path: '/api/v1/transactions'),
        data: {
          'status': 'PENDING',
          'workflowId': 'WF-JOM-123',
        },
        statusCode: 202,
      ));

    // Flexible Status Polling Response
    when(mockDio.request<Object>(
      argThat(contains('/api/v1/transactions/WF-JOM-123/status')),
      data: anyNamed('data'),
      options: anyNamed('options'),
      cancelToken: anyNamed('cancelToken'),
      onSendProgress: anyNamed('onSendProgress'),
      onReceiveProgress: anyNamed('onReceiveProgress'),
    )).thenAnswer((_) async => Response<Object>(
        requestOptions: RequestOptions(path: '/api/v1/transactions/WF-JOM-123/status'),
        data: {
          'status': 'COMPLETED',
          'workflowId': 'WF-JOM-123',
          'referenceNumber': 'TXN-JOM-999',
          'amount': 100.0,
        },
        statusCode: 200,
      ));

    // Auth Response (Real Handshake Verification)
    if (isRealBackend) {
      when(mockDio.request<Object>(
        argThat(contains('/api/v1/auth/token')),
        data: anyNamed('data'),
        options: anyNamed('options'),
        cancelToken: anyNamed('cancelToken'),
        onSendProgress: anyNamed('onSendProgress'),
        onReceiveProgress: anyNamed('onReceiveProgress'),
      )).thenAnswer((_) async => Response<Object>(
          requestOptions: RequestOptions(path: '/api/v1/auth/token'),
          data: {
            'access_token': 'REAL-VAL-JWT-123',
            'refresh_token': 'REAL-VAL-REFRESH-123',
            'expires_in': 3600,
            'token_type': 'Bearer',
          },
          statusCode: 200,
        ));
    }

    // 2. Build App with Mock Overrides
    await tester.pumpWidget(ProviderScope(
      overrides: [
        dioProvider.overrideWithValue(mockDio),
        // Pre-auth the user: only if NOT in real backend mode
        if (!isRealBackend) authProvider.overrideWith((ref) => AuthNotifierMock()),
        geolocatorProvider.overrideWithValue(FakeGeolocator()),
        if (!isRealBackend) secureStorageManagerProvider.overrideWithValue(FakeSecureStorage()),
        floatProvider.overrideWith((ref) => FloatNotifier(ref.watch(floatRepositoryProvider), 'AGENT-123', startTimer: false)),
      ],
      child: const AgentBankingApp(),
    ));
    await tester.pumpAndSettle();

    // 3. Login
    await tester.enterText(find.widgetWithText(TextField, 'Agent ID'), TestCredentials.username);
    await tester.enterText(find.widgetWithText(TextField, 'Password'), TestCredentials.password);
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
    await tester.pumpAndSettle();

    final confirmDetails = find.textContaining('Confirm Details');
    expect(confirmDetails, findsOneWidget);
    expect(find.textContaining('RM 1.00'), findsOneWidget); // Fee
    
    await tester.tap(find.byKey(const Key('btn_confirm')));
    await tester.pumpAndSettle(const Duration(seconds: 5));

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
       if (capturedPaths[i] == '/api/v1/transactions') {
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
    
    expect(idempotencyKey, isNotNull, reason: 'idempotencyKey should not be null for orchestrator request');
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
      user: AuthUser(agentId: TestCredentials.username, name: 'Test Agent', tier: 'PREMIER'),
    );
  }

  @override
  Future<void> loginBiometric() async {
    await login('fake', 'fake');
  }
}

class FakeAuthRepository extends Mock implements AuthRepository {}
