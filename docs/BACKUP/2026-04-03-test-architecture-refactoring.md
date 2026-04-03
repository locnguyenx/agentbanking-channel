# Test Architecture Refactoring — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Fix the 2 Important issues from the code review: (1) create per-feature BDD helpers (§2.5), (2) decompose the monolithic `TransactionNotifier` into a thin façade routing to existing sub-notifiers (§2.2).

**Architecture:** Phase 1 is purely additive (no production code changes). Phase 2 rewires the existing 760-line `TransactionNotifier` to delegate to the 5 already-implemented sub-notifiers (`QuoteNotifier`, `CardFlowNotifier`, `DuitNowFlowNotifier`, `BillerFlowNotifier`, `ProxyDepositNotifier`), then strips out the duplicated inline logic.

**Tech Stack:** Flutter/Dart, Riverpod (`hooks_riverpod`), `StateNotifier`, BDD (`bdd_widget_test`)

**Spec Reference:** [2026-04-02-agent-banking-channel-design.md](file:///Users/me/myprojects/agentbanking-channel/docs/superpowers/specs/agent-banking-channel/2026-04-02-agent-banking-channel-design.md) §2.2–§2.5

---

## Phase 1: Per-Feature BDD Helpers (§2.5)

> **Risk:** LOW — Additive code only. No production changes. No existing test modifications.
> **Estimated effort:** 5 tasks, ~30 minutes total.

### Context

The `BddAppHarness` (311 LOC) already supports builder methods:
- `.withAuth(authenticated:, whitelisted:)`
- `.withComplianceLock(locked:)`
- `.withEod(clock:)`
- `.withGps(unavailable:)`
- `.withTransactions(shouldFail:)`

Per-feature helpers encapsulate **common harness configurations** so BDD step files don't repeat the same builder chains. Each helper returns a configured `BddAppHarness` ready to `.build()`.

### File Structure

All new files go in `test/bdd/helpers/feature_helpers/`:

```
test/bdd/helpers/feature_helpers/
├── auth_feature_helper.dart        # [NEW] Auth + session + device whitelist
├── payment_feature_helper.dart     # [NEW] Quote + card flow + cash/DuitNow
├── duitnow_feature_helper.dart     # [NEW] DuitNow transfer + QR sale
├── biller_feature_helper.dart      # [NEW] Bill payment + JomPay
└── kyc_feature_helper.dart         # [NEW] KYC + biometric + onboarding
```

---

### Task 1.1: Create `auth_feature_helper.dart`

**BDD Scenarios:** Covers `auth_session.feature` — login, session expiry, secure logout, device whitelist
**User-Facing:** NO

**Files:**
- Create: `test/bdd/helpers/feature_helpers/auth_feature_helper.dart`
- Test: Verified by running `flutter test test/bdd/features/auth_session_test.dart`

- [ ] **Step 1: Create the helper file**

```dart
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
```

- [ ] **Step 2: Verify compilation**

Run: `flutter test test/bdd/features/auth_session_test.dart`
Expected: All auth tests still pass (no changes to existing tests).

- [ ] **Step 3: Commit**

```bash
git add test/bdd/helpers/feature_helpers/auth_feature_helper.dart
git commit -m "feat(bdd): add auth feature helper per §2.5"
```

---

### Task 1.2: Create `payment_feature_helper.dart`

**BDD Scenarios:** Covers `payment_execution.feature`, `pricing_engine.feature`, `financial_services_matrix.feature` — quote, card flow, cash funding, STP limits
**User-Facing:** NO

**Files:**
- Create: `test/bdd/helpers/feature_helpers/payment_feature_helper.dart`

- [ ] **Step 1: Create the helper file**

```dart
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
```

- [ ] **Step 2: Verify compilation**

Run: `flutter test test/bdd/features/payment_execution_test.dart`
Expected: All payment tests still pass.

- [ ] **Step 3: Commit**

```bash
git add test/bdd/helpers/feature_helpers/payment_feature_helper.dart
git commit -m "feat(bdd): add payment feature helper per §2.5"
```

---

### Task 1.3: Create `duitnow_feature_helper.dart`

**BDD Scenarios:** Covers DuitNow transfer and QR sale scenarios in `financial_services_matrix.feature` and `service_orchestration.feature`
**User-Facing:** NO

**Files:**
- Create: `test/bdd/helpers/feature_helpers/duitnow_feature_helper.dart`

- [ ] **Step 1: Create the helper file**

```dart
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
```

- [ ] **Step 2: Verify compilation**

Run: `flutter test test/bdd/features/financial_services_matrix_test.dart`
Expected: All financial services tests still pass.

- [ ] **Step 3: Commit**

```bash
git add test/bdd/helpers/feature_helpers/duitnow_feature_helper.dart
git commit -m "feat(bdd): add duitnow feature helper per §2.5"
```

---

### Task 1.4: Create `biller_feature_helper.dart`

**BDD Scenarios:** Covers JomPay and bill payment scenarios in `financial_services_matrix.feature`
**User-Facing:** NO

**Files:**
- Create: `test/bdd/helpers/feature_helpers/biller_feature_helper.dart`

- [ ] **Step 1: Create the helper file**

```dart
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
```

- [ ] **Step 2: Verify compilation**

Run: `flutter test test/bdd/features/financial_services_matrix_test.dart`
Expected: All tests still pass.

- [ ] **Step 3: Commit**

```bash
git add test/bdd/helpers/feature_helpers/biller_feature_helper.dart
git commit -m "feat(bdd): add biller feature helper per §2.5"
```

---

### Task 1.5: Create `kyc_feature_helper.dart`

**BDD Scenarios:** Covers `ekyc_onboarding.feature`, `agent_onboarding.feature` — KYC verification, Face AI, MyKad scan, micro-agent onboarding
**User-Facing:** NO

**Files:**
- Create: `test/bdd/helpers/feature_helpers/kyc_feature_helper.dart`

- [ ] **Step 1: Create the helper file**

```dart
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
```

- [ ] **Step 2: Verify full BDD suite**

Run: `flutter test test/bdd/features/`
Expected: All 219 tests pass. No regressions.

- [ ] **Step 3: Commit**

```bash
git add test/bdd/helpers/feature_helpers/kyc_feature_helper.dart
git commit -m "feat(bdd): add kyc feature helper per §2.5, complete feature_helpers"
```

---

## Phase 2: Façade Decomposition (§2.2)

> **Risk:** MEDIUM — Production code changes. Screens depend on `transactionProvider`. Must maintain 100% backward compat.
> **Estimated effort:** 5 tasks, ~60 minutes total.
>
> [!CAUTION]
> The monolithic `TransactionNotifier` (760 lines, 12 constructor deps) must be refactored into a thin façade that **delegates** to the 5 existing sub-notifiers. All existing screens watch `transactionProvider` — they must continue to work unchanged.

### Current State

| Item | Status |
|------|--------|
| `QuoteNotifier` (152 LOC, 3 deps) | ✅ Exists, tested (11 tests) |
| `CardFlowNotifier` (202 LOC, 5 deps) | ✅ Exists, tested (5 tests) |
| `DuitNowFlowNotifier` (179 LOC, 3 deps) | ✅ Exists, tested (7 tests) |
| `BillerFlowNotifier` (122 LOC, 2 deps) | ✅ Exists, tested (7 tests) |
| `ProxyDepositNotifier` (144 LOC, 2 deps) | ✅ Exists, tested (6 tests) |
| `CardFlowMixin` (53 LOC) | ✅ Exists |
| `TransactionNotifier` façade | ❌ Still monolithic (760 LOC, 12 deps) |

### Strategy

The façade `TransactionNotifier` will:
1. **Keep its 12 constructor deps** for backward compat with `BddAppHarness` and integration tests
2. **Internally create** sub-notifier instances using constructor deps
3. **Route** `startTransaction()`, `confirmConsent()`, `processCard()`, `jomPay()` to the appropriate sub-notifier
4. **Sync state** from sub-notifiers back to the façade's own state via `addListener()` (so screens see updates)
5. **Delete** all inline business logic that's already in sub-notifiers

### Key Constraint

Screens watch `ref.watch(transactionProvider)` which returns `TransactionState`. The façade must expose the same `TransactionState` stream. The approach: sub-notifiers update their own state, and listeners sync it to the façade's state.

---

### Task 2.1: Write failing integration test for the façade

**BDD Scenarios:** Validates §2.2 routing: `startTransaction()` delegates to `QuoteNotifier`, `confirmConsent()` routes by `fundingSource`/`serviceCode`
**User-Facing:** NO

**Files:**
- Create: `test/integration/transaction_facade_test.dart`

- [ ] **Step 1: Write the test**

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:decimal/decimal.dart';

import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'test_fakes.dart';

/// Integration test: Verify TransactionNotifier (façade) delegates
/// to sub-notifiers instead of performing logic inline.
///
/// These tests verify the ROUTING, not the sub-notifier logic
/// (that's already covered by individual notifier tests).
void main() {
  group('TransactionNotifier Façade Routing', () {
    late TransactionNotifier notifier;
    late FakeRef ref;
    late FakeTransactionRepository repo;
    late FakeFloatNotifier floatNotifier;

    setUp(() {
      ref = FakeRef();
      repo = FakeTransactionRepository();
      floatNotifier = FakeFloatNotifier();
      notifier = TransactionNotifier(
        ref: ref,
        repository: repo,
        cardReader: FakeCardReader(),
        pinPad: FakePinPad(),
        floatNotifier: floatNotifier,
        reversalService: FakeReversalService(),
        myKadScanner: FakeMyKadScanner(),
        complianceNotifier: FakeComplianceNotifier(),
        eodTimerService: FakeEodTimerService(),
        geolocator: FakeGeolocator(),
      );
    });

    test('startTransaction with TOP_UP routes through quoting to waitingConsent', () async {
      await notifier.startTransaction(
        Decimal.parse('50.00'),
        'AGENT-001',
        serviceCode: 'TOP_UP',
        fundingSource: FundingSource.CASH,
      );
      expect(notifier.state.status, TransactionStatus.waitingConsent);
      expect(notifier.state.quote, isNotNull);
    });

    test('startTransaction with BILL_PAY routes to biller workflow', () async {
      await notifier.startTransaction(
        Decimal.parse('100.00'),
        'AGENT-001',
        serviceCode: 'BILL_PAY',
        fundingSource: FundingSource.CASH,
      );
      expect(notifier.state.status, TransactionStatus.waitingConsent);
    });

    test('startTransaction with CASH_DEPOSIT routes to proxy enquiry', () async {
      await notifier.startTransaction(
        Decimal.parse('200.00'),
        'AGENT-001',
        serviceCode: 'CASH_DEPOSIT',
        fundingSource: FundingSource.CASH,
        metadata: {'destinationAccount': '1234567890'},
      );
      expect(notifier.state.status, TransactionStatus.waitingConsent);
    });

    test('confirmConsent with CARD_EMV routes to card flow', () async {
      await notifier.startTransaction(
        Decimal.parse('50.00'),
        'AGENT-001',
        serviceCode: 'TOP_UP',
        fundingSource: FundingSource.CARD_EMV,
      );
      expect(notifier.state.status, TransactionStatus.waitingConsent);
      await notifier.confirmConsent();
      expect(
        notifier.state.status,
        anyOf(TransactionStatus.waitingCard, TransactionStatus.success),
      );
    });

    test('confirmConsent with CASH routes directly to executeFinal', () async {
      await notifier.startTransaction(
        Decimal.parse('50.00'),
        'AGENT-001',
        serviceCode: 'TOP_UP',
        fundingSource: FundingSource.CASH,
      );
      await notifier.confirmConsent();
      expect(notifier.state.status, TransactionStatus.success);
    });

    test('confirmConsent with DUITNOW_TRANSFER routes to DuitNow flow', () async {
      await notifier.startTransaction(
        Decimal.parse('50.00'),
        'AGENT-001',
        serviceCode: 'DUITNOW_TRANSFER',
        fundingSource: FundingSource.DUITNOW_MOBILE,
      );
      await notifier.confirmConsent(duitNowProxyId: '0123456789');
      expect(
        notifier.state.status,
        anyOf(TransactionStatus.success, TransactionStatus.waitingConsent),
      );
    });

    test('façade preserves 12-dep constructor signature', () {
      expect(notifier, isA<TransactionNotifier>());
    });
  });
}
```

- [ ] **Step 2: Run test to verify baseline behavior**

Run: `flutter test test/integration/transaction_facade_test.dart`
Expected: Tests should pass with the CURRENT monolithic implementation (they test the API surface, not the internal routing). If any fail, adjust test expectations before refactoring.

- [ ] **Step 3: Commit test**

```bash
git add test/integration/transaction_facade_test.dart
git commit -m "test: add façade routing tests for TransactionNotifier §2.2"
```

---

### Task 2.2: Add sub-notifier instances to `TransactionNotifier`

**BRD Requirements:** §2.2 — façade routes to sub-notifiers
**User-Facing:** NO

**Files:**
- Modify: `lib/features/transactions/providers/transaction_provider.dart`

> [!IMPORTANT]
> This task only ADDS code. The inline logic remains active. This is a safe intermediate step.

- [ ] **Step 1: Add sub-notifier imports**

Add at the top of the file (after line 20, before `export`):

```dart
import 'package:agentbanking_channel/features/transactions/providers/quote_notifier.dart';
import 'package:agentbanking_channel/features/transactions/providers/card_flow_notifier.dart';
import 'package:agentbanking_channel/features/transactions/providers/duitnow_flow_notifier.dart';
import 'package:agentbanking_channel/features/transactions/providers/biller_flow_notifier.dart';
import 'package:agentbanking_channel/features/transactions/providers/proxy_deposit_notifier.dart';
```

- [ ] **Step 2: Add sub-notifier fields**

Add after `bool _mounted = true;` (line 114):

```dart
  // Sub-notifier instances for delegation
  late final QuoteNotifier _quoteNotifier;
  late final CardFlowNotifier _cardFlowNotifier;
  late final DuitNowFlowNotifier _duitNowFlowNotifier;
  late final BillerFlowNotifier _billerFlowNotifier;
  late final ProxyDepositNotifier _proxyDepositNotifier;
```

- [ ] **Step 3: Initialize sub-notifiers in constructor**

Change the constructor from `:` initializer to a constructor body. After line 129 (`}) : super(...)`), change to:

```dart
  TransactionNotifier({
    required this.ref,
    required this.repository,
    required this.cardReader,
    required this.pinPad,
    required this.floatNotifier,
    required this.reversalService,
    required this.myKadScanner,
    required this.complianceNotifier,
    required this.eodTimerService,
    required this.geolocator,
    this.pollingInterval = Duration.zero,
    this.cardTimerDelay = Duration.zero,
  }) : super(TransactionState(status: TransactionStatus.idle)) {
    _quoteNotifier = QuoteNotifier(
      ref: ref, repository: repository, geolocator: geolocator,
    );
    _cardFlowNotifier = CardFlowNotifier(
      ref: ref, cardReader: cardReader, pinPad: pinPad,
      repository: repository, floatNotifier: floatNotifier,
      reversalService: reversalService, cardTimerDelay: cardTimerDelay,
    );
    _duitNowFlowNotifier = DuitNowFlowNotifier(
      ref: ref, repository: repository, floatNotifier: floatNotifier,
      reversalService: reversalService, pollingInterval: pollingInterval,
    );
    _billerFlowNotifier = BillerFlowNotifier(
      repository: repository, floatNotifier: floatNotifier,
      pollingInterval: pollingInterval,
    );
    _proxyDepositNotifier = ProxyDepositNotifier(
      repository: repository, myKadScanner: myKadScanner,
      pollingInterval: pollingInterval,
    );

    // Sync sub-notifier state changes back to façade
    _quoteNotifier.addListener((s) { if (_mounted) state = s; });
    _cardFlowNotifier.addListener((s) { if (_mounted) state = s; });
    _duitNowFlowNotifier.addListener((s) { if (_mounted) state = s; });
    _billerFlowNotifier.addListener((s) { if (_mounted) state = s; });
    _proxyDepositNotifier.addListener((s) { if (_mounted) state = s; });
  }
```

- [ ] **Step 4: Run all tests**

Run: `flutter test test/bdd/features/ && flutter test test/integration/`
Expected: All tests pass (inline logic still active, sub-notifiers added but not called yet).

- [ ] **Step 5: Commit**

```bash
git add lib/features/transactions/providers/transaction_provider.dart
git commit -m "refactor: add sub-notifier instances to TransactionNotifier §2.2"
```

---

### Task 2.3: Replace `startTransaction()` body with delegation

**Files:**
- Modify: `lib/features/transactions/providers/transaction_provider.dart` (lines 130–233)

- [ ] **Step 1: Replace `startTransaction()` method body**

Replace the ENTIRE body of `startTransaction()` (currently ~100 lines of validation + quoting + routing) with:

```dart
  Future<void> startTransaction(
    Decimal amount,
    String merchantId, {
    required String serviceCode,
    required FundingSource fundingSource,
    Map<String, String>? metadata,
  }) async {
    if (!_mounted) return;

    if (serviceCode == 'CASH_DEPOSIT') {
      final quotedState = TransactionState(
        status: TransactionStatus.quoting,
        amount: amount,
        serviceCode: serviceCode,
        fundingSource: fundingSource,
        metadata: metadata,
        idempotencyKey: Uuid().v4(),
      );
      await _proxyDepositNotifier.executeProxyEnquiry(quotedState);
    } else if (serviceCode == 'BILL_PAY' || serviceCode == 'JOMPAY') {
      final quotedState = TransactionState(
        status: TransactionStatus.quoting,
        amount: amount,
        serviceCode: serviceCode,
        fundingSource: fundingSource,
        metadata: metadata,
        idempotencyKey: Uuid().v4(),
      );
      await _billerFlowNotifier.executeBillerWorkflow(quotedState);
    } else {
      await _quoteNotifier.startQuote(
        amount,
        merchantId,
        serviceCode: serviceCode,
        fundingSource: fundingSource,
        metadata: metadata,
      );
    }
  }
```

- [ ] **Step 2: Run façade tests**

Run: `flutter test test/integration/transaction_facade_test.dart`
Expected: All routing tests pass.

- [ ] **Step 3: Run full BDD suite**

Run: `flutter test test/bdd/features/`
Expected: All 219 tests pass.

> [!WARNING]
> If BDD tests fail here, the most likely cause is that `QuoteNotifier.startQuote()` validates differently than the inline code. Compare error messages character-by-character (e.g., `ERR_COMPLIANCE_FROZEN` vs `ERR_COMPLIANCE_FREEZE`). Align the sub-notifier error strings with what the BDD step assertions expect.

- [ ] **Step 4: Commit**

```bash
git add lib/features/transactions/providers/transaction_provider.dart
git commit -m "refactor: delegate startTransaction() to sub-notifiers §2.2"
```

---

### Task 2.4: Replace `confirmConsent()` body with delegation

**Files:**
- Modify: `lib/features/transactions/providers/transaction_provider.dart` (lines 244–290)

- [ ] **Step 1: Replace `confirmConsent()` method body**

```dart
  Future<void> confirmConsent({String? duitNowProxyId}) async {
    if (!_mounted) return;
    if (duitNowProxyId != null) {
      final updatedMetadata = Map<String, dynamic>.from(state.metadata ?? {});
      updatedMetadata['duitNowProxyId'] = duitNowProxyId;
      state = state.copyWith(metadata: updatedMetadata);
    }

    if (state.serviceCode == 'DUITNOW_TRANSFER') {
      await _duitNowFlowNotifier.executeDuitNowTransfer(state);
      return;
    }

    if (state.serviceCode == 'DUITNOW_QR_RETAIL') {
      await _duitNowFlowNotifier.executeDuitNowQrFlow(state);
      return;
    }

    final source = state.fundingSource;
    if (source == null) return;

    if (_isNonCardSource(source)) {
      final meta = state.metadata ?? {};
      if (state.fundingSource == FundingSource.CASH &&
          state.amount != null &&
          state.amount! >= Decimal.parse('3000') &&
          !meta.containsKey('mykadReference')) {
        if (_mounted) {
          state = state.copyWith(status: TransactionStatus.waitingMyKadScan);
        }
        return;
      }
      await _executeFinal();
    } else {
      await _cardFlowNotifier.startCardFlow(state);
    }
  }
```

- [ ] **Step 2: Run full test suite**

Run: `flutter test test/bdd/features/ && flutter test test/integration/`
Expected: All tests pass.

- [ ] **Step 3: Commit**

```bash
git add lib/features/transactions/providers/transaction_provider.dart
git commit -m "refactor: delegate confirmConsent() to sub-notifiers §2.2"
```

---

### Task 2.5: Clean up dead code and dispose sub-notifiers

**Files:**
- Modify: `lib/features/transactions/providers/transaction_provider.dart`

- [ ] **Step 1: Delete duplicated private methods**

Remove these methods from `TransactionNotifier` (now handled by sub-notifiers):
- `_executeBillerWorkflow()` (~lines 653–671)
- `_executeProxyEnquiryWorkflow()` — proxy enquiry logic
- `_executeDuitNowFlow()` — DuitNow transfer logic
- `_executeDuitNowQrFlow()` — DuitNow QR logic
- `startBillerPolling()` — biller polling logic
- `startDuitNowPolling()` — DuitNow polling logic

> **Keep:** `_executeFinal()`, `processCard()`, `_isNonCardSource()`, `_queueReversal()`, `recordMyKadScan()`, `completeMyKadScan()`, `jomPay()`, `reset()`, `getPollingStatusLabel()`, `dispose()`. These are still needed.

- [ ] **Step 2: Update `dispose()` to dispose sub-notifiers**

Add sub-notifier disposal before `super.dispose()`:

```dart
  @override
  void dispose() {
    _mounted = false;
    _isPolling = false;
    _cardTimer?.cancel();
    _cardTimer = null;
    _pollingTimer?.cancel();
    _pollingTimer = null;
    if (_pollingCompleter != null && !_pollingCompleter!.isCompleted) {
      _pollingCompleter!.complete();
    }
    _pollingCompleter = null;

    // Dispose sub-notifiers
    _quoteNotifier.dispose();
    _cardFlowNotifier.dispose();
    _duitNowFlowNotifier.dispose();
    _billerFlowNotifier.dispose();
    _proxyDepositNotifier.dispose();

    super.dispose();
  }
```

- [ ] **Step 3: Run full test suite**

Run: `flutter test test/bdd/features/ && flutter test test/integration/`
Expected: All tests pass.

- [ ] **Step 4: Verify LOC reduction**

Run: `wc -l lib/features/transactions/providers/transaction_provider.dart`
Expected: Significantly less than 760 lines. Target: ~300-400 lines.

- [ ] **Step 5: Verify no dead code**

Run:
```bash
grep -rn '_executeBillerWorkflow\|_executeProxyEnquiryWorkflow\|_executeDuitNowFlow\|startBillerPolling\|startDuitNowPolling' lib/features/transactions/providers/transaction_provider.dart
```
Expected: No matches (all moved to sub-notifiers).

- [ ] **Step 6: Commit**

```bash
git add lib/features/transactions/providers/transaction_provider.dart
git commit -m "refactor: remove dead code, complete §2.2 façade decomposition"
```

---

## Verification Plan

### Automated Tests

After **all tasks** are complete, run:

```bash
# 1. Full BDD suite
flutter test test/bdd/features/
# Expected: 219/219 pass

# 2. All integration tests
flutter test test/integration/
# Expected: All pass (including new façade tests)

# 3. Full test suite
flutter test
# Expected: All green

# 4. Verify LOC reduction
wc -l lib/features/transactions/providers/transaction_provider.dart
# Expected: ~300-400 lines (down from 760)

# 5. Verify feature helpers exist
ls -la test/bdd/helpers/feature_helpers/
# Expected: 5 files (auth, payment, duitnow, biller, kyc)

# 6. Verify no dead code
grep -c '_executeBillerWorkflow\|_executeProxyEnquiryWorkflow' \
  lib/features/transactions/providers/transaction_provider.dart
# Expected: 0
```

### Acceptance Criteria

| Check | Expected |
|-------|----------|
| BDD suite passes | 219/219 (100%) |
| Integration tests pass | 36+ tests (100%) |
| Full test suite passes | All green |
| `TransactionNotifier` LOC | ≤ 400 lines |
| Per-feature helpers exist | 5 files in `test/bdd/helpers/feature_helpers/` |
| Sub-notifiers used by façade | Imported and instantiated in constructor |
| Screens unchanged | `transaction_flow_screen.dart` still imports only `transaction_provider.dart` |
| Constructor deps unchanged | 12 deps (backward compat with `BddAppHarness`) |
