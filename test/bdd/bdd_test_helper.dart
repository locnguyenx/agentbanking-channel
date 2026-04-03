/// Backward-compatibility shim for existing BDD step files.
///
/// All mock classes and factory functions are now in:
///   test/bdd/helpers/mock_factory.dart
///
/// The new builder-pattern harness is in:
///   test/bdd/helpers/app_harness.dart
///
/// This file re-exports everything so existing step files
/// that `import 'bdd_test_helper.dart'` continue to compile.
///
/// NEW step files should import from helpers/ directly.
library;

// Re-export all mock classes and factory functions
export 'helpers/mock_factory.dart';

// Re-export the harness + bddContainer
export 'helpers/app_harness.dart' show bddContainer, bddContainerVar, BddAppHarness;

import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'helpers/mock_factory.dart';
import 'helpers/app_harness.dart';

// ─── Global mocks for backward compatibility ──────────────────────────────
// These are kept as globals so existing step files that reference
// `mockTransactionRepository.shouldFail = true` etc. continue to work.
// New code should use BddAppHarness builder methods instead.
final mockAuthRepository = createMockAuthRepo();
final mockSecureStorage = createMockSecureStorage();
final mockTransactionRepository = createMockTransactionRepo();
final mockGeolocator = createMockGeolocator();

void resetMocks({bool clearStorage = true}) {
  mockAuthRepository.isDeviceWhitelisted = true;
  mockAuthRepository.loginBiometricStub = null;
  if (clearStorage) {
    mockSecureStorage.jwt = null;
    mockSecureStorage.complianceLocked = false;
    mockSecureStorage.complianceLocks.clear();
  }
  mockTransactionRepository.lastQrAmount = null;
  mockTransactionRepository.shouldFail = false;
  mockTransactionRepository.performProxyEnquiryStub = null;

  mockGeolocator.position = Position(
    latitude: 3.1390, longitude: 101.6869,
    timestamp: DateTime.now(), accuracy: 1.0, altitude: 0.0, heading: 0.0,
    speed: 0.0, speedAccuracy: 0.0, altitudeAccuracy: 0.0, headingAccuracy: 0.0,
  );
  mockGeolocator.shouldThrow = false;
}

/// Legacy entry point — delegates to BddAppHarness.
///
/// Existing step files call this. New step files should use
/// `BddAppHarness(tester).withAuth(...).build()` directly.
Future<void> pumpBddApp(
  WidgetTester tester, {
  bool isWhitelisted = true,
  DateTime? eodClock,
  bool isAuthenticated = true,
  bool complianceLocked = false,
  bool clearStorage = true,
}) async {
  // Important: Dispose previous container if it exists to prevent timer leaks
  if (bddContainerVar != null) {
    bddContainerVar!.dispose();
    bddContainerVar = null;
  }

  resetMocks(clearStorage: clearStorage);

  final harness = BddAppHarness(
    tester,
    authRepo: mockAuthRepository,
    secureStorage: mockSecureStorage,
    txnRepo: mockTransactionRepository,
    geolocator: mockGeolocator,
  )
    ..withAuth(authenticated: isAuthenticated, whitelisted: isWhitelisted)
    ..withComplianceLock(locked: complianceLocked);

  if (eodClock != null) {
    harness.withEod(clock: eodClock);
  }

  await harness.build();
}
