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
import 'package:agentbanking_channel/features/transactions/screens/jompay_form.dart';
import 'package:agentbanking_channel/features/compliance/providers/compliance_provider.dart';
import 'package:agentbanking_channel/features/settlement/services/eod_timer_service.dart';
import 'package:agentbanking_channel/features/hardware/hardware_interfaces.dart';
import 'package:agentbanking_channel/core/offline/offline_queue_service.dart';
import 'package:agentbanking_channel/core/security/secure_storage_manager.dart';
import 'package:agentbanking_channel/features/transactions/services/reversal_service.dart';
import 'package:agentbanking_channel/features/settlement/providers/float_provider.dart';
import 'package:agentbanking_channel/features/settlement/repositories/float_repository.dart';
import 'package:agentbanking_channel/features/settlement/models/float_models.dart';
import 'package:geolocator_platform_interface/geolocator_platform_interface.dart';
import 'manual_mock_dio.dart';

class FakeSecureStorageManager extends Fake implements SecureStorageManager {
  @override
  Future<bool> getComplianceLocked() async => false;
  @override
  Future<void> setComplianceLock(bool locked) async {}
  @override
  Future<String> getSqlCipherPassphrase() async => 'test-passphrase';
}

class FakeAuthRepository extends Fake implements AuthRepository {
  @override
  Future<AuthUser> login(String id, String pass) async => AuthUser(agentId: id, name: 'Test', tier: 'GOLD');
}

class ManualReversalService implements ReversalService {
  @override
  Future<void> queueReversal(Map<String, dynamic> originalRequest) async {}
}

class FakeFloatRepository extends Fake implements FloatRepository {
  @override
  Future<FloatLedger> getFloatStatus(String agentId) async {
    return FloatLedger(currentBalance: Decimal.parse('5000.0'), limit: Decimal.parse('10000.0'));
  }
}

class ManualFloatNotifier extends FloatNotifier {
  ManualFloatNotifier() : super(FakeFloatRepository(), null, startTimer: false);
  @override
  Future<void> fetchLatestBalance() async {
    // No-op for integration test
  }
}

class FakeGeolocatorPlatform extends Fake implements GeolocatorPlatform {
  @override
  Future<Position> getCurrentPosition({LocationSettings? locationSettings}) async {
    return Position(
      latitude: 3.1390, longitude: 101.6869,
      timestamp: DateTime.now(), accuracy: 1.0, altitude: 0.0, heading: 0.0, speed: 0.0, speedAccuracy: 0.0,
      altitudeAccuracy: 0.0, headingAccuracy: 0.0,
    );
  }
}

class MockCardReader extends Fake implements ICardReader {
  @override
  Future<bool> isAvailable() async => true;
  @override
  Future<CardData?> readCard() async => CardData(maskedPan: '123', cardToken: 'tk');
}

class MockPinPad extends Fake implements IPinPad {
  @override
  Future<bool> isAvailable() async => true;
  @override
  Future<String?> capturePin() async => 'pin';
}

class MockMyKadScanner extends Fake implements IMyKadScanner {
  @override
  Future<bool> isAvailable() async => true;
  @override
  Future<MyKadData?> scanMyKad() async => null;
}

class ManualOfflineQueueService implements OfflineQueueService {
  @override
  Future<void> init() async {}
  @override
  Future<void> enqueue(Map<String, dynamic> payload, String idempotencyKey) async {}
  @override
  Future<List<Map<String, dynamic>>> getPending() async => [];
  @override
  Future<void> remove(int id) async {}
  @override
  Future<int> getCount() async => 0;
  @override
  Stream<int> get queueCountStream => Stream.value(0);
}

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
      // Sequence of responses for polling
      mockDio.setResponse('/api/v1/bill/status/TX-JOM-456', [
        {'status': 'PENDING'},
        {'status': 'SUCCESS'},
      ]);
      
      // 2. Start App
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            dioProvider.overrideWithValue(mockDio),
            authProvider.overrideWith((ref) => AuthNotifierMock()),
            secureStorageManagerProvider.overrideWith((ref) => FakeSecureStorageManager()),
            reversalServiceProvider.overrideWith((ref) => ManualReversalService()),
            floatProvider.overrideWith((ref) => ManualFloatNotifier()),
            offlineQueueServiceProvider.overrideWith((ref) => ManualOfflineQueueService()),
            transactionProvider.overrideWith((ref) => TransactionNotifier(
              ref: ref,
              repository: ref.watch(transactionRepositoryProvider),
              cardReader: MockCardReader(),
              pinPad: MockPinPad(),
              floatNotifier: ref.watch(floatProvider.notifier),
              reversalService: ref.watch(reversalServiceProvider),
              myKadScanner: MockMyKadScanner(),
              complianceNotifier: ref.watch(complianceProvider.notifier),
              eodTimerService: ref.watch(eodTimerServiceProvider.notifier),
              geolocator: FakeGeolocatorPlatform(),
              pollingInterval: const Duration(milliseconds: 1),
            )),
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
      await tester.enterText(find.widgetWithText(TextFormField, 'Biller Code'), '5454');
      await tester.enterText(find.widgetWithText(TextFormField, 'Ref-1'), '1234567890');
      await tester.enterText(find.widgetWithText(TextFormField, 'Amount'), '100');
      await tester.tap(find.byKey(const Key('btn_main_action')));
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
      
      final container = ProviderScope.containerOf(tester.element(find.byType(AgentBankingApp)));
      
      // 1. Wait for submission to reach "Processing Biller..." state or "Success"
      // Since polling is 1ms, it will be very fast.
      await tester.pump(); 
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pump(); 

      // 4. Verify Success (poll until found to avoid race)
      bool found = false;
      for (int i = 0; i < 20; i++) {
         if (find.byKey(const Key('status_success')).evaluate().isNotEmpty) {
           found = true;
           break;
         }
         await tester.pump(const Duration(milliseconds: 50));
      }
      expect(found, isTrue, reason: 'Transaction should have completed successfully');
      expect(find.text('Reference ID'), findsOneWidget);
      expect(find.text('TX-JOM-456'), findsOneWidget);
      
      // Final cleanup frames
      await tester.pump(const Duration(seconds: 1));
    });
  });
}

class AuthNotifierMock extends AuthNotifier {
  AuthNotifierMock() : super(repository: FakeAuthRepository());

  @override
  Future<void> login(String agentId, String password) async {
    state = state.copyWith(status: AuthStatus.authenticated, user: AuthUser(name: 'Test Agent', agentId: 'AGENT-123', tier: 'Gold'));
  }

  @override
  Future<void> loginBiometric() async {
    state = state.copyWith(status: AuthStatus.authenticated, user: AuthUser(name: 'Test Agent', agentId: 'AGENT-123', tier: 'Gold'));
  }
}
