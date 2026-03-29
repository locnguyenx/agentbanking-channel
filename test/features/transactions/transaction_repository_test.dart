import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:decimal/decimal.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';

// Use a Fake for Dio for more predictable behavior with complex signatures
class FakeDio extends Fake implements Dio {
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
    if (path == '/api/v1/transactions/quote') {
      return Response(
        requestOptions: RequestOptions(path: path),
        data: {
          'amount': '100.0',
          'fee': '1.0',
          'commission': '0.5',
          'total': '101.0',
          'quoteId': 'QUOTE_123',
        },
        statusCode: 200,
      ) as Response<T>;
    } else if (path == '/api/v1/transactions/execute') {
      return Response(
        requestOptions: RequestOptions(path: path),
        data: {
          'status': 'SUCCESS',
          'referenceId': 'REF_123',
        },
        statusCode: 200,
      ) as Response<T>;
    }
    throw UnimplementedError('No Mock for $path');
  }

  @override
  Future<Response<T>> get<T>(
    String path, {
    Object? data, // Added in Dio 5.x
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    if (path == '/api/v1/transactions/proxy-enquiry') {
      return Response(
        requestOptions: RequestOptions(path: path, queryParameters: queryParameters),
        data: {'displayName': 'JOHN D***'},
        statusCode: 200,
      ) as Response<T>;
    }
    throw UnimplementedError('No Mock for $path');
  }
}

void main() {
  late TransactionRepository repository;
  late FakeDio fakeDio;

  setUp(() {
    fakeDio = FakeDio();
    repository = TransactionRepository(fakeDio);
  });

  group('TransactionRepository', () {
    test('getQuote returns valid quote response', () async {
      final request = TransactionQuoteRequest(
        serviceCode: 'CASH_WDL',
        amount: Decimal.parse('100.0'),
        agentId: 'AGENT007',
        fundingSource: FundingSource.CARD_EMV,
      );

      final response = await repository.getQuote(request);

      expect(response.amount, Decimal.parse('100.0'));
      expect(response.fee, Decimal.zero); // Local mock returns zero fee
      expect(response.quoteId, contains('LOCAL_QUOTE'));
    });

    test('executeTransaction returns success', () async {
      final request = TransactionExecutionRequest(
        quoteId: 'QUOTE123',
        fundingSource: FundingSource.CARD_EMV,
        pinBlock: 'PIN_BLOCK',
        cardToken: 'TOKEN_123',
      );

      final response = await repository.executeTransaction(request);

      expect(response.status, 'SUCCESS');
      expect(response.referenceId, equals('REF_123'));
    });

    test('performProxyEnquiry returns masked name', () async {
      final name = await repository.performProxyEnquiry('0123456789', 'NRIC');
      
      expect(name, contains('***'));
    });
  });
}
