/// DuitNow Transfer & QR feature helper.
///
/// Encapsulates common BddAppHarness configurations for DuitNow scenarios
/// including proxy transfers (mobile/MyKad/BRN) and QR retail sale.
library;
import 'package:flutter_test/flutter_test.dart';
import '../app_harness.dart';
import '../mock_factory.dart';

class DuitNowFeatureHelper {
  /// DuitNow proxy transfer — standard happy path.
  /// Mock repo returns SUCCESS for proxy enquiry and transfer.
  static BddAppHarness proxyTransfer(WidgetTester tester) {
    final txnRepo = createMockTransactionRepo();
    txnRepo.performProxyEnquiryStub = (proxyId, proxyType) async => 'MOHD A***D BIN AL*';
    return BddAppHarness(tester, txnRepo: txnRepo)
      .withAuth(authenticated: true);
  }

  /// DuitNow QR retail sale — standard happy path.
  /// Mock repo returns QR payload and polling succeeds.
  static BddAppHarness qrRetailSale(WidgetTester tester) {
    return BddAppHarness(tester)
      .withAuth(authenticated: true)
      .withTransactions(shouldFail: false);
  }

  /// DuitNow with timeout — polling exhausts all 36 iterations.
  static BddAppHarness timeoutScenario(WidgetTester tester) {
    final txnRepo = createMockTransactionRepo();
    txnRepo.getDuitNowStatusStub = (refId) async => {'status': 'PENDING'};
    return BddAppHarness(tester, txnRepo: txnRepo)
      .withAuth(authenticated: true);
  }
}
