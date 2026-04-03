/// Payment & Card Flow feature helper.
///
/// Encapsulates common BddAppHarness configurations for payment scenarios
/// including quoting, card-based flows, and cash-funded transactions.
library;
import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import '../app_harness.dart';
import '../mock_factory.dart';

class PaymentFeatureHelper {
  /// Standard cash-funded payment — agent authenticated, within geofence.
  static BddAppHarness cashPayment(WidgetTester tester) {
    return BddAppHarness(tester)
      .withAuth(authenticated: true)
      .withTransactions(shouldFail: false);
  }

  /// Card-funded payment — agent authenticated, card reader available.
  static BddAppHarness cardPayment(WidgetTester tester) {
    return BddAppHarness(tester)
      .withAuth(authenticated: true)
      .withTransactions(shouldFail: false);
  }

  /// Payment that should fail — for error path testing.
  static BddAppHarness failingPayment(WidgetTester tester) {
    return BddAppHarness(tester)
      .withAuth(authenticated: true)
      .withTransactions(shouldFail: true);
  }

  /// Payment with compliance lock active — for ERR_COMPLIANCE_FROZEN.
  static BddAppHarness complianceLockedPayment(WidgetTester tester) {
    return BddAppHarness(tester)
      .withAuth(authenticated: true)
      .withComplianceLock(locked: true);
  }

  /// Payment outside geofence — for ERR_GEOFENCE_BREACH.
  static BddAppHarness outsideGeofence(WidgetTester tester) {
    return BddAppHarness(tester)
      .withAuth(authenticated: true)
      .withGps(unavailable: true);
  }
}
