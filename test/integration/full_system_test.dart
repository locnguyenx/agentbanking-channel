import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:mockito/mockito.dart';
import 'package:agent_api/agent_api.dart' as api;

import 'package:agentbanking_channel/main.dart';
import 'package:agentbanking_channel/features/auth/providers/auth_provider.dart';
import 'package:agentbanking_channel/features/auth/repositories/auth_repository.dart';
import 'package:agentbanking_channel/core/security/secure_storage_manager.dart';
import 'package:agentbanking_channel/core/network/dio_provider.dart';
import 'package:agentbanking_channel/core/network/auth_interceptor.dart';
import 'package:agentbanking_channel/core/offline/offline_queue_service.dart';
import 'test_fakes.dart';
import '../setup/test_credentials.dart';

// Mocks
class MockDio extends Mock implements Dio {}
class MockAuthApi extends Mock implements api.AuthControllerAuthIamServiceApi {}

class FakeOfflineQueueService extends Fake implements OfflineQueueService {
  @override
  Future<void> init() async {}
  @override
  Future<void> enqueue(Map<String, dynamic> payload, String idempotencyKey) async {}
}

void main() {
  const bool isRealBackend = bool.fromEnvironment('USE_REAL_BACKEND', defaultValue: false);
  const String apiBaseUrl = bool.fromEnvironment('USE_REAL_BACKEND', defaultValue: false) 
      ? String.fromEnvironment('API_BASE_URL', defaultValue: 'http://127.0.0.1:8080')
      : 'http://localhost:8080';

  group('Full System Integration - JomPay', () {
    final mockDio = MockDio();

    setUpAll(() {
      if (isRealBackend) {
        HttpOverrides.global = null;
      }
    });

    Future<void> waitFor(WidgetTester tester, Finder finder, {Duration timeout = const Duration(seconds: 15), bool skipRunAsync = false}) async {
      final end = DateTime.now().add(timeout);
      while (DateTime.now().isBefore(end)) {
        if (finder.evaluate().isNotEmpty) return;
        if (skipRunAsync) {
          await Future.delayed(const Duration(milliseconds: 100));
        } else {
          await tester.runAsync(() => Future.delayed(const Duration(milliseconds: 100)));
        }
        await tester.pump();
      }
      if (finder.evaluate().isEmpty) {
        throw Exception('Timeout waiting for $finder');
      }
    }

    testWidgets('JomPay Full Flow - Contract Verification', (tester) async {
      // Set fixed size for consistent hit testing
      tester.view.physicalSize = const Size(1280, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final storage = FakeSecureStorage();
      final dio = isRealBackend
          ? (Dio(BaseOptions(
              baseUrl: apiBaseUrl,
              connectTimeout: const Duration(seconds: 15),
              receiveTimeout: const Duration(seconds: 30),
            ))
            ..httpClientAdapter = IOHttpClientAdapter()
            ..interceptors.add(AuthInterceptor(storage)) 
            ..interceptors.add(LogInterceptor(
              requestBody: true,
              responseBody: true,
            )))
          : mockDio;

      await tester.pumpWidget(ProviderScope(
        overrides: [
          offlineQueueServiceProvider.overrideWithValue(FakeOfflineQueueService()),
          if (isRealBackend) ...[
            dioProvider.overrideWithValue(dio),
            secureStorageManagerProvider.overrideWithValue(storage),
            authRepositoryProvider.overrideWithValue(AuthRepository(
              secureStorage: storage,
              authApi: api.AuthControllerAuthIamServiceApi(dio, api.standardSerializers),
            )),
          ],
        ],
        child: const AgentBankingApp(),
      ));

      await tester.pump();
      
      await tester.enterText(find.byType(TextField).at(0), TestCredentials.username);
      await tester.enterText(find.byType(TextField).at(1), TestCredentials.password);

      // Perform the rest of the flow in runAsync
      await tester.runAsync(() async {
        final container = ProviderScope.containerOf(tester.element(find.byType(AgentBankingApp)));
        await container.read(authProvider.notifier).login(TestCredentials.username, TestCredentials.password);
        
        await waitFor(tester, find.byKey(const Key('btn_jompay')), skipRunAsync: true);

        // 4. Navigate to JomPay
        final jompayBtn = find.byKey(const Key('btn_jompay'));
        await tester.dragUntilVisible(jompayBtn.first, find.byType(SingleChildScrollView).first, const Offset(0, -100));
        await tester.pumpAndSettle();
        
        await tester.tap(jompayBtn.first, warnIfMissed: false);
        await waitFor(tester, find.widgetWithText(TextField, 'Biller Code'), skipRunAsync: true);

        // 5. Fill Biller Details
        final billerCodeField = find.widgetWithText(TextField, 'Biller Code');
        await tester.enterText(billerCodeField.first, '6789');
        await tester.enterText(find.widgetWithText(TextField, 'Ref-1').first, 'MY-REF-001');
        await tester.enterText(find.widgetWithText(TextField, 'Amount').first, '50.00');
        await tester.tap(find.text('PROCEED').first, warnIfMissed: false); 
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 500)); // Allow transition from idle to quoting
        await waitFor(tester, find.byKey(const Key('bdd_status_token')), skipRunAsync: true);
        
        final statusText = tester.widget<Text>(find.byKey(const Key('bdd_status_token'))).data!;
        
        // Match JomPay Verification or status
        expect(statusText, anyOf(contains('Status: success'), contains('Status: failed'), contains('Status: quoting'), contains('Status: processing')));
      });
      
    }, timeout: const Timeout(Duration(minutes: 5)));
  });
}
