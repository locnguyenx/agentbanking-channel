/// Helpers for QuoteNotifier integration tests.
/// Provides fake implementations for the ref-dependent providers
/// that QuoteNotifier reads (compliance, eod, auth).
library;
import 'package:geolocator/geolocator.dart';
import 'package:geolocator_platform_interface/geolocator_platform_interface.dart';
import 'package:agentbanking_channel/features/compliance/providers/compliance_provider.dart';
import 'package:agentbanking_channel/features/settlement/services/eod_timer_service.dart';
import 'package:agentbanking_channel/features/auth/providers/auth_provider.dart';
import 'package:agentbanking_channel/features/auth/models/auth_models.dart';

// Redundant fakes (FakeGeolocator, FakeEodTimerService) removed and moved to test_fakes.dart.

// ─── Debug extensions ─────────────────────────────────────────────────────

extension DebugComplianceNotifier on ComplianceNotifier {
  void debugSetFrozen(bool frozen) {
    if (frozen) {
      // ignore: invalid_use_of_protected_member
      state = state.copyWith(isFrozen: true);
    }
  }
}

extension DebugAuthNotifier on AuthNotifier {
  void debugSetUser(AuthUser user) {
    // ignore: invalid_use_of_protected_member
    debugSetAuthenticated(user);
  }
}
