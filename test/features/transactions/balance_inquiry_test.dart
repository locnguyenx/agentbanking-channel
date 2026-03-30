import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agentbanking_channel/features/settlement/providers/float_provider.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:agentbanking_channel/features/transactions/screens/balance_inquiry_screen.dart';
import 'package:agentbanking_channel/api/api_providers.dart';
import 'package:agent_api/agent_api.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dio/dio.dart';
import 'package:agentbanking_channel/core/network/dio_provider.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
class ManualMockLedgerApi extends Mock implements LedgerControllerLedgerServiceApi {
  @override
  Future<Response<BalanceResponse>> balanceInquiry({
    BalanceInquiryExternalRequest? balanceInquiryExternalRequest,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return super.noSuchMethod(
      Invocation.method(#balanceInquiry, [], {#balanceInquiryExternalRequest: balanceInquiryExternalRequest}),
      returnValue: Future.value(Response<BalanceResponse>(requestOptions: RequestOptions(path: ''))),
    );
  }

  @override
  Future<Response<BalanceResponse>> getBalance({
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
      returnValue: Future.value(Response<BalanceResponse>(requestOptions: RequestOptions(path: ''))),
    );
  }
}

class ManualMockDio extends Mock implements Dio {
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
    
    when(mockDio.post(any, data: anyNamed('data'))).thenAnswer((_) async => Response(
      data: {'fee': 0.0, 'commission': 0.0, 'total': 0.0, 'quoteId': 'MOCK_QUOTE'},
      statusCode: 200,
      requestOptions: RequestOptions(path: ''),
    ));
  });

  testWidgets('Balance Inquiry follows full card flow and shows success', (tester) async {
    // Given
    final balanceResponse = BalanceResponse((b) => b
      ..availableBalance = 1234.56
      ..currency = 'MYR'
      ..lastTransactionId = 'TXN-123'
    );

    when(mockLedgerApi.balanceInquiry(
      balanceInquiryExternalRequest: anyNamed('balanceInquiryExternalRequest'),
    )).thenAnswer((_) async => Response(
      data: balanceResponse,
      statusCode: 200,
      requestOptions: RequestOptions(path: ''),
    ));

    when(mockLedgerApi.getBalance(
      agentId: anyNamed('agentId'),
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
        ],
        child: const MaterialApp(
          home: BalanceInquiryScreen(),
        ),
      ),
    );

    // Initial state: Loading (due to initial startTransaction in balanceInquiry call)
    // Actually BalanceInquiryScreen watches transactionProvider.
    // We need to trigger balanceInquiry.
    
    final container = ProviderScope.containerOf(tester.element(find.byType(BalanceInquiryScreen)));
    // Start
    container.read(transactionProvider.notifier).balanceInquiry('AGENT-123');

    await tester.pump(); // Start of quoting
    // Use findsAtLeastOneWidget or just wait a bit as it might jump fast
    
    await tester.pump(const Duration(milliseconds: 100)); // Should reach waitingConsent after getQuote
    expect(find.text('Status: waitingConsent...'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 600)); // Should reach waitingCard after 500ms delay
    expect(find.text('Status: waitingCard...'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 1100)); // Should reach waitingPin after 1s readCard delay
    expect(find.text('Status: waitingPin...'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 2500)); // Should finish everything
    await tester.pumpAndSettle();
    
    // Verify SUCCESS screen
    expect(find.text('Balance:'), findsOneWidget);
    expect(find.text('RM ****'), findsOneWidget); // Masked per Design
    expect(find.text('No funds were deducted'), findsOneWidget);
  });
}
