/// Biller & JomPay feature helper.
///
/// Encapsulates common BddAppHarness configurations for biller scenarios
/// including bill payment, JomPay ON-US and OFF-US flows.
library;
import 'package:flutter_test/flutter_test.dart';
import '../app_harness.dart';
import '../mock_factory.dart';

class BillerFeatureHelper {
  /// Standard bill payment — happy path with biller inquiry passing.
  static BddAppHarness billPayment(WidgetTester tester) {
    return BddAppHarness(tester)
      .withAuth(authenticated: true)
      .withTransactions(shouldFail: false);
  }

  /// JomPay ON-US — biller routes through ON-US channel.
  static BddAppHarness jomPayOnUs(WidgetTester tester) {
    return BddAppHarness(tester)
      .withAuth(authenticated: true)
      .withTransactions(shouldFail: false);
  }

  /// JomPay OFF-US — biller routes through OFF-US channel with polling.
  static BddAppHarness jomPayOffUs(WidgetTester tester) {
    return BddAppHarness(tester)
      .withAuth(authenticated: true)
      .withTransactions(shouldFail: false);
  }

  /// Biller unavailable — for ERR_EXT_BILLER_UNAVAILABLE error path.
  static BddAppHarness billerUnavailable(WidgetTester tester) {
    return BddAppHarness(tester)
      .withAuth(authenticated: true)
      .withTransactions(shouldFail: true);
  }
}
