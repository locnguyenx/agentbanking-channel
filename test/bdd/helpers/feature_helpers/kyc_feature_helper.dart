/// KYC & Onboarding feature helper.
///
/// Encapsulates common BddAppHarness configurations for KYC scenarios
/// including eKYC verification, Face AI liveness, MyKad scanning,
/// and micro-agent onboarding STP flow.
library;
import 'package:flutter_test/flutter_test.dart';
import '../app_harness.dart';
import '../mock_factory.dart';

class KycFeatureHelper {
  /// Standard authenticated agent for KYC flow.
  static BddAppHarness ekycFlow(WidgetTester tester) {
    return BddAppHarness(tester)
      .withAuth(authenticated: true);
  }

  /// Agent onboarding — unauthenticated agent starting STP flow.
  static BddAppHarness agentOnboarding(WidgetTester tester) {
    return BddAppHarness(tester)
      .withAuth(authenticated: false);
  }

  /// KYC with compliance lock — agent frozen during verification.
  static BddAppHarness complianceLockedKyc(WidgetTester tester) {
    return BddAppHarness(tester)
      .withAuth(authenticated: true)
      .withComplianceLock(locked: true);
  }
}
