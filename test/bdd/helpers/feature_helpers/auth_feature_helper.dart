/// Auth & Session feature helper.
///
/// Encapsulates common BddAppHarness configurations for auth scenarios.
/// Usage:
///   final harness = AuthFeatureHelper.authenticatedAgent(tester);
///   await harness.build();
library;
import 'package:flutter_test/flutter_test.dart';
import '../app_harness.dart';
import '../mock_factory.dart';

class AuthFeatureHelper {
  /// Standard authenticated agent — happy path for most auth scenarios.
  static BddAppHarness authenticatedAgent(WidgetTester tester) {
    return BddAppHarness(tester)
      .withAuth(authenticated: true, whitelisted: true);
  }

  /// Unauthenticated agent — for login/logout tests.
  static BddAppHarness unauthenticatedAgent(WidgetTester tester) {
    return BddAppHarness(tester)
      .withAuth(authenticated: false);
  }

  /// Agent on a non-whitelisted device.
  static BddAppHarness nonWhitelistedDevice(WidgetTester tester) {
    return BddAppHarness(tester)
      .withAuth(authenticated: true, whitelisted: false);
  }
}
