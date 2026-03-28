import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:decimal/decimal.dart';
import 'package:mockito/annotations.dart';
import 'package:agentbanking_channel/features/merchant/providers/merchant_provider.dart';
import 'package:agentbanking_channel/features/merchant/models/merchant_models.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';
import 'package:agentbanking_channel/features/hardware/hardware_interfaces.dart';
import 'package:agentbanking_channel/features/settlement/providers/float_provider.dart';

// Reuse mocks or generate new ones
@GenerateMocks([TransactionRepository, ICardReader, IPinPad, FloatNotifier])
import 'merchant_provider_test.mocks.dart';

void main() {
  late MerchantNotifier notifier;
  late MockTransactionRepository mockRepo;
  late MockICardReader mockCardReader;
  late MockIPinPad mockPinPad;
  late MockFloatNotifier mockFloatNotifier;

  setUp(() {
    mockRepo = MockTransactionRepository();
    mockCardReader = MockICardReader();
    mockPinPad = MockIPinPad();
    mockFloatNotifier = MockFloatNotifier();

    notifier = MerchantNotifier(
      repository: mockRepo,
      cardReader: mockCardReader,
      pinPad: mockPinPad,
      floatNotifier: mockFloatNotifier,
    );
  });

  test('Retail Sale calculates 1% MDR and credits float correctly', () async {
    final amount = Decimal.parse('100.0');
    
    // 1. Start Sale
    final future = notifier.startRetailSale(amount, FundingSource.CARD_EMV);
    expect(notifier.state.status, MerchantStatus.quoting);
    
    await future;
    expect(notifier.state.status, MerchantStatus.waitingCard);
    expect(notifier.state.mdr, Decimal.parse('1.0')); // 1% of 100

    // 2. Process Card
    when(mockCardReader.readCard()).thenAnswer((_) async => CardData(maskedPan: '4111********1111', cardToken: 'TOKEN-X'));
    when(mockPinPad.capturePin()).thenAnswer((_) async => '123456');
    when(mockFloatNotifier.fetchLatestBalance()).thenAnswer((_) async => {});

    await notifier.processCardSale();

    expect(notifier.state.status, MerchantStatus.success);
    final result = notifier.state.result as RetailSaleResponse;
    expect(result.floatCreditAmount, Decimal.parse('99.0'));
    expect(result.mdrAmount, Decimal.parse('1.0'));
  });

  test('Cashback Hybrid correctly reports split amounts', () async {
    final sale = Decimal.parse('100.0');
    final cashback = Decimal.parse('50.0');

    await notifier.startCashback(sale, cashback);
    expect(notifier.state.status, MerchantStatus.waitingCard);
    expect(notifier.state.amount, Decimal.parse('150.0'));

    when(mockCardReader.readCard()).thenAnswer((_) async => CardData(maskedPan: '4111********1111', cardToken: 'TOKEN-X'));
    when(mockPinPad.capturePin()).thenAnswer((_) async => '123456');
    when(mockFloatNotifier.fetchLatestBalance()).thenAnswer((_) async => {});

    await notifier.processCashbackHandshake();

    expect(notifier.state.status, MerchantStatus.success);
    final result = notifier.state.result as CashbackResponse;
    // BDD S9.4 requires reporting split
    expect(result.purchaseAmount, Decimal.parse('100.0'));
    expect(result.cashBackAmount, Decimal.parse('50.0'));
  });
}
