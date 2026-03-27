import 'package:decimal/decimal.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';
import 'package:agentbanking_channel/features/settlement/providers/float_provider.dart';
import 'package:agentbanking_channel/features/settlement/repositories/float_repository.dart';
import 'package:agentbanking_channel/features/hardware/hardware_interfaces.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';

import 'transaction_provider_test.mocks.dart';

@GenerateMocks([TransactionRepository, FloatRepository, ICardReader, IPinPad, FloatNotifier])
void main() {
  late TransactionNotifier notifier;
  late MockTransactionRepository mockRepo;
  late MockICardReader mockCardReader;
  late MockIPinPad mockPinPad;
  late MockFloatNotifier mockFloatNotifier;

  setUp(() {
    mockRepo = MockTransactionRepository();
    mockCardReader = MockICardReader();
    mockPinPad = MockIPinPad();
    mockFloatNotifier = MockFloatNotifier();
    
    notifier = TransactionNotifier(
      repository: mockRepo,
      cardReader: mockCardReader,
      pinPad: mockPinPad,
      floatNotifier: mockFloatNotifier,
    );
  });

  test('balanceInquiry flow sets state correctly', () async {
    final mockQuote = TransactionQuoteResponse(
      amount: Decimal.zero,
      fee: Decimal.parse('0.0'),
      commission: Decimal.parse('0.0'),
      total: Decimal.parse('0.0'),
      quoteId: 'Q-123',
    );

    final mockResult = TransactionExecutionResponse(
      status: 'SUCCESS',
      referenceId: 'R-456',
      balance: Decimal.parse('1500.0'),
      currency: 'MYR',
    );

    when(mockRepo.getQuote(any)).thenAnswer((_) async => mockQuote);
    when(mockCardReader.readCard()).thenAnswer((_) async => CardData(maskedPan: '123', cardToken: 'tk'));
    when(mockPinPad.capturePin()).thenAnswer((_) async => 'pin');
    when(mockRepo.executeTransaction(any)).thenAnswer((_) async => mockResult);
    when(mockFloatNotifier.fetchLatestBalance()).thenAnswer((_) async => Future.value());

    await notifier.balanceInquiry('AGENT-001');

    expect(notifier.state.status, TransactionStatus.success);
    expect(notifier.state.result?.balance, equals(Decimal.parse('1500.0')));
    verify(mockFloatNotifier.fetchLatestBalance()).called(1);
  });
}
