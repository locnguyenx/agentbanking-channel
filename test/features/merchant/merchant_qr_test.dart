import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/merchant/models/merchant_models.dart';
import 'package:agentbanking_channel/features/merchant/providers/merchant_provider.dart';
import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/hardware/hardware_interfaces.dart';
import 'package:agentbanking_channel/features/settlement/providers/float_provider.dart';
import 'package:agentbanking_channel/features/settlement/models/float_models.dart';
import 'package:agentbanking_channel/features/compliance/providers/compliance_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';

class ManualMockTransactionRepository implements TransactionRepository {
  RetailSaleResponse? nextRetailSaleResponse;
  String? nextDuitNowStatus;

  @override
  Future<RetailSaleResponse> executeRetailSale(Decimal amount, String agentId, {String? pinBlock, String? cardToken}) async {
    return nextRetailSaleResponse!;
  }

  @override
  Future<String> getDuitNowStatus(String referenceId) async {
    return nextDuitNowStatus ?? 'PENDING';
  }
  
  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError(invocation.memberName.toString());
}

class ManualMockMerchantTerminal implements IMerchantTerminal {
  String? lastQrPayload;
  bool clearCalled = false;

  @override
  Future<bool> isAvailable() async => true;

  @override
  Future<bool> displayQrCode(String payload) async {
    lastQrPayload = payload;
    return true;
  }

  @override
  Future<void> clearDisplay() async {
    clearCalled = true;
  }
}

class ManualFloatNotifier extends StateNotifier<FloatLedger> implements FloatNotifier {
  ManualFloatNotifier() : super(FloatLedger(currentBalance: Decimal.zero, limit: Decimal.zero));
  @override
  Future<void> fetchLatestBalance() async {}
}

class ManualMockComplianceNotifier extends StateNotifier<ComplianceState> implements ComplianceNotifier {
  ManualMockComplianceNotifier() : super(ComplianceState(isFrozen: false));
  @override
  void freeze(String reason) {}
  @override
  void unlock() {}
  @override
  Future<void> simulateWebhookUnlock() async {}
}

void main() {
  late MerchantNotifier notifier;
  late ManualMockTransactionRepository mockRepo;
  late ManualMockMerchantTerminal mockTerminal;
  late ManualFloatNotifier mockFloatNotifier;
  late ManualMockComplianceNotifier mockComplianceNotifier;

  setUp(() {
    mockRepo = ManualMockTransactionRepository();
    mockTerminal = ManualMockMerchantTerminal();
    mockFloatNotifier = ManualFloatNotifier();
    mockComplianceNotifier = ManualMockComplianceNotifier();

    notifier = MerchantNotifier(
      repository: mockRepo,
      cardReader: FakeCardReader(), 
      pinPad: FakePinPad(),
      merchantTerminal: mockTerminal,
      floatNotifier: mockFloatNotifier,
      complianceNotifier: mockComplianceNotifier,
    );
  });

  test('DuitNow QR Retail Sale flow completes successfully after polling', () async {
    final amount = Decimal.parse('50.0');
    
    // 1. Start Sale
    final future = notifier.startRetailSale(amount, FundingSource.DUITNOW_QR);
    
    // Quoting state
    expect(notifier.state.status, MerchantStatus.quoting);
    
    await Future.delayed(const Duration(seconds: 2)); // Wait for quote + transition
    
    // Displaying QR state
    expect(notifier.state.status, MerchantStatus.displayingQr);
    expect(mockTerminal.lastQrPayload, contains('duitnow-qr-payload'));

    // 2. Simulate Backend notification (polling success)
    mockRepo.nextDuitNowStatus = 'COMPLETED';
    mockRepo.nextRetailSaleResponse = RetailSaleResponse(
      floatCreditAmount: Decimal.parse('49.75'), // 50 - 0.5% MDR (0.25)
      mdrAmount: Decimal.parse('0.25'),
      receiptReference: 'REF-QR-123',
    );

    // Wait for the polling loop to finish (notifier uses 5s delay, so we need to wait)
    // In real test we might want to inject a faster delay, but for now we wait.
    await Future.delayed(const Duration(seconds: 10));

    expect(notifier.state.status, MerchantStatus.success);
    final result = notifier.state.result as RetailSaleResponse;
    expect(result.floatCreditAmount, Decimal.parse('49.75'));
    expect(mockTerminal.clearCalled, isTrue);
  });
}

class FakeCardReader extends Fake implements ICardReader {}
class FakePinPad extends Fake implements IPinPad {}
