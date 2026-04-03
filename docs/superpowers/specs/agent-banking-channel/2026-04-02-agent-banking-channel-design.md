# System Design Specification: Agent Banking Channel App

**Version:** 3.0  
**Date:** 2026-04-02  
**Module:** Channel App (Flutter POS/Mobile)  
**Supersedes:** `2026-03-27-agent-banking-channel-design.md` (v2.0)  
**BRD Reference:** `docs/superpowers/specs/agent-banking-channel/2026-03-27-agent-banking-channel-brd.md`  
**Platform Design Reference:** `docs/superpowers/specs/agent-banking-platform/2026-03-25-agent-banking-platform-design.md`  
**Root Cause Analysis:** `brain/206af1c4/root_cause_analysis.md`

---

## Changelog from v2.0

| Section | Change |
|---------|--------|
| §1.3 Clean Architecture | Added `providers/` sub-structure showing notifier split |
| §2.2 `transactionProvider` | Refactored from single 705-line God class into 5 focused notifiers + thin façade |
| §2.3 *(new)* | Decomposed Transaction Notifier Architecture — dependency graph, mixin, testing strategy |
| §2.4 *(new)* | Integration Test Layer — mandatory layer between unit tests and BDD |
| §2.5 *(new)* | BDD Infrastructure — builder-pattern harness replacing global-mock God Object |

All other sections (§1.1, §1.2, §3–§9) remain unchanged from v2.0.

---

## 1. Architectural Overview

### 1.1–1.2

*Unchanged from v2.0. See `2026-03-27-agent-banking-channel-design.md`.*

### 1.3 Clean Architecture Layers (Revised)

```
lib/
├── core/                     # Cross-cutting concerns
│   ├── network/              # Dio client, interceptors, TLS pinning, GPS header injection
│   ├── security/             # Secure storage manager, PII redaction logger
│   ├── errors/               # Error code constants (ERR_BIZ_xxx / ERR_EXT_xxx)
│   └── constants/            # STP hard caps (RM 3,000/txn, 5 txn/hr), timeout values
├── features/
│   ├── auth/                 # Login, biometric unlock, session timer, JWT lifecycle
│   ├── dashboard/            # Float balance polling (30s), geofence indicator, EOD banner
│   ├── hardware/             # HAL: ICardReader, IPinPad, IPrinter, IBiometricScanner,
│   │                         #      IMerchantTerminal, hardware_providers.dart
│   ├── transactions/
│   │   ├── models/           # TransactionState, TransactionStatus, request/response DTOs
│   │   ├── providers/
│   │   │   ├── transaction_provider.dart   # Thin façade (backward-compat)
│   │   │   ├── quote_notifier.dart         # Validation + quoting
│   │   │   ├── card_flow_notifier.dart     # Card+PIN → execute → success/reversal
│   │   │   ├── card_flow_mixin.dart        # Shared card+PIN capture
│   │   │   ├── duitnow_flow_notifier.dart  # DuitNow transfer + QR polling
│   │   │   ├── biller_flow_notifier.dart   # Bill payment + JomPay polling
│   │   │   └── proxy_deposit_notifier.dart # Cash deposit + MyKad
│   │   ├── repositories/    # TransactionRepository (8 API clients)
│   │   ├── screens/         # transaction_flow_screen.dart, forms
│   │   ├── services/        # ReversalService, ValidationService
│   │   └── widgets/         # Reusable transaction UI components
│   ├── bills/                # ESSP, E-wallet top-ups
│   ├── ekyc/                 # OCR extractor, Face AI Liveness bridge
│   ├── merchant/             # Retail Sale, PIN Purchase, Cash-Back Hybrid
│   └── agent_onboarding/     # Micro-Agent self-onboarding STP flow
└── main.dart                 # Riverpod ProviderScope, App Theme, GoRouter
```

---

## 2. State Management & Dependency Injection (Revised)

### 2.1 Framework
**Riverpod** (`hooks_riverpod`) with `StateNotifier` for state machines.

### 2.2 Core Providers

#### `authProvider`, `floatBalanceProvider`, `geofenceProvider`, `complianceLockProvider`

*Unchanged from v2.0. See `2026-03-27-agent-banking-channel-design.md` §2.2.*

#### `transactionProvider` — Thin Façade (Revised)

The original 705-line `TransactionNotifier` has been decomposed into 5 focused sub-notifiers. The `transactionProvider` remains as a thin façade for backward compatibility with existing screens.

```
┌────────────────────────────────────────────────────────┐
│  transactionProvider (Thin Façade)                      │
│  - Preserves original API surface                       │
│  - Routes to sub-notifiers by serviceCode/fundingSource │
│  - Screens consume this provider unchanged              │
└──────────┬─────────┬─────────┬──────────┬──────────────┘
           │         │         │          │
  ┌────────▼──┐ ┌────▼────┐ ┌─▼────────┐ ┌▼─────────────┐
  │QuoteNotif.│ │CardFlow │ │DuitNow   │ │BillerFlow    │
  │2 deps     │ │Notifier │ │FlowNotif.│ │Notifier      │
  │           │ │5 deps   │ │3 deps    │ │2 deps        │
  └───────────┘ └─────────┘ └──────────┘ └──────────────┘
                                          ┌──────────────┐
                                          │ProxyDeposit  │
                                          │Notifier      │
                                          │2 deps        │
                                          └──────────────┘
```

### 2.3 Decomposed Transaction Notifier Architecture

#### 2.3.1 Design Rationale

The monolithic `TransactionNotifier` suffered from:
- **12 constructor dependencies** — every test required mocking all 12
- **705 lines** mixing 5 distinct transaction flows in one class
- **State leakage** — DuitNow polling timers affected card flow tests
- **BDD bottleneck** — a scenario change in any flow required re-mocking the entire God class

The split follows the principle: **one notifier per transaction flow type**, each owning its complete lifecycle from initiation to success/failure.

#### 2.3.2 Sub-Notifier Specifications

##### `QuoteNotifier` — Input Validation & Quoting

| Property | Value |
|----------|-------|
| **File** | `lib/features/transactions/providers/quote_notifier.dart` |
| **Dependencies** | `TransactionRepository`, `GeolocatorPlatform` |
| **State Machine** | `idle → quoting → waitingConsent \| failed` |
| **Responsibility** | Geofence pre-check, phone validation, STP amount cap enforcement, `POST /transactions/quote` |

Guard checks executed before quoting:
1. Compliance freeze check (`ERR_COMPLIANCE_FROZEN`)
2. EOD lock check (`ERR_EOD_LOCKED`)
3. Geofence validation (`ERR_GEOFENCE_BREACH`, `ERR_GPS_UNAVAILABLE`)
4. Phone number format validation (`ERR_VAL_INVALID_PHONE_FORMAT`)
5. Universal hard cap: RM 5,000 per transaction
6. Cash STP hard cap: RM 3,000 (triggers MyKad scan above threshold)

##### `CardFlowNotifier` — Card-Funded Transactions

| Property | Value |
|----------|-------|
| **File** | `lib/features/transactions/providers/card_flow_notifier.dart` |
| **Dependencies** | `ICardReader`, `IPinPad`, `TransactionRepository`, `FloatNotifier`, `ReversalService` |
| **State Machine** | `waitingCard → waitingPin → processing → success \| failed \| reversalQueued` |
| **Uses** | `CardFlowMixin` for card+PIN capture sequence |

On timeout/network error during `processing`:
- Queues MTI 0400 reversal via `ReversalService`
- Transitions to `reversalQueued` state
- **ZERO retries** for financial authorization (hard banking requirement)

##### `DuitNowFlowNotifier` — DuitNow Transfer & QR

| Property | Value |
|----------|-------|
| **File** | `lib/features/transactions/providers/duitnow_flow_notifier.dart` |
| **Dependencies** | `TransactionRepository`, `FloatNotifier`, `ReversalService` |
| **State Machine** | `processing → processingDuitNow → success \| failed \| reversalQueued` |
| **Polling** | Every 5s, max 36 iterations (3 minutes), then timeout → reversal |

Supports two sub-flows:
1. **Proxy Transfer** — `initiateDuitNow()` → polls `getDuitNowStatus()`
2. **QR Retail Sale** — `generateQrSale()` → displays QR → polls `getDuitNowStatus()`

##### `BillerFlowNotifier` — Bill Payment & JomPay

| Property | Value |
|----------|-------|
| **File** | `lib/features/transactions/providers/biller_flow_notifier.dart` |
| **Dependencies** | `TransactionRepository`, `FloatNotifier` |
| **State Machine** | `processing → processingBiller → success \| failed` |
| **Polling** | Every `pollingInterval`, max 36 iterations, then `TIMEOUT` |

##### `ProxyDepositNotifier` — Cash Deposit & MyKad

| Property | Value |
|----------|-------|
| **File** | `lib/features/transactions/providers/proxy_deposit_notifier.dart` |
| **Dependencies** | `TransactionRepository`, `IMyKadScanner` |
| **State Machine** | `processing → waitingConsent \| waitingMyKadScan \| failed` |
| **Retry** | ProxyEnquiry uses exponential backoff: 1s, 2s, 4s (max 4 attempts) |

#### 2.3.3 Shared Card+PIN Mixin

```dart
/// file: lib/features/transactions/providers/card_flow_mixin.dart
///
/// Shared by CardFlowNotifier and MerchantNotifier to eliminate
/// duplicated card reading + PIN capture logic.
mixin CardFlowMixin {
  Future<({String cardToken, String pinBlock})?> captureCardAndPin(
    ICardReader cardReader, IPinPad pinPad);
}
```

Both `CardFlowNotifier` and `MerchantNotifier` use this mixin, reducing the card+PIN capture logic to a single implementation.

#### 2.3.4 Dependency Graph

```
                    ┌───────────────┐
           ┌───────►│ ICardReader   │◄──── hardware_providers.dart
           │        └───────────────┘
           │        ┌───────────────┐
           ├───────►│ IPinPad       │◄──── hardware_providers.dart
           │        └───────────────┘
┌──────────┴──┐     ┌───────────────┐
│CardFlowNotif├────►│ TxnRepository │◄──── QuoteNotifier
└─────────────┘     └───────┬───────┘      DuitNowFlowNotifier
                            │              BillerFlowNotifier
                            │              ProxyDepositNotifier
                    ┌───────▼───────┐
                    │ FloatNotifier  │◄──── CardFlowNotifier
                    └───────────────┘      DuitNowFlowNotifier
                    ┌───────────────┐      BillerFlowNotifier
                    │ReversalService│◄──── CardFlowNotifier
                    └───────────────┘      DuitNowFlowNotifier
                    ┌───────────────┐
                    │ IMyKadScanner │◄──── ProxyDepositNotifier
                    └───────────────┘
                    ┌───────────────┐
                    │ Geolocator    │◄──── QuoteNotifier
                    └───────────────┘
```

**Key constraint:** Hardware interfaces are injected via Riverpod `hardware_providers.dart`, not hardcoded mock constructors. This enables test overrides without touching production code.

#### 2.3.5 Backward Compatibility Strategy

The `transactionProvider` (façade) preserves the original API surface:
- `startTransaction()` — routes to `QuoteNotifier` or appropriate flow notifier
- `confirmConsent()` — routes to `CardFlowNotifier`, `DuitNowFlowNotifier`, or direct execution
- `processCard()` — delegates to `CardFlowNotifier`
- `balanceInquiry()` — inline (simple card flow)
- `jomPay()` — delegates to `BillerFlowNotifier`

Existing screens (`transaction_flow_screen.dart`, dashboard, forms) continue to watch `transactionProvider` unchanged. Screens can incrementally migrate to watch specific sub-notifiers for tighter coupling.

---

### 2.4 Integration Test Layer (New)

A mandatory testing layer between unit tests and BDD:

```
Unit Tests (shallow fakes, fast)
        │
        ▼
Integration Tests ◄── NEW: Direct notifier state-machine testing
        │                   No widget tree, no pumpBddApp
        ▼
BDD Tests (full widget tree, .feature files)
```

#### Test Pattern

Each integration test:
1. Constructs the notifier directly with fake/mock deps (2-5 per notifier)
2. Invokes methods
3. Asserts state transitions

```dart
test('CardFlowNotifier: card read → PIN → execute → success', () async {
  final notifier = CardFlowNotifier(
    cardReader: FakeCardReader(),         // returns mock card data
    pinPad: FakePinPad(),                 // returns mock PIN block
    repository: FakeTransactionRepository(),
    floatNotifier: FakeFloatNotifier(),
    reversalService: FakeReversalService(),
  );
  await notifier.confirmConsent();
  expect(notifier.state.status, TransactionStatus.success);
});
```

#### Coverage Targets

| Test File | Notifier | Key Scenarios |
|-----------|----------|---------------|
| `quote_notifier_test.dart` | QuoteNotifier | Amount caps, geofence breach, phone validation |
| `card_flow_notifier_test.dart` | CardFlowNotifier | Happy path, card fail, PIN cancel, timeout reversal |
| `duitnow_flow_notifier_test.dart` | DuitNowFlowNotifier | Proxy transfer, QR polling, timeout |
| `biller_flow_notifier_test.dart` | BillerFlowNotifier | Biller polling success/timeout, JomPay flow |
| `proxy_deposit_notifier_test.dart` | ProxyDepositNotifier | ProxyEnquiry retry, MyKad scan |

---

### 2.5 BDD Infrastructure (New)

#### Problem
The monolithic `bdd_test_helper.dart` (359 lines) created 16 global mutable mock overrides shared across all 12 features — a single interface change cascaded to all scenarios.

#### Solution: Builder-Pattern Harness

```dart
// file: test/bdd/helpers/app_harness.dart
await BddAppHarness(tester)
  .withAuth(authenticated: true)
  .withFloat(balance: Decimal.fromInt(5000))
  .withCardFlow(cardReader: FakeCardReader())
  .build();
```

Each `.with*()` adds only the Riverpod provider overrides needed for that scenario. Default behavior is "happy path" — tests only override what they're testing.

#### Per-Feature Helpers

```
test/bdd/helpers/
├── mock_factory.dart              # Factory functions for fresh mocks
├── app_harness.dart               # Builder-pattern BddAppHarness
└── feature_helpers/
    ├── auth_feature_helper.dart   # Auth + storage overrides
    ├── payment_feature_helper.dart # Quote + card flow overrides
    ├── duitnow_feature_helper.dart # DuitNow notifier overrides
    ├── biller_feature_helper.dart  # Biller notifier overrides
    └── kyc_feature_helper.dart    # KYC + biometric overrides
```

**Impact:** BDD scenario mock surface reduced from 16 overrides to 2-5 per scenario.

---

## 3–9. Unchanged Sections

*Sections 3 (HAL), 4 (Store & Forward), 5 (Security), 6 (System Workflows), 7 (EOD Settlement), 8 (Compliance Lock), and 9 (Key Technical Decisions) remain unchanged from v2.0.*

*See `2026-03-27-agent-banking-channel-design.md` for the full text of these sections.*

---

## 10. Key Technical Decisions (Addendum to v2.0 §9)

| Decision | Rationale |
|----------|-----------|
| **Split by flow type, not lifecycle stage** | Each notifier owns one complete flow (quote → success/failure). Splitting by stage (e.g., "QuotingNotifier", "ProcessingNotifier") would require cross-notifier state passing. |
| **Façade preserves original API** | Avoids a big-bang screen rewrite. Screens can migrate to direct sub-notifier watching incrementally. |
| **CardFlowMixin (not base class)** | Dart single-inheritance constraint. Both `CardFlowNotifier` and `MerchantNotifier` extend `StateNotifier`, so shared logic must be a mixin. |
| **Hardware injected via Riverpod** | `hardware_providers.dart` wraps mock implementations. Tests override providers, not constructors. This eliminates `MockCardReader()` hardcoded in provider definitions. |
| **Integration test layer is mandatory** | Unit tests with shallow fakes missed real bugs (all passed but features were broken). Integration tests validate state machines directly without widget tree overhead. |
| **BddAppHarness builder pattern** | Each scenario declares its own mock surface. No shared global state eliminates cascade failures from interface changes. |

---
**End of System Design Specification v3.0**
