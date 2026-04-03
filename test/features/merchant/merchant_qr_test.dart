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

class FakeFloatRepository extends Fake implements FloatRepository {
  @override
  Future<FloatLedger> getFloatStatus(String agentId) async {
    return FloatLedger(currentBalance: Decimal.parse('5000.0'), limit: Decimal.parse('10000.0'));
  }
}

class ManualMockTransactionRepository extends Mock implements TransactionRepository {
  RetailSaleResponse? nextRetailSaleResponse;
  String? nextDuitNowStatus;

  @override
  Future<Map<String, String>> generateQrSale(Decimal amount, String agentId) async {
    return {
      'qrPayload': 'duitnow-qr-payload-for-TEST',
      'referenceId': 'QR_TEST_123',
    };
  }

  @override
  Future<Map<String, dynamic>> getDuitNowStatus(String referenceId) async {
    return {
      'status': nextDuitNowStatus ?? 'PENDING',
      'referenceId': referenceId,
      'amount': 50.0,
      'mdrAmount': 0.25,
      'netToMerchant': 49.75,
      'transactionId': 'TXN_QR_123',
    };
  }
  @override
  Future<TransactionExecutionResponse> executeTransaction(TransactionExecutionRequest request, String agentId, {String? idempotencyKey}) async {
    return TransactionExecutionResponse(status: 'SUCCESS', referenceId: 'REF_TEST_123');
  }

  @override
  Future<TransactionExecutionResponse> balanceInquiry(TransactionExecutionRequest request, String agentId) async {
    return TransactionExecutionResponse(status: 'SUCCESS', referenceId: 'BAL_TEST_123');
  }
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

class ManualFloatNotifier extends FloatNotifier {
  ManualFloatNotifier() : super(FakeFloatRepository(), null);
  @override
  Future<void> fetchLatestBalance() async {}
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
class FakeCardReader extends Mock implements ICardReader {
  @override
  Future<bool> isAvailable() async => true;
}
class FakePinPad extends Mock implements IPinPad {
  @override
  Future<bool> isAvailable() async => true;
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
      ref: ManualMockRef(),
      repository: mockRepo,
      cardReader: FakeCardReader(), 
      pinPad: FakePinPad(),
      merchantTerminal: mockTerminal,
      floatNotifier: mockFloatNotifier,
      complianceNotifier: mockComplianceNotifier,
      agentId: 'AGENT-001',
    );
  });

  test('DuitNow QR Retail Sale flow completes successfully after polling', () async {
    final amount = Decimal.parse('50.0');
    
    // 1. Start Sale
    final future = notifier.startRetailSale(amount, FundingSource.DUITNOW_QR);
    
    // Displaying QR state immediately since quoting is removed
    expect(notifier.state.status, MerchantStatus.displayingQr);
    
    // Wait for generateQrSale to finish and send to terminal
    await Future.delayed(const Duration(milliseconds: 50));
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
