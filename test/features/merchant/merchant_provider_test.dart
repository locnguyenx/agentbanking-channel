import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/merchant/models/merchant_models.dart';
import 'package:agentbanking_channel/features/merchant/providers/merchant_provider.dart';
import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/hardware/hardware_interfaces.dart';
import 'package:agentbanking_channel/features/settlement/providers/float_provider.dart';
import 'package:agentbanking_channel/features/settlement/repositories/float_repository.dart';
import 'package:agentbanking_channel/features/settlement/models/float_models.dart';
import 'package:agentbanking_channel/features/compliance/providers/compliance_provider.dart';
import 'package:mockito/mockito.dart';
import '../../test_utils.dart';
import '../../setup/test_credentials.dart';

class FakeFloatRepository extends Fake implements FloatRepository {
  @override
  Future<FloatLedger> getFloatStatus(String agentId) async {
    return FloatLedger(currentBalance: Decimal.parse('5000.0'), limit: Decimal.parse('10000.0'));
  }
}

class ManualMockTransactionRepository extends Mock implements TransactionRepository {
  RetailSaleResponse? nextRetailSaleResponse;
  CashbackResponse? nextCashbackResponse;

  @override
  Future<RetailSaleResponse> executeRetailSale(Decimal amount, String agentId, {String? pinBlock, String? cardToken}) async {
    if (nextRetailSaleResponse == null) throw UnimplementedError('nextRetailSaleResponse not set');
    return nextRetailSaleResponse!;
  }

  @override
  Future<CashbackResponse> executeCashback(Decimal purchaseAmount, Decimal cashbackAmount, String agentId, {String? pinBlock, String? cardToken}) async {
    if (nextCashbackResponse == null) throw UnimplementedError('nextCashbackResponse not set');
    return nextCashbackResponse!;
  }
}

class ManualMockComplianceNotifier extends ComplianceNotifier {
  ManualMockComplianceNotifier() : super();
  @override
  void freeze(String reason) => state = ComplianceState(isFrozen: true, reason: reason);
  @override
  void unlock() => state = ComplianceState(isFrozen: false);
  @override
  Future<void> simulateWebhookUnlock() async => unlock();
}

class ManualCardReader implements ICardReader {
  CardData? nextCardData;
  @override
  Future<CardData?> readCard() async => nextCardData;
  @override
  Future<bool> isAvailable() async => true;
}

class ManualPinPad implements IPinPad {
  String? nextPin;
  @override
  Future<String?> capturePin() async => nextPin;
  @override
  Future<bool> isAvailable() async => true;
}

class ManualMerchantTerminal implements IMerchantTerminal {
  @override
  Future<bool> isAvailable() async => true;
  @override
  Future<bool> displayQrCode(String data) async => true;
  @override
  Future<void> clearDisplay() async {}
}

class ManualFloatNotifier extends FloatNotifier {
  ManualFloatNotifier() : super(FakeFloatRepository(), null);
  @override
  Future<void> fetchLatestBalance() async {}
}

void main() {
  late MerchantNotifier notifier;
  late ManualMockTransactionRepository mockRepo;
  late ManualCardReader mockCardReader;
  late ManualPinPad mockPinPad;
  late ManualFloatNotifier mockFloatNotifier;
  late ManualMockComplianceNotifier mockComplianceNotifier;
  late ManualMerchantTerminal mockTerminal;

  setUp(() {
    mockRepo = ManualMockTransactionRepository();
    mockCardReader = ManualCardReader();
    mockPinPad = ManualPinPad();
    mockFloatNotifier = ManualFloatNotifier();
    mockTerminal = ManualMerchantTerminal();
    mockComplianceNotifier = ManualMockComplianceNotifier();

    notifier = MerchantNotifier(
      ref: ManualMockRef(),
      repository: mockRepo,
      cardReader: mockCardReader,
      pinPad: mockPinPad,
      floatNotifier: mockFloatNotifier,
      complianceNotifier: mockComplianceNotifier,
      merchantTerminal: mockTerminal,
      agentId: TestCredentials.username,
    );
  });

  test('Retail Sale executes correctly directly without quoting', () async {
    final amount = Decimal.parse('100.0');
    
    // 1. Start Sale
    await notifier.startRetailSale(amount, FundingSource.CARD_EMV);
    expect(notifier.state.status, MerchantStatus.waitingCard);

    // 2. Process Card
    mockCardReader.nextCardData = CardData(pan: '4111222233334444', cardToken: 'TOKEN-X');
    mockPinPad.nextPin = '123456';
    
    mockRepo.nextRetailSaleResponse = RetailSaleResponse(
      floatCreditAmount: Decimal.parse('99.0'),
      mdrAmount: Decimal.parse('1.0'),
      receiptReference: 'REF-123',
    );

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

    mockCardReader.nextCardData = CardData(pan: '4111222233334444', cardToken: 'TOKEN-X');
    mockPinPad.nextPin = '123456';

    mockRepo.nextCashbackResponse = CashbackResponse(
      purchaseAmount: Decimal.parse('100.0'),
      cashBackAmount: Decimal.parse('50.0'),
      receiptReference: 'REF-456',
    );

    await notifier.processCashbackHandshake();

    expect(notifier.state.status, MerchantStatus.success);
    final result = notifier.state.result as CashbackResponse;
    // BDD S9.4 requires reporting split
    expect(result.purchaseAmount, Decimal.parse('100.0'));
    expect(result.cashBackAmount, Decimal.parse('50.0'));
  });
}
