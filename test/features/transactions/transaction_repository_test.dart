import 'package:flutter_test/flutter_test.dart';
import 'package:decimal/decimal.dart';
import 'package:agent_api/agent_api.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';

class MockDio extends Mock implements Dio {
  @override
  Future<Response<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    if (path == '/api/v1/essp/purchase') {
      return Response(
        requestOptions: RequestOptions(path: path),
        data: {'status': 'SUCCESS', 'transactionId': 'ESSP_REF_123'} as T,
        statusCode: 200,
      );
    }
    throw UnimplementedError('MockDio.post for $path');
  }
}

class MockLedgerApi extends Mock implements LedgerControllerLedgerServiceApi {
  WithdrawalRequest? lastWithdrawalRequest;
  DepositRequest? lastDepositRequest;
  BalanceInquiryRequest? lastBalanceInquiryRequest;

  @override
  Future<Response<BuiltMap<String, JsonObject>>> debit({
    required WithdrawalRequest withdrawalRequest,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    lastWithdrawalRequest = withdrawalRequest;
    return Response(
      requestOptions: RequestOptions(path: ''),
      data: BuiltMap<String, JsonObject>({
        'status': JsonObject('SUCCESS'),
        'referenceId': JsonObject('REF_123'),
      }),
      statusCode: 200,
    );
  }

  @override
  Future<Response<BuiltMap<String, JsonObject>>> credit({
    required DepositRequest depositRequest,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    lastDepositRequest = depositRequest;
    return Response(
      requestOptions: RequestOptions(path: ''),
      data: BuiltMap<String, JsonObject>({
        'status': JsonObject('SUCCESS'),
        'referenceId': JsonObject('REF_123'),
      }),
      statusCode: 200,
    );
  }

  @override
  Future<Response<BuiltMap<String, JsonObject>>> balanceInquiry({
    required BalanceInquiryRequest balanceInquiryRequest,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    lastBalanceInquiryRequest = balanceInquiryRequest;
    return Response(
      requestOptions: RequestOptions(path: ''),
      data: BuiltMap<String, JsonObject>({
        'status': JsonObject('SUCCESS'),
        'referenceId': JsonObject('REF_123'),
      }),
      statusCode: 200,
    );
  }
}

class MockMerchantApi extends Mock implements MerchantControllerLedgerServiceApi {
  RetailSaleCommand? lastRetailSaleCommand;
  CashBackCommand? lastCashBackCommand;
  PinPurchaseCommand? lastPinPurchaseCommand;

  @override
  Future<Response<RetailSaleResponse>> processRetailSale({
    required RetailSaleCommand retailSaleCommand,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    lastRetailSaleCommand = retailSaleCommand;
    return Response(
      requestOptions: RequestOptions(path: ''),
      data: RetailSaleResponse((b) => b
        ..status = 'SUCCESS'
        ..transactionId = 'TRANS_123'
        ..netToMerchant = 98.0
        ..mdrAmount = 2.0
      ),
      statusCode: 200,
    );
  }

  @override
  Future<Response<CashBackResponse>> processCashBack({
    required CashBackCommand cashBackCommand,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    lastCashBackCommand = cashBackCommand;
    return Response(
      requestOptions: RequestOptions(path: ''),
      data: CashBackResponse((b) => b
        ..status = 'SUCCESS'
        ..transactionId = 'TRANS_456'
        ..cashBackAmount = cashBackCommand.cashBackAmount
      ),
      statusCode: 200,
    );
  }

  @override
  Future<Response<PinPurchaseResponse>> processPinPurchase({
    required PinPurchaseCommand pinPurchaseCommand,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    lastPinPurchaseCommand = pinPurchaseCommand;
    return Response(
      requestOptions: RequestOptions(path: ''),
      data: PinPurchaseResponse((b) => b
        ..status = 'SUCCESS'
        ..transactionId = 'PIN_123'
        ..pinCode = '8888-9999'
        ..commission = 0.5
      ),
      statusCode: 200,
    );
  }
}

class MockBillerApi extends Mock implements BillerControllerBillerServiceApi {
  @override
  Future<Response<BuiltMap<String, JsonObject>>> payBill({
    required BuiltMap<String, JsonObject> requestBody,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return Response(
      requestOptions: RequestOptions(path: ''),
      data: BuiltMap<String, JsonObject>({
        'status': JsonObject('SUCCESS'),
        'referenceId': JsonObject('BILL_REF_123'),
      }),
      statusCode: 200,
    );
  }

  @override
  Future<Response<BuiltMap<String, JsonObject>>> topup({
    required BuiltMap<String, JsonObject> requestBody,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return Response(
      requestOptions: RequestOptions(path: ''),
      data: BuiltMap<String, JsonObject>({
        'status': JsonObject('SUCCESS'),
        'referenceId': JsonObject('TOPUP_REF_123'),
      }),
      statusCode: 200,
    );
  }
}

class MockSwitchApi extends Mock implements SwitchControllerSwitchAdapterServiceApi {
  @override
  Future<Response<JsonObject>> duitNowTransfer({
    required DuitNowRequest duitNowRequest,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return Response(
      requestOptions: RequestOptions(path: ''),
      data: JsonObject({'status': 'SUCCESS', 'referenceId': 'DN_REF_123'}),
      statusCode: 200,
    );
  }
}

class MockOnboardingApi extends Mock implements OnboardingControllerOnboardingServiceApi {}

class MockEsspApi extends Mock implements EsspControllerBillerServiceApi {
  @override
  Future<Response<BuiltMap<String, JsonObject>>> purchase({
    required BuiltMap<String, JsonObject> requestBody,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return Response(
      requestOptions: RequestOptions(path: ''),
      data: BuiltMap<String, JsonObject>({
        'status': JsonObject('SUCCESS'), 
        'transactionId': JsonObject('ESSP_REF_123')
      }),
      statusCode: 200,
    );
  }
}

void main() {
  late TransactionRepository repository;
  late MockLedgerApi mockLedgerApi;
  late MockMerchantApi mockMerchantApi;
  late MockBillerApi mockBillerApi;
  late MockSwitchApi mockSwitchApi;
  late MockOnboardingApi mockOnboardingApi;
  late MockEsspApi mockEsspApi;
  late MockDio mockDio;

  setUp(() {
    mockLedgerApi = MockLedgerApi();
    mockMerchantApi = MockMerchantApi();
    mockSwitchApi = MockSwitchApi();
    mockBillerApi = MockBillerApi();
    mockOnboardingApi = MockOnboardingApi();
    mockEsspApi = MockEsspApi();
    mockDio = MockDio();
    repository = TransactionRepository(
      ledgerApi: mockLedgerApi,
      merchantApi: mockMerchantApi,
      switchApi: mockSwitchApi,
      billerApi: mockBillerApi,
      onboardingApi: mockOnboardingApi,
      esspApi: mockEsspApi,
      dio: mockDio,
    );
  });

  group('TransactionRepository', () {
    test('executeTransaction (ESSP_PURCHASE) returns success', () async {
      final request = TransactionExecutionRequest(
        quoteId: 'QUOTE_ESSP',
        fundingSource: FundingSource.CASH,
        serviceCode: 'ESSP_PURCHASE',
        amount: Decimal.parse('20.0'),
        metadata: {'productCode': 'ESSP_TOKEN_V2'},
      );

      final response = await repository.executeTransaction(request);

      expect(response.status, 'SUCCESS');
      expect(response.referenceId, equals('ESSP_REF_123'));
    });

    test('executeTransaction (Withdrawal) returns success with metadata mapping', () async {
      final request = TransactionExecutionRequest(
        quoteId: 'QUOTE123',
        fundingSource: FundingSource.CARD_EMV,
        pinBlock: 'PIN_BLOCK',
        cardToken: 'TOKEN_123',
        serviceCode: 'CASH_WITHDRAWAL',
        amount: Decimal.parse('100.0'),
        metadata: {
          'geofenceLat': '3.1390',
          'geofenceLng': '101.6869',
          'customerCardMasked': 'XXXX-XXXX-XXXX-1234',
        },
      );

      final response = await repository.executeTransaction(request);

      expect(response.status, 'SUCCESS');
      expect(response.referenceId, equals('REF_123'));
      
      // Verify the withdrawal request mapping
      final captured = mockLedgerApi.lastWithdrawalRequest!;
      expect(captured.geofenceLat, 3.1390);
      expect(captured.geofenceLng, 101.6869);
      expect(captured.customerCardMasked, 'XXXX-XXXX-XXXX-1234');
      expect(captured.amount, 100.0);
    });

    test('executeTransaction (Deposit) returns success with destinationAccount', () async {
      final request = TransactionExecutionRequest(
        quoteId: 'QUOTE123',
        fundingSource: FundingSource.CASH,
        serviceCode: 'CASH_DEPOSIT',
        amount: Decimal.parse('500.0'),
        metadata: {
          'destinationAccount': '1234567890',
        },
      );

      final response = await repository.executeTransaction(request);

      expect(response.status, 'SUCCESS');
      expect(response.referenceId, equals('REF_123'));

      final captured = mockLedgerApi.lastDepositRequest!;
      expect(captured.amount, 500.0);
      expect(captured.destinationAccount, '1234567890');
    });

    test('executeTransaction (BILL_PAY) returns success', () async {
      final request = TransactionExecutionRequest(
        quoteId: 'QUOTE_BILL',
        fundingSource: FundingSource.CASH,
        serviceCode: 'BILL_PAY',
        amount: Decimal.parse('50.0'),
      );

      final response = await repository.executeTransaction(request);

      expect(response.status, 'SUCCESS');
      expect(response.referenceId, equals('BILL_REF_123'));
    });

    test('executeTransaction (TOP_UP) returns success', () async {
      final request = TransactionExecutionRequest(
        quoteId: 'QUOTE_TOPUP',
        fundingSource: FundingSource.CASH,
        serviceCode: 'TOP_UP',
        amount: Decimal.parse('30.0'),
      );

      final response = await repository.executeTransaction(request);

      expect(response.status, 'SUCCESS');
      expect(response.referenceId, equals('TOPUP_REF_123'));
    });

    test('initiateDuitNow returns success', () async {
      final response = await repository.initiateDuitNow(
        quoteId: 'QUOTE_DN',
        proxyId: '0123456789',
        proxyType: 'MSISDN',
        amount: Decimal.parse('50.0'),
      );
      expect(response.status, 'SUCCESS');
    });

    test('executeRetailSale returns success', () async {
      final response = await repository.executeRetailSale(Decimal.parse('100.0'), 'CARD');
      expect(response.receiptReference, 'TRANS_123');
      expect(response.floatCreditAmount, Decimal.parse('98.0'));
      expect(mockMerchantApi.lastRetailSaleCommand?.amount, 100.0);
    });

    test('executeCashback returns success', () async {
      final response = await repository.executeCashback(Decimal.parse('100.0'), Decimal.parse('20.0'), 'CARD');
      expect(response.receiptReference, 'TRANS_456');
      expect(response.cashBackAmount, Decimal.parse('20.0'));
      expect(mockMerchantApi.lastCashBackCommand?.cashBackAmount, 20.0);
    });

    test('executePinPurchase returns success', () async {
      final response = await repository.executePinPurchase(Decimal.parse('50.0'), 'CELCOM_50');
      expect(response.pinCode, '8888-9999');
      expect(response.receiptReference, 'PIN_123');
    });
  });
}
