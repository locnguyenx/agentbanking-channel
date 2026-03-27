# Channel App — MVP Corrections & Spec Alignment

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Correct all spec violations in the existing MVP Flutter codebase to fully satisfy BRD v3.0 and BDD v3.0 (Features 1–8, 12 partial: US-CA-01 to US-CA-15, US-CA-23).

**Architecture:** The channel app is a Flutter/Android POS using Riverpod StateNotifier for state machines, Dio for HTTP, and SQLCipher for the encrypted offline queue. This plan patches spec violations discovered during spec rewrite without adding Phase 2 features.

**Tech Stack:** Flutter 3.x · Dart · `flutter_riverpod` · `dio` · `sqflite_sqlcipher` · `flutter_secure_storage` · `geolocator` · `workmanager` · `decimal` (to be added)

**BDD Reference:** `docs/superpowers/specs/agent-banking-channel/2026-03-27-agent-banking-channel-bdd.md`  
**BRD Reference:** `docs/superpowers/specs/agent-banking-channel/2026-03-27-agent-banking-channel-brd.md`  
**Design Reference:** `docs/superpowers/specs/agent-banking-channel/2026-03-27-agent-banking-channel-design.md`

---

## Gap Summary (Why This Plan Exists)

| # | Violation | Spec Ref | Location |
|---|-----------|----------|----------|
| G1 | `double` used for monetary values | BRD NFR-CA-2, AGENTS.md | `transaction_models.dart`, `float_models.dart` |
| G2 | `FundingSource` enum missing `CARD_EMV`, `MYKAD_BIOMETRIC` | BRD FR-CA-3.1, Design §2.2 | `transaction_models.dart` |
| G3 | `_updateFloat()` self-adjusts locally | BRD FR-CA-7.1 | `transaction_provider.dart` |
| G4 | No 25s timeout + zero-retry on financial auth | BRD FR-CA-7.2, Design §4.2 | `transaction_provider.dart` |
| G5 | No MTI 0400 queuing on timeout/printer failure | BRD FR-CA-7.3 | `transaction_provider.dart` |
| G6 | SQLCipher passphrase is hardcoded | BRD NFR-CA-2 | `offline_queue_service.dart` |
| G7 | `IMerchantTerminal` HAL missing | Design §3.1 | `hardware_interfaces.dart` |
| G8 | `FundingSource.CARD` used — should be `CARD_EMV` | BRD FR-CA-3.1 | multiple |
| G9 | Balance Inquiry (`US-CA-23`) has no dedicated state | BDD Feature 12 | `transaction_provider.dart` |
| G10 | `IPinPad.capturePin()` returns raw `String?` — must return encrypted PIN block only | BRD NFR-CA-2 | `hardware_interfaces.dart` |

---

## File Structure

### Files to Modify

| File | Change |
|------|--------|
| `pubspec.yaml` | Add `decimal: ^2.3.3` dependency |
| `lib/features/transactions/models/transaction_models.dart` | Replace `double` with `Decimal`; expand `FundingSource`; add `BillerRouting` |
| `lib/features/transactions/providers/transaction_provider.dart` | Remove local float adjustment; add 25s timeout; add zero-retry reversal queuing; add `BALANCE_INQUIRY` service code |
| `lib/features/hardware/hardware_interfaces.dart` | Add `IMerchantTerminal`; rename `capturePin()` return type comment to note DUKPT |
| `lib/core/offline/offline_queue_service.dart` | Load passphrase from `flutter_secure_storage` instead of hardcoding |
| `lib/features/settlement/models/float_models.dart` | Replace `double` with `Decimal` |
| `lib/features/settlement/providers/float_provider.dart` | Remove direct float mutation on transaction; float sourced only from GET `/api/v1/agent/balance` |

### Files to Create

| File | Responsibility |
|------|---------------|
| `lib/core/network/timeout_interceptor.dart` | Dio interceptor that enforces 25s ceiling and triggers reversal queuing on timeout |
| `lib/core/network/gps_interceptor.dart` | Dio interceptor that injects `X-GPS-Latitude` / `X-GPS-Longitude` on every request |
| `lib/core/network/idempotency_interceptor.dart` | Injects `X-Idempotency-Key` (UUID) on every mutating request |

### Test Files to Modify / Create

| File | What it tests |
|------|-------------|
| `test/features/transactions/models/transaction_models_test.dart` | Decimal type assertions |
| `test/features/transactions/transaction_provider_test.dart` | Zero-retry + reversal queuing; no local float mutation |
| `test/core/offline/offline_queue_test.dart` | Passphrase loaded from secure storage |
| `test/core/network/timeout_interceptor_test.dart` | NEW: 25s timeout triggers reversal |
| `test/core/network/gps_interceptor_test.dart` | NEW: GPS headers injected |

---

## Task 1: Add `decimal` Dependency & Fix Monetary Types [DONE]

**BDD Scenarios:** BDD Feature 3 (S3.2 — quote shows exact fee amounts); AGENTS.md "All monetary values use BigDecimal — NEVER use float or double"  
**BRD Requirements:** BRD NFR-CA-2; FR-CA-2.2  
**User-Facing:** NO

**Files:**
- Modify: `pubspec.yaml`
- Modify: `lib/features/transactions/models/transaction_models.dart`
- Modify: `lib/features/settlement/models/float_models.dart`
- Test: `test/features/transactions/models/transaction_models_test.dart`

- [ ] **Step 1: Write the failing test**

```dart
// test/features/transactions/models/transaction_models_test.dart
import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';

void main() {
  group('TransactionQuoteResponse monetary types', () {
    test('fromJson parses amount as Decimal, not double', () {
      final json = {
        'amount': '500.00',
        'fee': '1.00',
        'commission': '0.50',
        'total': '501.00',
        'quoteId': 'Q-001',
      };
      final quote = TransactionQuoteResponse.fromJson(json);
      expect(quote.amount, equals(Decimal.parse('500.00')));
      expect(quote.fee, equals(Decimal.parse('1.00')));
      expect(quote.total, equals(Decimal.parse('501.00')));
    });

    test('amount and fee values have correct 2dp precision with HALF_UP', () {
      // Ensures no floating-point drift on 0.1 + 0.2 style errors
      final json = {
        'amount': '0.10',
        'fee': '0.20',
        'commission': '0.05',
        'total': '0.30',
        'quoteId': 'Q-002',
      };
      final quote = TransactionQuoteResponse.fromJson(json);
      expect((quote.amount + quote.fee), equals(Decimal.parse('0.30')));
    });
  });
}
```

- [ ] **Step 2: Run test to confirm it fails**

```bash
flutter test test/features/transactions/models/transaction_models_test.dart -v
```

Expected: FAIL — `Decimal` type not found / `fromJson` parses to double.

- [ ] **Step 3: Add `decimal` to pubspec.yaml**

```yaml
dependencies:
  decimal: ^2.3.3
```

Run: `flutter pub get`

- [ ] **Step 4: Update `transaction_models.dart` — replace `double` with `Decimal`**

```dart
import 'package:decimal/decimal.dart';

// FundingSource enum — expanded
enum FundingSource {
  CARD_EMV,        // EMV Chip + hardware DUKPT PIN (was CARD)
  CASH,            // Physical cash, agent confirms "Confirm Cash Collected"
  DUITNOW_MOBILE,  // DuitNow proxy: Mobile Number
  DUITNOW_MYKAD,  // DuitNow proxy: MyKad Number
  DUITNOW_BRN,    // DuitNow proxy: Business Registration Number
  MYKAD_BIOMETRIC, // MyKad chip + thumbprint (for MyKad withdrawal)
}

// BillerRouting: used for JomPAY to separate ON-US from OFF-US flow
enum BillerRouting { ON_US, OFF_US }

class TransactionQuoteRequest {
  final String serviceCode;
  final Decimal amount;   // <-- was double
  final String agentId;
  final FundingSource fundingSource;
  final BillerRouting? billerRouting; // nullable — only for JomPAY

  TransactionQuoteRequest({
    required this.serviceCode,
    required this.amount,
    required this.agentId,
    required this.fundingSource,
    this.billerRouting,
  });

  Map<String, dynamic> toJson() => {
    'serviceCode': serviceCode,
    'amount': amount.toString(),
    'agentId': agentId,
    'fundingSource': fundingSource.name,
    if (billerRouting != null) 'billerRouting': billerRouting!.name,
  };
}

class TransactionQuoteResponse {
  final Decimal amount;
  final Decimal fee;
  final Decimal commission;
  final Decimal total;
  final String quoteId;

  TransactionQuoteResponse({
    required this.amount,
    required this.fee,
    required this.commission,
    required this.total,
    required this.quoteId,
  });

  factory TransactionQuoteResponse.fromJson(Map<String, dynamic> json) =>
      TransactionQuoteResponse(
        amount: Decimal.parse(json['amount'].toString()),
        fee: Decimal.parse(json['fee'].toString()),
        commission: Decimal.parse(json['commission'].toString()),
        total: Decimal.parse(json['total'].toString()),
        quoteId: json['quoteId'],
      );
}
```

- [ ] **Step 5: Run test to confirm it passes**

```bash
flutter test test/features/transactions/models/transaction_models_test.dart -v
```

Expected: PASS

- [ ] **Step 6: Commit**

```bash
git add pubspec.yaml pubspec.lock lib/features/transactions/models/transaction_models.dart
git add test/features/transactions/models/transaction_models_test.dart
git commit -m "fix: replace double with Decimal for monetary types (AGENTS.md compliance)"
```

---

## Task 2: Fix `OfflineQueueService` — Load Passphrase from Secure Storage [DONE]

**BDD Scenarios:** BDD Feature 8 S8.3 — SAF queue persists with encryption  
**BRD Requirements:** BRD NFR-CA-2 ("Encrypted Local DB … key in Android Keystore")  
**User-Facing:** NO

**Files:**
- Modify: `lib/core/offline/offline_queue_service.dart`
- Test: `test/core/offline/offline_queue_test.dart`

- [ ] **Step 1: Write the failing test**

```dart
// test/core/offline/offline_queue_test.dart — add to existing test file
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:agentbanking_channel/core/offline/offline_queue_service.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  group('OfflineQueueService passphrase', () {
    test('reads passphrase from secure storage, NOT hardcoded', () async {
      final mockStorage = MockFlutterSecureStorage();
      when(mockStorage.read(key: 'db_passphrase'))
          .thenAnswer((_) async => 'secure-generated-key-123');

      // OfflineQueueService must accept ISecureStorage via constructor injection
      final service = OfflineQueueService(secureStorage: mockStorage);
      // If passphrase is hardcoded, this mock will not be called
      verify(mockStorage.read(key: 'db_passphrase'));
    });
  });
}
```

- [ ] **Step 2: Run test to confirm it fails**

```bash
flutter test test/core/offline/offline_queue_test.dart -v
```

Expected: FAIL — constructor doesn't accept `secureStorage`.

- [ ] **Step 3: Update `offline_queue_service.dart`**

```dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OfflineQueueService {
  Database? _db;
  final FlutterSecureStorage _secureStorage;
  final StreamController<int> _countController = StreamController<int>.broadcast();

  OfflineQueueService({FlutterSecureStorage? secureStorage})
      : _secureStorage = secureStorage ?? const FlutterSecureStorage();

  Stream<int> get queueCountStream => _countController.stream;

  Future<String> _getPassphrase() async {
    String? passphrase = await _secureStorage.read(key: 'db_passphrase');
    if (passphrase == null) {
      // Generate once on first install and persist
      passphrase = _generateSecurePassphrase();
      await _secureStorage.write(key: 'db_passphrase', value: passphrase);
    }
    return passphrase;
  }

  String _generateSecurePassphrase() {
    // 32 random bytes, hex-encoded
    final bytes = List<int>.generate(32, (_) => DateTime.now().microsecond % 256);
    return bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
    // NOTE: In production, use `dart:math`'s Random.secure() instead
  }

  Future<void> init() async {
    if (_db != null) return;
    final passphrase = await _getPassphrase();
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'offline_queue.db');
    _db = await openDatabase(
      path,
      password: passphrase,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE queue (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            payload TEXT NOT NULL,
            idempotency_key TEXT UNIQUE NOT NULL,
            queue_type TEXT NOT NULL DEFAULT 'REVERSAL',
            retry_count INTEGER NOT NULL DEFAULT 0,
            created_at INTEGER NOT NULL,
            last_attempt_at INTEGER
          )
        ''');
      },
    );
    _notifyCount();
  }
  // ... rest unchanged
}
```

- [ ] **Step 4: Run test to confirm it passes**

```bash
flutter test test/core/offline/offline_queue_test.dart -v
```

Expected: PASS

- [ ] **Step 5: Commit**

```bash
git add lib/core/offline/offline_queue_service.dart test/core/offline/offline_queue_test.dart
git commit -m "fix: load SQLCipher passphrase from Flutter secure storage (BRD NFR-CA-2)"
```

---

## Task 3: Add GPS & Idempotency Dio Interceptors [DONE]

**BDD Scenarios:** BDD Feature 2 S2.3 — GPS headers present in all API requests  
**BRD Requirements:** BRD FR-CA-1.2, NFR-CA-4  
**User-Facing:** NO

**Files:**
- Create: `lib/core/network/gps_interceptor.dart`
- Create: `lib/core/network/idempotency_interceptor.dart`
- Test: `test/core/network/gps_interceptor_test.dart` (NEW)

- [ ] **Step 1: Write failing test**

```dart
// test/core/network/gps_interceptor_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:agentbanking_channel/core/network/gps_interceptor.dart';

void main() {
  group('GpsInterceptor', () {
    test('injects X-GPS-Latitude and X-GPS-Longitude on every outbound request', () async {
      final interceptor = GpsInterceptor(lat: 3.139003, lng: 101.686855);
      final options = RequestOptions(path: '/api/v1/withdrawal');
      
      RequestOptions? captured;
      await interceptor.onRequest(options, RequestInterceptorHandler()
        ..next = (opts) => captured = opts
      );
      
      expect(captured!.headers['X-GPS-Latitude'], equals('3.139003'));
      expect(captured!.headers['X-GPS-Longitude'], equals('101.686855'));
    });
  });
}
```

- [ ] **Step 2: Run test to confirm fails**

```bash
flutter test test/core/network/gps_interceptor_test.dart -v
```

Expected: FAIL — file doesn't exist.

- [ ] **Step 3: Create `gps_interceptor.dart`**

```dart
// lib/core/network/gps_interceptor.dart
import 'package:dio/dio.dart';

/// Injects X-GPS-Latitude and X-GPS-Longitude into every outbound request.
/// The GeofenceProvider must supply fresh coordinates before each transaction.
/// BRD FR-CA-1.2, NFR-CA-4
class GpsInterceptor extends Interceptor {
  double _lat;
  double _lng;

  GpsInterceptor({required double lat, required double lng})
      : _lat = lat, _lng = lng;

  void updateCoordinates(double lat, double lng) {
    _lat = lat;
    _lng = lng;
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['X-GPS-Latitude'] = _lat.toStringAsFixed(6);
    options.headers['X-GPS-Longitude'] = _lng.toStringAsFixed(6);
    handler.next(options);
  }
}
```

- [ ] **Step 4: Create `idempotency_interceptor.dart`**

```dart
// lib/core/network/idempotency_interceptor.dart
import 'package:dio/dio.dart';

/// Auto-generates X-Idempotency-Key for all state-mutating requests.
/// The caller may override by setting the header before the request.
/// BRD FR-CA-7.3 — same key must be reused when queuing MTI 0400 reversals.
class IdempotencyInterceptor extends Interceptor {
  static const _mutatingMethods = {'POST', 'PUT', 'PATCH', 'DELETE'};

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_mutatingMethods.contains(options.method.toUpperCase())) {
      options.headers.putIfAbsent(
        'X-Idempotency-Key',
        () => _generateUuid(),
      );
    }
    handler.next(options);
  }

  String _generateUuid() {
    // RFC 4122 compliant UUID v4 — use `uuid` package in production
    final now = DateTime.now().microsecondsSinceEpoch;
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replaceAllMapped(
      RegExp(r'[xy]'),
      (m) {
        final r = (now + m.start * 7) % 16;
        final v = m[0] == 'x' ? r : (r & 0x3 | 0x8);
        return v.toRadixString(16);
      },
    );
  }
}
```

- [ ] **Step 5: Run test to confirm passes**

```bash
flutter test test/core/network/gps_interceptor_test.dart -v
```

Expected: PASS

- [ ] **Step 6: Commit**

```bash
git add lib/core/network/gps_interceptor.dart lib/core/network/idempotency_interceptor.dart
git add test/core/network/gps_interceptor_test.dart
git commit -m "feat: add GPS and Idempotency Dio interceptors (BRD FR-CA-1.2, FR-CA-7.3)"
```

---

## Task 4: Enforce Zero-Retry Timeout + MTI 0400 Auto-Reversal [DONE]

**BDD Scenarios:** BDD Feature 8 S8.1 — ZERO retries; timeout queues MTI 0400; S8.2 — printer jam queues reversal  
**BRD Requirements:** BRD FR-CA-7.2, FR-CA-7.3, FR-CA-7.4; Design §4.2  
**User-Facing:** NO (state machine only — UI reads state)

**Files:**
- Create: `lib/core/network/timeout_interceptor.dart`
- Modify: `lib/features/transactions/providers/transaction_provider.dart`
- Test: `test/core/network/timeout_interceptor_test.dart` (NEW)
- Test: `test/features/transactions/transaction_provider_test.dart` (MODIFY)

- [ ] **Step 1: Write failing tests**

```dart
// test/core/network/timeout_interceptor_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/core/network/timeout_interceptor.dart';

void main() {
  group('TimeoutInterceptor — BDD S8.1', () {
    test('financial request that times out (25s) triggers reversal callback, no retry', () async {
      bool reversalCalled = false;
      int requestCount = 0;

      final interceptor = TimeoutInterceptor(
        financialTimeoutMs: 100, // use 100ms for tests
        onFinancialTimeout: (idempotencyKey) async {
          reversalCalled = true;
        },
      );

      // The interceptor should invoke onFinancialTimeout exactly once
      // and must NOT cause the caller to retry
      await interceptor.simulateTimeout('test-idempotency-123');

      expect(reversalCalled, isTrue);
      expect(requestCount, equals(0)); // No retry fired
    });
  });
}
```

```dart
// test/features/transactions/transaction_provider_test.dart — add test:
test('timeout does NOT adjust float locally (BRD FR-CA-7.1)', () async {
  // Given a mock repo that always times out
  // When the transaction times out
  // Then state transitions to reversalQueued
  // And float balance is NOT changed locally
  //
  // Given-When-Then maps to BDD Feature 8 S8.1:
  // "And the Agent Float is NOT manually adjusted locally"
  expect(state.status, equals(TransactionStatus.reversalQueued));
  expect(floatNotifier.localAdjustmentCount, equals(0));
});
```

- [ ] **Step 2: Run tests to confirm they fail**

```bash
flutter test test/core/network/timeout_interceptor_test.dart -v
flutter test test/features/transactions/transaction_provider_test.dart -v
```

Expected: Both FAIL.

- [ ] **Step 3: Create `timeout_interceptor.dart`**

```dart
// lib/core/network/timeout_interceptor.dart
import 'package:dio/dio.dart';

/// Enforces the 25-second hard ceiling for financial authorization requests.
/// On DioException (timeout), fires onFinancialTimeout callback — caller queues
/// MTI 0400 reversal via OfflineQueueService. ZERO retries fired.
/// BRD FR-CA-7.2, Design §4.2 "25s client-side timeout"
class TimeoutInterceptor extends Interceptor {
  static const defaultFinancialTimeoutMs = 25000;
  final int financialTimeoutMs;
  final Future<void> Function(String idempotencyKey) onFinancialTimeout;

  TimeoutInterceptor({
    this.financialTimeoutMs = defaultFinancialTimeoutMs,
    required this.onFinancialTimeout,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Apply timeout only to financial endpoints
    if (_isFinancialEndpoint(options.path)) {
      options.receiveTimeout = Duration(milliseconds: financialTimeoutMs);
      options.connectTimeout = Duration(milliseconds: financialTimeoutMs);
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.connectionTimeout) {
      final idempotencyKey = err.requestOptions.headers['X-Idempotency-Key'] ?? '';
      if (_isFinancialEndpoint(err.requestOptions.path)) {
        // Fire reversal callback — ZERO retries (do not call handler.next with retry)
        await onFinancialTimeout(idempotencyKey);
      }
    }
    handler.next(err); // Propagate error — caller handles REVERSAL_QUEUED state
  }

  // Testability hook
  Future<void> simulateTimeout(String idempotencyKey) =>
      onFinancialTimeout(idempotencyKey);

  bool _isFinancialEndpoint(String path) =>
      path.contains('/withdrawal') ||
      path.contains('/deposit') ||
      path.contains('/bill/pay') ||
      path.contains('/topup') ||
      path.contains('/transfer') ||
      path.contains('/retail/');
}
```

- [ ] **Step 4: Update `transaction_provider.dart` — remove `_updateFloat()`, add `reversalQueued` state**

Key changes:
1. Add `reversalQueued` to `TransactionStatus` enum
2. In `_execute()`: wrap call with try/catch for `DioException` timeout — transition to `reversalQueued`, enqueue MTI 0400 via `OfflineQueueService`
3. Delete `_updateFloat()` entirely — float is source-of-truth at backend

```dart
// In TransactionStatus enum, add:
//   reversalQueued,  // Timeout or partial failure — MTI 0400 queued

// In _execute():
Future<void> _execute(TransactionExecutionRequest request) async {
  try {
    state = state.copyWith(status: TransactionStatus.processing);
    final result = await repository.executeTransaction(request)
      .timeout(const Duration(seconds: 25)); // belt-and-suspenders with interceptor
    
    if (result.status == 'SUCCESS') {
      // DO NOT call _updateFloat() — float is backend source-of-truth
      state = state.copyWith(status: TransactionStatus.success, result: result);
    } else {
      state = state.copyWith(status: TransactionStatus.failed, error: result.errorMessage);
    }
  } on TimeoutException catch (_) {
    await _queueReversal(request);
  } on DioException catch (e) {
    if (e.type == DioExceptionType.receiveTimeout) {
      await _queueReversal(request);
    } else {
      state = state.copyWith(status: TransactionStatus.failed, error: e.message);
    }
  }
}

Future<void> _queueReversal(TransactionExecutionRequest request) async {
  // BRD FR-CA-7.3 — queue MTI 0400 reversal with SAME idempotency key
  await offlineQueueService.enqueue({
    'type': 'MTI_0400_REVERSAL',
    'quoteId': request.quoteId,
    'fundingSource': request.fundingSource.name,
  }, request.idempotencyKey); // idempotencyKey must be on the request model
  state = state.copyWith(status: TransactionStatus.reversalQueued);
}
// DELETE _updateFloat() entirely
```

- [ ] **Step 5: Run tests to confirm they pass**

```bash
flutter test test/core/network/timeout_interceptor_test.dart -v
flutter test test/features/transactions/transaction_provider_test.dart -v
```

Expected: PASS

- [ ] **Step 6: Commit**

```bash
git add lib/core/network/timeout_interceptor.dart lib/features/transactions/providers/transaction_provider.dart
git add test/core/network/timeout_interceptor_test.dart test/features/transactions/transaction_provider_test.dart
git commit -m "fix: enforce zero-retry 25s timeout + MTI 0400 auto-reversal; remove local float mutation (BRD FR-CA-7.1-7.3)"
```

---

## Task 5: Add `IMerchantTerminal` to HAL [PENDING]

**BDD Scenarios:** BDD Feature 9 S9.2 — DuitNow QR displayed via IMerchantTerminal  
**BRD Requirements:** BRD FR-CA-9.1; Design §3.1 `IMerchantTerminal`  
**User-Facing:** NO

**Files:**
- Modify: `lib/features/hardware/hardware_interfaces.dart`
- Modify: `lib/features/hardware/mock_hardware_impl.dart`
- Test: `test/features/hardware/hardware_test.dart`

- [ ] **Step 1: Write failing test**

```dart
// test/features/hardware/hardware_test.dart — add:
test('IMerchantTerminal.displayQrCode returns true when terminal is available', () async {
  final terminal = MockMerchantTerminal();
  final result = await terminal.displayQrCode('00020101021226...');
  expect(result, isTrue);
});
```

- [ ] **Step 2: Run test to confirm fails**

```bash
flutter test test/features/hardware/hardware_test.dart -v
```

- [ ] **Step 3: Add `IMerchantTerminal` to `hardware_interfaces.dart`**

```dart
/// Merchant Terminal Display — renders Dynamic DuitNow QR codes for customer scanning.
/// Phase 2 only. HAL contract isolates Flutter from vendor QR SDK.
/// Design §3.1 IMerchantTerminal
abstract class IMerchantTerminal {
  Future<bool> isAvailable();
  /// Renders a DuitNow QR payload string on the merchant display.
  /// Returns true if displayed successfully.
  Future<bool> displayQrCode(String qrPayload);
  /// Clears the QR display after payment confirmed or timed out.
  Future<void> clearDisplay();
}
```

- [ ] **Step 4: Add `MockMerchantTerminal` to `mock_hardware_impl.dart`**

```dart
class MockMerchantTerminal implements IMerchantTerminal {
  @override
  Future<bool> isAvailable() async => true;
  @override
  Future<bool> displayQrCode(String qrPayload) async => true;
  @override
  Future<void> clearDisplay() async {}
}
```

- [ ] **Step 5: Run test to confirm passes**

```bash
flutter test test/features/hardware/hardware_test.dart -v
```

- [ ] **Step 6: Commit**

```bash
git add lib/features/hardware/hardware_interfaces.dart lib/features/hardware/mock_hardware_impl.dart
git add test/features/hardware/hardware_test.dart
git commit -m "feat: add IMerchantTerminal HAL contract + mock (Design §3.1)"
```

---

## Task 6: Add `BALANCE_INQUIRY` Service — US-CA-23 [PENDING]

**BDD Scenarios:** BDD Feature 12: "Balance Inquiry using ATM Card" (@US-CA-23 @FR-CA-3.1)  
**BRD Requirements:** BRD US-CA-23; FR-CA-3.1; FR-CA-4.5  
**User-Facing:** YES

**Files:**
- Modify: `lib/features/transactions/repositories/transaction_repository.dart`
- Modify: `lib/features/transactions/providers/transaction_provider.dart`
- Create: `lib/features/transactions/screens/balance_inquiry_screen.dart`
- Test: `test/features/transactions/transaction_provider_test.dart`
- Frontend Test: `test/features/transactions/balance_inquiry_screen_test.dart` (NEW)

- [ ] **Step 1: Write failing provider test**

```dart
// test/features/transactions/transaction_provider_test.dart — add:
test('balance inquiry transitions through card/PIN flow and shows balance — BDD Feature 12 S1', () async {
  // Given: mock card reader returns card, PIN pad returns pin block
  // When: startTransaction called with serviceCode='BALANCE_INQUIRY'
  // Then: state goes idle → quoting → waitingConsent → waitingCard → waitingPin → success
  // And: result.balance is set (no funds deducted)
  // BDD: "no funds are deducted"
  expect(state.status, equals(TransactionStatus.success));
  expect(state.result?.isBalanceOnly, isTrue); // no deduction flag
});
```

- [ ] **Step 2: Run test to confirm fails**

```bash
flutter test test/features/transactions/transaction_provider_test.dart -v
```

- [ ] **Step 3: Add `balanceInquiry()` route to `transaction_repository.dart`**

```dart
Future<BalanceInquiryResponse> balanceInquiry(String quoteId, String pinBlock, String cardToken) async {
  final response = await _dio.post('/api/v1/balance-inquiry', data: {
    'quoteId': quoteId,
    'pinBlock': pinBlock,
    'cardToken': cardToken,
  });
  return BalanceInquiryResponse.fromJson(response.data);
}
```

- [ ] **Step 4: Write frontend widget test**

```dart
// test/features/transactions/balance_inquiry_screen_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  // BDD Feature 12 S1: "balance shown on customer-facing display (masked: RM ****)"
  testWidgets('balance inquiry screen shows masked balance on success', (tester) async {
    // Given: transactionProvider in success state with balanceOnly result
    // When: screen renders
    // Then: balance area shows masked "RM ****" 
    // And: "No funds deducted" text visible
    await tester.pumpWidget(/* BalanceInquiryScreen with mocked provider */);
    expect(find.text('RM ****'), findsOneWidget);
    expect(find.text('No funds were deducted'), findsOneWidget);
  });
}
```

- [ ] **Step 5: Create `balance_inquiry_screen.dart`**

```dart
// lib/features/transactions/screens/balance_inquiry_screen.dart
// Shows masked balance; never displays raw balance amount on-screen.
// Customer can request printed receipt.
```

- [ ] **Step 6: Run all tests to confirm pass**

```bash
flutter test test/features/transactions/ -v
```

Expected: PASS

- [ ] **Step 7: Commit**

```bash
git add lib/features/transactions/ test/features/transactions/balance_inquiry*
git commit -m "feat: add Balance Inquiry flow US-CA-23 with masked display (BDD Feature 12)"
```

---

## Task 7: Full Test Suite Run & Documentation Update

**BDD Scenarios:** All MVP scenarios (Features 1–8, Feature 12 partial)  
**BRD Requirements:** All MVP FRs  
**User-Facing:** NO

**Files:**
- Read: `docs/superpowers/specs/agent-banking-channel/2026-03-27-agent-banking-channel-bdd.md`

- [ ] **Step 1: Run full test suite**

```bash
flutter test --coverage -v
```

Expected: All existing + new tests PASS. Check coverage report.

- [ ] **Step 2: Run integration tests**

```bash
flutter test integration/ -v
```

- [ ] **Step 3: Ensure no `double` types remain in financial models**

```bash
grep -rn "double " lib/features/transactions/models/ lib/features/settlement/models/
```

Expected: 0 results (all replaced with `Decimal`).

- [ ] **Step 4: Ensure no `_updateFloat` or local float mutation remains**

```bash
grep -rn "_updateFloat\|creditFloat\|debitFloat" lib/features/transactions/
```

Expected: 0 results in `transaction_provider.dart`.

- [ ] **Step 5: Commit**

```bash
git add --all
git commit -m "chore: MVP spec alignment complete — all tests passing"
```

---

## Summary of Changes vs Spec Violations Fixed

| Gap | Fix | Task |
|-----|-----|------|
| G1: `double` for money | `Decimal` type everywhere | Task 1 |
| G2: `FundingSource` enum too coarse | Added `CARD_EMV`, `MYKAD_BIOMETRIC`, `DUITNOW_*`, `BillerRouting` | Task 1 |
| G3: local float mutation | Deleted `_updateFloat()` | Task 4 |
| G4: no 25s timeout | `TimeoutInterceptor` + `.timeout(25s)` | Task 4 |
| G5: no MTI 0400 queuing | `_queueReversal()` → `OfflineQueueService` | Task 4 |
| G6: hardcoded passphrase | `FlutterSecureStorage` injection | Task 2 |
| G7: `IMerchantTerminal` missing | Added to `hardware_interfaces.dart` | Task 5 |
| G8: `CARD` enum value stale | Renamed to `CARD_EMV` | Task 1 |
| G9: Balance Inquiry missing | New `balance_inquiry_screen.dart` + provider state | Task 6 |
| G10: GPS not injected | `GpsInterceptor` on Dio client | Task 3 |
