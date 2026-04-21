import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agentbanking_channel/features/settlement/providers/float_provider.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:agentbanking_channel/features/transactions/screens/balance_inquiry_screen.dart';
import 'package:agentbanking_channel/api/api_providers.dart';
import 'package:agent_api/agent_api.dart' as api;
import 'package:mockito/mockito.dart' as mockito;
import 'package:dio/dio.dart';
import 'package:agentbanking_channel/core/network/dio_provider.dart';
import 'package:agentbanking_channel/features/settlement/repositories/float_repository.dart';
import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';
import 'package:agentbanking_channel/features/hardware/hardware_interfaces.dart';
import 'package:agentbanking_channel/features/transactions/services/reversal_service.dart';
import 'package:agentbanking_channel/features/compliance/providers/compliance_provider.dart';
import 'package:agentbanking_channel/features/settlement/services/eod_timer_service.dart';
import 'package:agentbanking_channel/features/settlement/models/float_models.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/core/security/secure_storage_manager.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator_platform_interface/geolocator_platform_interface.dart';

class FakeTransactionRepository extends mockito.Fake implements TransactionRepository {
  @override
  Future<TransactionQuoteResponse> getQuote(TransactionQuoteRequest req) async => 
    TransactionQuoteResponse(amount: req.amount, fee: Decimal.zero, total: req.amount, quoteId: 'Q-123', commission: Decimal.zero);
  @override
  Future<TransactionExecutionResponse> executeTransaction(TransactionExecutionRequest req, String agentId, {String? idempotencyKey}) async => 
    TransactionExecutionResponse(status: 'SUCCESS', referenceId: 'REF-123');
  @override
  Future<TransactionExecutionResponse> balanceInquiry(TransactionExecutionRequest request, String agentId) async {
    await Future.delayed(const Duration(milliseconds: 50));
    return TransactionExecutionResponse(status: 'SUCCESS', referenceId: 'REF-BAL-123', balance: Decimal.fromInt(1000), currency: 'MYR');
  }
}

class FakeCardReader extends mockito.Fake implements ICardReader {
  @override
  Future<bool> isAvailable() async => true;
  @override
  Future<CardData?> readCard() async {
    await Future.delayed(const Duration(milliseconds: 50));
    return CardData(pan: '1234567890123456', cardToken: 'TOK-123');
  }
}

class FakePinPad extends mockito.Fake implements IPinPad {
  @override
  Future<bool> isAvailable() async => true;
  @override
  Future<String> getPinBlock(String pan, String amount) async => 'PIN-BLOCK-123';
  @override
  Future<String?> capturePin() async {
    await Future.delayed(const Duration(milliseconds: 50));
    return 'PIN-BLOCK-123';
  }
}

class FakeReversalService extends mockito.Fake implements ReversalService {
  @override
  Future<void> queueReversal(Map<String, dynamic> req) async {}
}

class ManualMyKadScanner extends mockito.Fake implements IMyKadScanner {
  @override
  Future<bool> isAvailable() async => true;
  @override
  Future<MyKadData?> scanMyKad() async => null;
}

class FakeGeolocatorPlatform extends mockito.Fake implements GeolocatorPlatform {
  @override
  Future<Position> getCurrentPosition({LocationSettings? locationSettings}) async => 
    Position(latitude: 0, longitude: 0, timestamp: DateTime.now(), accuracy: 0, altitude: 0, heading: 0, speed: 0, speedAccuracy: 0, altitudeAccuracy: 0, headingAccuracy: 0, floor: 0, isMocked: false);
}

class FakeSecureStorageManager extends mockito.Fake implements SecureStorageManager {
  @override
  Future<bool> getComplianceLocked() async => false;
  @override
  Future<void> setComplianceLock(bool locked) async {}
  @override
  Future<String> getSqlCipherPassphrase() async => 'test-pass';
}

class ManualMockComplianceNotifier extends ComplianceNotifier {
  ManualMockComplianceNotifier() : super(secureStorage: FakeSecureStorageManager());
}

class FakeEodTimerService extends Fake implements EodTimerService {
  @override
  EodStatus getCurrentEodStatus() => EodStatus.open;
}

class FakeFloatRepository extends mockito.Fake implements FloatRepository {
  @override
  Future<FloatLedger> getFloatStatus(String agentId) async => 
    FloatLedger(currentBalance: Decimal.fromInt(1000), limit: Decimal.fromInt(10000));
}

class ManualFloatNotifier extends FloatNotifier {
  ManualFloatNotifier() : super(FakeFloatRepository(), 'AGENT-123', startTimer: false);
}

class ManualMockLedgerApi extends mockito.Mock implements api.LedgerControllerLedgerServiceApi {
  @override
  Future<Response<api.BalanceInquiry200Response>> balanceInquiry({
    api.BalanceInquiryExternalRequest? balanceInquiryExternalRequest,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return super.noSuchMethod(
      Invocation.method(#balanceInquiry, [], {#balanceInquiryExternalRequest: balanceInquiryExternalRequest}),
      returnValue: Future.value(Response<api.BalanceInquiry200Response>(requestOptions: RequestOptions(path: ''))),
    );
  }

  @override
  Future<Response<api.BalanceResponse>> getBalance({
    String? agentId,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return super.noSuchMethod(
      Invocation.method(#getBalance, [], {#agentId: agentId}),
      returnValue: Future.value(Response<api.BalanceResponse>(requestOptions: RequestOptions(path: ''))),
    );
  }
}

class ManualMockDio extends mockito.Mock implements Dio {
  @override
  Future<Response<T>> post<T>(
    String? path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) => super.noSuchMethod(
    Invocation.method(#post, [path], {
      #data: data,
      #queryParameters: queryParameters,
      #options: options,
      #cancelToken: cancelToken,
      #onSendProgress: onSendProgress,
      #onReceiveProgress: onReceiveProgress,
    }),
    returnValue: Future.value(Response<T>(requestOptions: RequestOptions(path: path ?? ''))),
  );
}

void main() {
  late ManualMockLedgerApi mockLedgerApi;
  late ManualMockDio mockDio;

  setUp(() {
    mockLedgerApi = ManualMockLedgerApi();
    mockDio = ManualMockDio();
    
    mockito.when(mockDio.post(mockito.any, data: mockito.anyNamed('data'))).thenAnswer((_) async => Response(
      data: {'fee': 0.0, 'commission': 0.0, 'total': 0.0, 'quoteId': 'MOCK_QUOTE'},
      statusCode: 200,
      requestOptions: RequestOptions(path: ''),
    ));
  });

  testWidgets('Balance Inquiry follows full card flow and shows success', (tester) async {
    final balanceResponse = api.BalanceInquiry200Response((b) => b
      ..balance = 1234.56
      ..currency = 'MYR'
      ..status = 'SUCCESS'
    );

    mockito.when(mockLedgerApi.balanceInquiry(
      balanceInquiryExternalRequest: mockito.anyNamed('balanceInquiryExternalRequest'),
    )).thenAnswer((_) async => Response(
      data: balanceResponse,
      statusCode: 200,
      requestOptions: RequestOptions(path: ''),
    ));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          ledgerApiProvider.overrideWithValue(mockLedgerApi),
          dioProvider.overrideWithValue(mockDio),
          transactionProvider.overrideWith((ref) => TransactionNotifier(
            ref: ref,
            repository: FakeTransactionRepository(),
            cardReader: FakeCardReader(),
            pinPad: FakePinPad(),
            floatNotifier: ManualFloatNotifier(),
            reversalService: FakeReversalService(),
            myKadScanner: ManualMyKadScanner(),
            complianceNotifier: ManualMockComplianceNotifier(),
            eodTimerService: FakeEodTimerService(),
            geolocator: FakeGeolocatorPlatform(),
            cardTimerDelay: const Duration(seconds: 1),
          )),
        ],
        child: const MaterialApp(
          home: BalanceInquiryScreen(),
        ),
      ),
    );

    final container = ProviderScope.containerOf(tester.element(find.byType(BalanceInquiryScreen)));
    container.read(transactionProvider.notifier).balanceInquiry('AGENT-123');

    await tester.pump();
    // 0ms: waitingCard
    expect(find.byKey(const Key('bdd_status_token')), findsOneWidget);
    final statusText = tester.widget<Text>(find.byKey(const Key('bdd_status_token'))).data ?? '';
    expect(statusText, contains('waitingCard'));

    await tester.pump(const Duration(milliseconds: 70)); // Advance past readCard (50ms)
    // Now at waitingPin
    expect(find.byKey(const Key('bdd_status_token')), findsOneWidget);
    final statusText2 = tester.widget<Text>(find.byKey(const Key('bdd_status_token'))).data ?? '';
    expect(statusText2, contains('waitingPin'));

    await tester.pump(const Duration(milliseconds: 70)); // Advance past capturePin (50ms)
    // Now at processing
    expect(find.byKey(const Key('bdd_status_token')), findsOneWidget);
    final statusText3 = tester.widget<Text>(find.byKey(const Key('bdd_status_token'))).data ?? '';
    expect(statusText3, contains('processing'));

    await tester.pump(const Duration(milliseconds: 2500));
    await tester.pumpAndSettle();
    
    expect(find.text('Balance:'), findsOneWidget);
    expect(find.text('RM ****'), findsOneWidget);
    expect(find.text('No funds were deducted'), findsOneWidget);
  });
}
