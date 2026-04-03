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

// ─── Fake Geolocator ──────────────────────────────────────────────────────

class FakeGeolocator extends GeolocatorPlatform {
  Position positionToReturn = Position(
    latitude: 3.1390,  // Kuala Lumpur
    longitude: 101.6869,
    timestamp: DateTime.now(),
    accuracy: 10.0,
    altitude: 0.0,
    heading: 0.0,
    speed: 0.0,
    speedAccuracy: 0.0,
    altitudeAccuracy: 0.0,
    headingAccuracy: 0.0,
  );
  bool shouldFail = false;

  @override
  Future<Position> getCurrentPosition({LocationSettings? locationSettings}) async {
    if (shouldFail) throw Exception('GPS unavailable');
    return positionToReturn;
  }
}

// ─── Fake EOD Timer Service ───────────────────────────────────────────────

class FakeEodTimerService extends EodTimerService {
  final bool _isLocked;

  // Pass a midday clockOverride so the super constructor's updateStatus() → open
  FakeEodTimerService({bool locked = false})
      : _isLocked = locked,
        super(clockOverride: DateTime(2026, 1, 1, 12, 0, 0));

  @override
  EodStatus getCurrentEodStatus() {
    return _isLocked ? EodStatus.locked : EodStatus.open;
  }
}

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
