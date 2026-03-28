# Channel App — Phase 2 Features

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Implement all Phase 2 agent banking services on the existing Flutter POS app: extended funding methods for all 31 financial functions, DuitNow Transfer, Merchant Services (Retail, PIN, Cash-Back), Compliance Unlock webhook, Agent Self-Onboarding, and EOD Settlement UI.

**Architecture:** Each new service extends the existing `transactionProvider` state machine via `serviceCode` routing. Funding method (CARD_EMV vs CASH vs DUITNOW_*) is set by the UI before calling `startTransaction()`. All Phase 2 screens follow the same dual-handshake pattern from MVP. The `complianceLockProvider` handles the LOCKED ↔ UNLOCKED lifecycle exclusively via backend webhook.

**Prerequisite:** MVP Corrections plan (`2026-03-27-channel-app-mvp-corrections.md`) must be fully merged before starting this plan.

**Tech Stack:** Flutter 3.x · Dart · Riverpod StateNotifier · Dio · `decimal: ^2.3.3` · `go_router` · `workmanager`

**BDD Reference:** `docs/superpowers/specs/agent-banking-channel/2026-03-27-agent-banking-channel-bdd.md` — Features 7, 9, 10, 11, 12  
**BRD Reference:** `docs/superpowers/specs/agent-banking-channel/2026-03-27-agent-banking-channel-brd.md` — US-CA-05, US-CA-07 to US-CA-11, US-CA-16 to US-CA-22, US-CA-24 to US-CA-44  
**Design Reference:** `docs/superpowers/specs/agent-banking-channel/2026-03-27-agent-banking-channel-design.md`

---

## File Structure

### Files to Create

| File | Responsibility |
|------|---------------|
| `lib/features/transactions/screens/duitnow_transfer_screen.dart` | DuitNow proxy entry + polling UI (US-CA-05) |
| `lib/features/transactions/screens/bill_payment_card_screen.dart` | Card-funded bill payment (US-CA-26, 28, 30, 32, 34) |
| `lib/features/transactions/screens/topup_card_screen.dart` | Card-funded prepaid top-up (US-CA-35, 37) |
| `lib/features/transactions/screens/sarawak_pay_screen.dart` | Sarawak Pay withdrawal/topup (US-CA-38–US-CA-41) |
| `lib/features/transactions/screens/essp_screen.dart` | eSSP purchase Cash + Card (US-CA-42, 43) |
| `lib/features/transactions/screens/mykad_withdrawal_screen.dart` | MyKad biometric withdrawal (US-CA-24) |
| `lib/features/transactions/screens/card_deposit_screen.dart` | Card-funded cash deposit (US-CA-25) |
| `lib/features/merchant/providers/merchant_provider.dart` | Merchant state machine (RETAIL_SALE, PIN_PURCHASE, CASHBACK) |
| `lib/features/merchant/screens/retail_sale_screen.dart` | Retail Sale UI (US-CA-17) |
| `lib/features/merchant/screens/pin_purchase_card_screen.dart` | PIN Purchase Card UI (US-CA-44) |
| `lib/features/merchant/screens/cashback_screen.dart` | Cash-Back Hybrid UI (US-CA-19) |
| `lib/features/merchant/models/merchant_models.dart` | MDR, merchantType, split accounting models |
| `lib/features/agent_onboarding/screens/agent_onboarding_screen.dart` | Micro-Agent STP self-onboarding (US-CA-20) |
| `lib/features/agent_onboarding/providers/agent_onboarding_provider.dart` | Onboarding state machine |
| `lib/core/compliance/compliance_unlock_listener.dart` | Webhook listener for compliance unlock (US-CA-21) |
| `lib/core/settlement/eod_ui_provider.dart` | EOD warning + lockout state (US-CA-22) |

### Files to Modify

| File | Change |
|------|--------|
| `lib/core/compliance/compliance_service.dart` | Add webhook-based unlock path; remove manual unlock |
| `lib/features/transactions/providers/transaction_provider.dart` | Add `PROCESSING_DUITNOW` + polling states; add `billerRouting` to metadata; add MyKad biometric flow |
| `lib/features/transactions/models/transaction_models.dart` | Already updated in MVP plan — ensure `BillerRouting`, full `FundingSource` present |
| `lib/main.dart` | Register `eodUiProvider` listener; add `go_router` route for `ComplianceLockScreen` as dead-end |

### Test Files

| File | Scenarios |
|------|-----------|
| `test/features/transactions/duitnow_test.dart` | BDD Feature 4 S4.4–4.6 |
| `test/features/transactions/extended_services_test.dart` | BDD Feature 12 (all S12.*) |
| `test/features/merchant/merchant_provider_test.dart` | BDD Feature 9 S9.1–9.4 |
| `test/core/compliance/compliance_unlock_test.dart` | BDD Feature 7 S7.3 |
| `test/core/settlement/eod_ui_test.dart` | BDD Feature 11 S11.1–11.3 |
| `test/features/agent_onboarding/agent_onboarding_test.dart` | BDD Feature 10 S10.1–10.2 |

---

## Task 1: DuitNow Transfer — 3-Proxy Support & Status Polling [IN_PROGRESS]

**BDD Scenarios:** BDD Feature 4 S4.4 (Mobile Number proxy), S4.5 (MyKad proxy), S4.6 (BRN proxy)  
**BRD Requirements:** BRD US-CA-05; FR-CA-3.3; FR-CA-3.4  
**User-Facing:** YES

**Files:**
- Modify: `lib/features/transactions/providers/transaction_provider.dart`
- Create: `lib/features/transactions/screens/duitnow_transfer_screen.dart`
- Test: `test/features/transactions/duitnow_test.dart` (NEW)
- Frontend Test: `test/features/transactions/duitnow_screen_test.dart` (NEW)

- [ ] **Step 1: Write failing provider test**

```dart
// test/features/transactions/duitnow_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';

void main() {
  // BDD Feature 4 S4.4: DuitNow transfer using Mobile Number proxy
  group('DuitNow Transfer Provider', () {
    test('Mobile Number proxy triggers RTP and enters polling state', () async {
      // Given: fundingSource = DUITNOW_MOBILE, proxy = '0123456789'
      // When: confirmConsent called with duitNowProxyId = '0123456789'
      // Then: state transitions to processingDuitNow (polling)
      // BDD: "terminal enters Waiting for Customer Approval polling state"
      expect(state.status, equals(TransactionStatus.processingDuitNow));
    });

    test('BRN proxy correctly sets proxyType=BRN in API request', () async {
      // Given: fundingSource = DUITNOW_BRN
      // Then: API call includes proxyType='BRN'
      // BDD Feature 4 S4.6
      expect(capturedRequest['proxyType'], equals('BRN'));
    });

    test('DuitNow customer approval timeout triggers MTI 0400 reversal', () async {
      // Given: polling times out after 3 minutes (36 attempts x 5s)
      // Then: state = reversalQueued (BDD Feature 8 S8.1 pattern)
      expect(state.status, equals(TransactionStatus.reversalQueued));
    });
  });
}
```

- [ ] **Step 2: Run tests to confirm they fail**

```bash
flutter test test/features/transactions/duitnow_test.dart -v
```

- [ ] **Step 3: Update `transaction_provider.dart` — fix DuitNow state machine**

Add `processingDuitNow` to `TransactionStatus`. Fix `_handleDuitNowTransaction()`:

```dart
// Map fundingSource to DuitNow proxy type
String _proxyTypeFromFundingSource(FundingSource fs) => switch (fs) {
  FundingSource.DUITNOW_MOBILE => 'MOBILE',
  FundingSource.DUITNOW_MYKAD => 'NRIC',
  FundingSource.DUITNOW_BRN   => 'BRN',
  _ => throw ArgumentError('Not a DuitNow funding source: $fs'),
};

Future<void> _handleDuitNowTransaction(String? proxyId) async {
  if (proxyId == null) {
    state = state.copyWith(status: TransactionStatus.failed, error: 'Proxy ID required');
    return;
  }
  state = state.copyWith(status: TransactionStatus.processing);
  try {
    final initResult = await repository.initiateDuitNow(
      quoteId: state.quote!.quoteId,
      proxyId: proxyId,
      proxyType: _proxyTypeFromFundingSource(state.fundingSource!),
    );
    state = state.copyWith(status: TransactionStatus.processingDuitNow);
    await _pollDuitNowStatus(initResult.referenceId);
  } catch (e) {
    await _queueReversal(/* build reversal from quote */);
  }
}

Future<void> _pollDuitNowStatus(String referenceId) async {
  // BDD Feature 4 S4.4: poll every 5s for max 3 minutes (36 attempts)
  for (int i = 0; i < 36; i++) {
    await Future.delayed(const Duration(seconds: 5));
    final status = await repository.getDuitNowStatus(referenceId);
    if (status == 'COMPLETED') {
      state = state.copyWith(status: TransactionStatus.success);
      return;
    } else if (status == 'DECLINED') {
      state = state.copyWith(status: TransactionStatus.failed, error: 'Customer declined');
      return;
    }
  }
  // Timeout after 3 min — treat as unknown, queue reversal
  await _queueReversal(/* build reversal */);
}
```

- [ ] **Step 4: Write failing widget test**

```dart
// test/features/transactions/duitnow_screen_test.dart
// BDD Feature 4 S4.4: "terminal enters 'Waiting for Customer Approval' polling state"
testWidgets('DuitNow screen shows polling indicator when in processingDuitNow state', (tester) async {
  // Given: transactionProvider in processingDuitNow state
  // Then: screen shows "Waiting for customer approval..." with spinner
  expect(find.text('Waiting for customer approval on their phone...'), findsOneWidget);
  expect(find.byType(CircularProgressIndicator), findsOneWidget);
});
```

- [ ] **Step 5: Create `duitnow_transfer_screen.dart`**

Screen shows:
- Agent side: proxy type selector (Mobile / MyKad / BRN) + input field
- `processingDuitNow` state: full-screen "Waiting for customer approval on their phone…" with spinner + timeout countdown
- On success: receipt display

- [ ] **Step 6: Run all DuitNow tests**

```bash
flutter test test/features/transactions/duitnow_test.dart test/features/transactions/duitnow_screen_test.dart -v
```

Expected: PASS

- [ ] **Step 7: Commit**

```bash
git add lib/features/transactions/ test/features/transactions/duitnow*
git commit -m "feat: DuitNow 3-proxy transfer with status polling + reversal on timeout (BRD US-CA-05, FR-CA-3.3/3.4)"
```

---

## Task 2: Extended Financial Services — Card-Funded Bill Payments, Top-Up, Sarawak Pay, eSSP, MyKad Withdrawal

**BDD Scenarios:** BDD Feature 12 — all scenarios US-CA-24 to US-CA-43  
**BRD Requirements:** BRD FR-CA-4.7 (Card-Funded Flow); FR-CA-4.8 (Cash-Funded Flow); FR-CA-4.9 (JomPAY ON-US)  
**User-Facing:** YES

**Design principle:** All card-funded services share the same dual-handshake pattern (Ref-1 or phone validation → THEN card insert → PIN). This is enforced by calling `startTransaction(serviceCode=..., fundingSource=CARD_EMV)` and the existing card/PIN state machine handles the rest. The only service-specific variation is the `serviceCode` and any required `metadata` fields (e.g., `billerCode`, `billerRouting`, `telco`, `proxyId`).

**Files:**
- Create: `lib/features/transactions/screens/bill_payment_card_screen.dart`
- Create: `lib/features/transactions/screens/topup_card_screen.dart`
- Create: `lib/features/transactions/screens/sarawak_pay_screen.dart`
- Create: `lib/features/transactions/screens/essp_screen.dart`
- Create: `lib/features/transactions/screens/mykad_withdrawal_screen.dart`
- Create: `lib/features/transactions/screens/card_deposit_screen.dart`
- Test: `test/features/transactions/extended_services_test.dart` (NEW)

- [ ] **Step 1: Write failing provider test for JomPAY ON-US routing — BDD Feature 12**

```dart
// test/features/transactions/extended_services_test.dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  // BDD Feature 12 — JomPAY ON-US routing (US-CA-27, FR-CA-4.9)
  group('JomPAY ON-US routing', () {
    test('billerRouting=ON_US sends to internal endpoint, not PayNet switch', () async {
      // Given: biller inquiry returns billerRouting=ON_US
      // When: agent submits cash payment
      // Then: request goes to /api/v1/bill/pay with billerRouting=ON_US
      // And: NOT routed through /api/v1/switch/authorize
      expect(capturedRequest['billerRouting'], equals('ON_US'));
      expect(capturedRequest['useSwitch'], isFalse);
    });
  });

  // BDD Feature 12 — Card-Funded Generic Validation (FR-CA-4.7)
  group('Card-funded service ordering', () {
    test('PIN pad is activated ONLY after service validation passes', () async {
      // Given: bill payment with fundingSource=CARD_EMV
      // When: startTransaction called
      // Then: state goes quoting → waitingConsent → VALIDATION_CHECK (Ref-1) → waitingCard → waitingPin
      expect(states, containsAllInOrder([
        TransactionStatus.quoting,
        TransactionStatus.waitingConsent,
        TransactionStatus.validatingService,  // NEW intermediate state
        TransactionStatus.waitingCard,
        TransactionStatus.waitingPin,
      ]));
    });
  });

  // BDD Feature 12 — Cash > RM 3,000 MyKad scan (FR-CA-4.8)
  group('Cash-funded service — AML scan for large amounts', () {
    test('cash collection > RM 3,000 interrupts to require MyKad scan', () async {
      // Given: bill payment cash, amount = RM 3,500
      // When: agent clicks "Confirm Cash Collected"
      // Then: state = waitingMyKadScan before firing API
      // BDD Feature 12 last scenario: "app interrupts and requires a MyKad scan"
      expect(state.status, equals(TransactionStatus.waitingMyKadScan));
    });
  });
}
```

- [ ] **Step 2: Run tests to confirm they fail**

```bash
flutter test test/features/transactions/extended_services_test.dart -v
```

- [ ] **Step 3: Add `validatingService` and `waitingMyKadScan` to `TransactionStatus` enum**

```dart
enum TransactionStatus {
  idle,
  quoting,
  waitingConsent,
  validatingService,   // NEW: Ref-1/phone check before card
  waitingCard,
  waitingPin,
  waitingMyKadScan,    // NEW: large cash AML check
  processing,
  processingDuitNow,
  success,
  failed,
  reversalQueued,
}
```

- [ ] **Step 4: Update `_handleCashTransaction()` — check amount > RM 3,000**

```dart
Future<void> _handleCashTransaction() async {
  // BRD FR-CA-4.8: MyKad required if cash collected > RM 3,000
  final amount = state.quote!.amount;
  if (amount > Decimal.parse('3000.00')) {
    state = state.copyWith(status: TransactionStatus.waitingMyKadScan);
    final myKadData = await myKadScanner.scanMyKad();
    if (myKadData == null) {
      state = state.copyWith(status: TransactionStatus.failed, error: 'MyKad scan required for AML');
      return;
    }
    // Include MyKad reference in API call
    state = state.copyWith(metadata: {...?state.metadata, 'myKadRef': myKadData.icNumber});
  }
  state = state.copyWith(status: TransactionStatus.processing);
  await _execute(TransactionExecutionRequest(
    quoteId: state.quote!.quoteId,
    fundingSource: FundingSource.CASH,
    idempotencyKey: state.metadata?['idempotencyKey'] ?? '',
    metadata: state.metadata,
  ));
}
```

- [ ] **Step 5: Create shared `BillPaymentBaseScreen` widget (used by all bill services)**

```dart
// lib/features/transactions/screens/bill_payment_card_screen.dart
// Shared widget with: biller code selector, Ref-1 input, validation pre-check,
// funding source toggle (Cash / Card), amount input.
// On Submit: calls startTransaction(serviceCode='BILL_PAYMENT', metadata={billerCode, billerRouting, ref1})
```

- [ ] **Step 6: Create remaining service screens (thin wrappers over BillPaymentBaseScreen)**

Each screen simply pre-fills the `billerCode` and `serviceCode` and passes the funding source:

| Screen | billerCode | serviceCode |
|--------|-----------|-------------|
| `bill_payment_card_screen.dart` | Selected at runtime | `BILL_PAYMENT` |
| `topup_card_screen.dart` | CELCOM / M1 | `TOPUP` |
| `sarawak_pay_screen.dart` | SARAWAK_PAY | `EWALLET_TOPUP` / `EWALLET_WITHDRAW` |
| `essp_screen.dart` | ESSP | `ESSP_PURCHASE` |
| `mykad_withdrawal_screen.dart` | — | `CASH_WITHDRAWAL` + `MYKAD_BIOMETRIC` funding |
| `card_deposit_screen.dart` | — | `CASH_DEPOSIT` + `CARD_EMV` funding |

- [ ] **Step 7: Run all extended services tests and widget tests**

```bash
flutter test test/features/transactions/extended_services_test.dart -v
```

Expected: PASS

- [ ] **Step 8: Commit**

```bash
git add lib/features/transactions/screens/ test/features/transactions/extended_services_test.dart
git commit -m "feat: extended financial services — all 31 functions × funding methods (BRD US-CA-24 to US-CA-43, FR-CA-4.7/4.8/4.9)"
```

---

## Task 3: Merchant Services — Retail Sale, Cash-Back Hybrid, PIN Purchase (Card)

**BDD Scenarios:** BDD Feature 9 S9.1–9.4; BDD Feature 12 — US-CA-44 PIN Purchase Card  
**BRD Requirements:** BRD US-CA-17, US-CA-18, US-CA-19, US-CA-44; FR-CA-9.1–9.5  
**User-Facing:** YES

**Files:**
- Create: `lib/features/merchant/models/merchant_models.dart`
- Create: `lib/features/merchant/providers/merchant_provider.dart`
- Create: `lib/features/merchant/screens/retail_sale_screen.dart`
- Create: `lib/features/merchant/screens/cashback_screen.dart`
- Create: `lib/features/merchant/screens/pin_purchase_card_screen.dart`
- Test: `test/features/merchant/merchant_provider_test.dart` (NEW)

- [ ] **Step 1: Write failing merchant provider tests**

```dart
// test/features/merchant/merchant_provider_test.dart
void main() {
  // BDD Feature 9 S9.1: Retail Sale — card payment, float credited minus MDR
  group('MerchantProvider', () {
    test('retail sale credits float with amount minus MDR (BDD S9.1)', () async {
      // Given: sale amount = RM 100, MDR rate = 1%
      // When: retail sale completes
      // Then: floatCreditAmount = RM 99.00
      // And: mdrAmount = RM 1.00
      // Float is NOT adjusted locally — response from backend is authoritative
      expect(result.floatCreditAmount, equals(Decimal.parse('99.00')));
      expect(result.mdrAmount, equals(Decimal.parse('1.00')));
    });

    test('cash-back hybrid: backend splits RM 20 purchase + RM 50 cashback (BDD S9.4)', () async {
      // Given: purchaseAmount=20, cashBackAmount=50, total swipe=70
      // When: cashback transaction completes
      // Then: response contains purchaseAmount=20, cashBackAmount=50
      expect(result.purchaseAmount, equals(Decimal.parse('20.00')));
      expect(result.cashBackAmount, equals(Decimal.parse('50.00')));
    });

    test('PIN purchase card: agent float decreases, 16-digit PIN printed (BDD Feature 12, US-CA-44)', () async {
      // Given: voucher = DIGI RM 10, fundingSource = CARD_EMV
      // Then: pinCode is 16 digits in response
      // And: receipt issued
      expect(result.pinCode, matches(RegExp(r'^\d{16}$')));
    });
  });
}
```

- [ ] **Step 2: Run test to confirm fails**

```bash
flutter test test/features/merchant/merchant_provider_test.dart -v
```

- [ ] **Step 3: Create `merchant_models.dart`**

```dart
// lib/features/merchant/models/merchant_models.dart
import 'package:decimal/decimal.dart';

enum MerchantTransactionType { RETAIL_SALE, PIN_PURCHASE, CASHBACK_HYBRID }

class RetailSaleRequest {
  final Decimal amount;
  final String fundingSource; // CARD_EMV or DUITNOW_QR
  final String? pinBlock;
  final String? cardToken;
  final String? qrPayload;
  final String idempotencyKey;
  RetailSaleRequest({required this.amount, required this.fundingSource,
    this.pinBlock, this.cardToken, this.qrPayload, required this.idempotencyKey});
}

class RetailSaleResponse {
  final Decimal floatCreditAmount; // amount minus MDR
  final Decimal mdrAmount;
  final String receiptReference;
  RetailSaleResponse({required this.floatCreditAmount, required this.mdrAmount, required this.receiptReference});
  factory RetailSaleResponse.fromJson(Map<String, dynamic> j) => RetailSaleResponse(
    floatCreditAmount: Decimal.parse(j['floatCreditAmount'].toString()),
    mdrAmount: Decimal.parse(j['mdrAmount'].toString()),
    receiptReference: j['receiptReference'],
  );
}

class CashbackResponse {
  final Decimal purchaseAmount;
  final Decimal cashBackAmount;
  final String receiptReference;
  CashbackResponse({required this.purchaseAmount, required this.cashBackAmount, required this.receiptReference});
  factory CashbackResponse.fromJson(Map<String, dynamic> j) => CashbackResponse(
    purchaseAmount: Decimal.parse(j['purchaseAmount'].toString()),
    cashBackAmount: Decimal.parse(j['cashBackAmount'].toString()),
    receiptReference: j['receiptReference'],
  );
}

class PinPurchaseResponse {
  final String pinCode; // 16-digit
  final Decimal commissionEarned;
  final String receiptReference;
  PinPurchaseResponse({required this.pinCode, required this.commissionEarned, required this.receiptReference});
  factory PinPurchaseResponse.fromJson(Map<String, dynamic> j) => PinPurchaseResponse(
    pinCode: j['pinCode'],
    commissionEarned: Decimal.parse(j['commissionEarned'].toString()),
    receiptReference: j['receiptReference'],
  );
}
```

- [ ] **Step 4: Create `merchant_provider.dart` with its own state notifier**

```dart
// lib/features/merchant/providers/merchant_provider.dart
// MerchantState: idle → quoting (MDR display) → waitingCard → waitingPin → processing → success/failed/reversalQueued
// For DuitNow QR: idle → displayingQr → processing → success
// For Cash-Back: idle → quoting → waitingCard → waitingPin → processing → success (shows split)
```

- [ ] **Step 5: Create merchant screens**

`retail_sale_screen.dart` — amount input, MDR preview, card/QR funding toggle, receipt display  
`cashback_screen.dart` — purchase amount + cash-back amount inputs, single card swipe, split receipt  
`pin_purchase_card_screen.dart` — voucher selector, card funding flow, 16-digit PIN print

- [ ] **Step 6: Run merchant tests**

```bash
flutter test test/features/merchant/ -v
```

Expected: PASS

- [ ] **Step 7: Commit**

```bash
git add lib/features/merchant/ test/features/merchant/
git commit -m "feat: merchant services — Retail Sale, Cash-Back Hybrid, PIN Purchase (Card) (BRD US-CA-17/19/44, FR-CA-9.x)"
```

---

## Task 4: Compliance Unlock Webhook (US-CA-21)

**BDD Scenarios:** BDD Feature 7 S7.3 — "Compliance unlock webhook restores STP operations"  
**BRD Requirements:** BRD US-CA-21; FR-CA-6.4  
**User-Facing:** YES (silent — no user action needed)

**Files:**
- Modify: `lib/core/compliance/compliance_service.dart`
- Create: `lib/core/compliance/compliance_unlock_listener.dart`
- Test: `test/core/compliance/compliance_unlock_test.dart` (NEW)

- [ ] **Step 1: Write failing test**

```dart
// test/core/compliance/compliance_unlock_test.dart
void main() {
  // BDD Feature 7 S7.3
  group('ComplianceUnlock', () {
    test('webhook sets isComplianceLocked=false without app restart', () async {
      // Given: terminal is in LOCKED state (isComplianceLocked=true in secure storage)
      // When: compliance_unlock_listener receives backend unlock event
      // Then: isComplianceLocked cleared from encrypted storage
      // And: go_router allows navigation (not dead-ended on ComplianceLockScreen)
      // BDD: "no manual app restart is required"
      expect(complianceState.isLocked, isFalse);
      expect(routerCanNavigate, isTrue);
    });

    test('LOCKED state persists across cold restart (BDD S7.2)', () async {
      // Given: LOCKED written to secure storage
      // When: ComplianceService initialized fresh (simulating restart)
      // Then: isLocked = true immediately on init
      expect(complianceState.isLocked, isTrue);
    });
  });
}
```

- [ ] **Step 2: Run test to confirm fails**

```bash
flutter test test/core/compliance/compliance_unlock_test.dart -v
```

- [ ] **Step 3: Update `compliance_service.dart`**

```dart
// In ComplianceNotifier:
Future<void> unlock() async {
  // BRD FR-CA-6.4 — called only by backend webhook, not by user action
  await _secureStorage.delete(key: 'compliance_locked');
  state = state.copyWith(isLocked: false);
  // go_router redirect guard will re-evaluate on app's next navigation
}
```

- [ ] **Step 4: Create `compliance_unlock_listener.dart`**

This is a background listener (WebSocket or FCM / long-poll) that calls `complianceService.unlock()` when it receives a compliance unlock payload. In MVP phase, implement as a periodic GET poll to `/api/v1/compliance/status` every 5 minutes:

```dart
// lib/core/compliance/compliance_unlock_listener.dart
class ComplianceUnlockListener {
  final ComplianceNotifier compliance;
  final TransactionRepository repository;

  ComplianceUnlockListener({required this.compliance, required this.repository});

  Future<void> startPolling() async {
    while (true) {
      await Future.delayed(const Duration(minutes: 5));
      if (!compliance.state.isLocked) break;
      final status = await repository.getComplianceStatus();
      if (status == 'UNLOCKED') {
        await compliance.unlock();
        break;
      }
    }
  }
}
```

- [ ] **Step 5: Run tests**

```bash
flutter test test/core/compliance/ -v
```

Expected: PASS

- [ ] **Step 6: Commit**

```bash
git add lib/core/compliance/ test/core/compliance/
git commit -m "feat: compliance unlock via backend webhook — no app restart required (BRD US-CA-21, FR-CA-6.4)"
```

---

## Task 5: EOD Settlement UI (US-CA-22)

**BDD Scenarios:** BDD Feature 11 S11.1 (23:55 banner), S11.2 (23:59:59 lockout), S11.3 (settlement done re-enables)  
**BRD Requirements:** BRD US-CA-22; FR-CA-8.2–8.4  
**User-Facing:** YES

**Files:**
- Modify: `lib/core/settlement/settlement_service.dart`
- Create: `lib/core/settlement/eod_ui_provider.dart`
- Modify: `lib/core/settlement/widgets/settlement_barrier.dart`
- Test: `test/core/settlement/eod_ui_test.dart` (NEW)

- [ ] **Step 1: Write failing tests**

```dart
// test/core/settlement/eod_ui_test.dart
void main() {
  // BDD Feature 11 S11.1 — 23:55 warning banner
  test('at 23:55 MYT, warning banner appears without disabling transactions', () {
    final state = eodProvider.stateAt(hour: 23, minute: 55, second: 0);
    expect(state.showWarningBanner, isTrue);
    expect(state.isTransactionsDisabled, isFalse);
  });

  // BDD Feature 11 S11.2 — 23:59:59 lockout
  test('at 23:59:59 MYT, all STP workflows disabled', () {
    final state = eodProvider.stateAt(hour: 23, minute: 59, second: 59);
    expect(state.isTransactionsDisabled, isTrue);
  });

  // BDD Feature 11 S11.3 — settlement complete re-enables
  test('backend settlement signal re-enables all STP workflows', () async {
    final notifier = EodUiNotifier();
    notifier.onSettlementComplete();
    expect(notifier.state.isTransactionsDisabled, isFalse);
    expect(notifier.state.showSettlementComplete, isTrue);
  });
}
```

- [ ] **Step 2: Run tests to confirm fail**

```bash
flutter test test/core/settlement/eod_ui_test.dart -v
```

- [ ] **Step 3: Create `eod_ui_provider.dart`**

```dart
// lib/core/settlement/eod_ui_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EodUiState {
  final bool showWarningBanner;    // 23:55 MYT
  final bool isTransactionsDisabled; // 23:59:59 MYT
  final bool showSettlementComplete; // after backend signal
  EodUiState({this.showWarningBanner=false, this.isTransactionsDisabled=false, this.showSettlementComplete=false});
  EodUiState copyWith({bool? showWarningBanner, bool? isTransactionsDisabled, bool? showSettlementComplete}) =>
    EodUiState(
      showWarningBanner: showWarningBanner ?? this.showWarningBanner,
      isTransactionsDisabled: isTransactionsDisabled ?? this.isTransactionsDisabled,
      showSettlementComplete: showSettlementComplete ?? this.showSettlementComplete,
    );
}

class EodUiNotifier extends StateNotifier<EodUiState> {
  EodUiNotifier() : super(EodUiState()) {
    _startClock();
  }

  void _startClock() {
    // Check every 30 seconds — update state based on current MYT time
    Stream.periodic(const Duration(seconds: 30)).listen((_) => _evaluate());
  }

  void _evaluate() {
    final now = DateTime.now().toUtc().add(const Duration(hours: 8)); // MYT = UTC+8
    if (now.hour == 23 && now.minute >= 55 && now.second < 59) {
      state = state.copyWith(showWarningBanner: true, isTransactionsDisabled: false);
    } else if (now.hour == 23 && now.minute == 59 && now.second >= 59) {
      state = state.copyWith(showWarningBanner: false, isTransactionsDisabled: true);
    }
  }

  /// Called by settlement polling service when backend signals finalization
  void onSettlementComplete() {
    state = state.copyWith(isTransactionsDisabled: false, showSettlementComplete: true, showWarningBanner: false);
  }

  // Testability hook
  EodUiState stateAt({required int hour, required int minute, required int second}) {
    final fakeNow = DateTime(2026, 3, 27, hour, minute, second);
    if (fakeNow.hour == 23 && fakeNow.minute >= 55 && fakeNow.second < 59) {
      return EodUiState(showWarningBanner: true);
    } else if (fakeNow.hour == 23 && fakeNow.minute == 59 && fakeNow.second >= 59) {
      return EodUiState(isTransactionsDisabled: true);
    }
    return EodUiState();
  }
}

final eodUiProvider = StateNotifierProvider<EodUiNotifier, EodUiState>((_) => EodUiNotifier());
```

- [ ] **Step 4: Update `settlement_barrier.dart` to consume `eodUiProvider`**

```dart
// When isTransactionsDisabled=true, renders an overlay preventing all transaction navigation
// When showWarningBanner=true, renders a dismissible banner at top of dashboard
// When showSettlementComplete=true, brief celebration/notification banner
```

- [ ] **Step 5: Run tests**

```bash
flutter test test/core/settlement/eod_ui_test.dart -v
```

Expected: PASS

- [ ] **Step 6: Commit**

```bash
git add lib/core/settlement/ test/core/settlement/
git commit -m "feat: EOD settlement UI — 23:55 warning + 23:59:59 lockout + settlement complete re-enable (BRD US-CA-22)"
```

---

## Task 6: Agent Self-Onboarding — Micro-Agent STP (US-CA-20)

**BDD Scenarios:** BDD Feature 10 S10.1 (all checks pass = instant activation), S10.2 (AML flag = manual review)  
**BRD Requirements:** BRD US-CA-20; FR-CA-10.1–10.4  
**User-Facing:** YES

**Files:**
- Create: `lib/features/agent_onboarding/providers/agent_onboarding_provider.dart`
- Create: `lib/features/agent_onboarding/screens/agent_onboarding_screen.dart`
- Test: `test/features/agent_onboarding/agent_onboarding_test.dart` (NEW)

- [ ] **Step 1: Write failing tests**

```dart
// test/features/agent_onboarding/agent_onboarding_test.dart
void main() {
  // BDD Feature 10 S10.1 — all checks pass
  group('AgentOnboardingProvider', () {
    test('all checks pass → status AUTO_APPROVED → agent ID activated (S10.1)', () async {
      // Given: myKad OCR OK, liveness OK, SSM number valid
      // When: POST /api/v1/kyc/agent-onboard returns {status: AUTO_APPROVED}
      // Then: onboardingState = activated
      // BDD: "Agent ID Activated. Float account created."
      expect(state.status, equals(AgentOnboardingStatus.activated));
    });

    test('AML flag → MANUAL_REVIEW → show queued message (S10.2)', () async {
      // Given: AML check returns flag
      // When: POST /api/v1/kyc/agent-onboard returns {status: MANUAL_REVIEW}
      // Then: onboardingState = manualReview
      expect(state.status, equals(AgentOnboardingStatus.manualReview));
    });
  });
}
```

- [ ] **Step 2: Run tests to confirm fail**

```bash
flutter test test/features/agent_onboarding/ -v
```

- [ ] **Step 3: Create `agent_onboarding_provider.dart`**

```dart
// lib/features/agent_onboarding/providers/agent_onboarding_provider.dart
enum AgentOnboardingStatus { idle, scanning, submitting, activated, manualReview, failed }

class AgentOnboardingState {
  final AgentOnboardingStatus status;
  final String? errorMessage;
  const AgentOnboardingState({this.status = AgentOnboardingStatus.idle, this.errorMessage});
}

class AgentOnboardingNotifier extends StateNotifier<AgentOnboardingState> {
  final KycRepository kycRepository;
  AgentOnboardingNotifier({required this.kycRepository}) : super(const AgentOnboardingState());

  Future<void> startOnboarding({required String myKadData, required String livenessBlob, required String ssmNumber}) async {
    state = const AgentOnboardingState(status: AgentOnboardingStatus.submitting);
    final result = await kycRepository.agentOnboard(myKadData: myKadData, livenessBlob: livenessBlob, ssmNumber: ssmNumber);
    if (result.status == 'AUTO_APPROVED') {
      state = const AgentOnboardingState(status: AgentOnboardingStatus.activated);
    } else {
      state = const AgentOnboardingState(status: AgentOnboardingStatus.manualReview);
    }
  }
}
```

- [ ] **Step 4: Create `agent_onboarding_screen.dart`**

Screen flow: MyKad chip read → liveness video → SSM number entry → submit → result (activated vs manual review).

- [ ] **Step 5: Run tests**

```bash
flutter test test/features/agent_onboarding/ -v
```

Expected: PASS

- [ ] **Step 6: Commit**

```bash
git add lib/features/agent_onboarding/ test/features/agent_onboarding/
git commit -m "feat: Micro-Agent STP self-onboarding with instant activation + AML manual review (BRD US-CA-20, FR-CA-10.x)"
```

---

## Task 7: Full Phase 2 Test Suite + go_router Compliance Lock Guard

**BDD Scenarios:** BDD Feature 7 S7.1, S7.2 (LOCKED dead-end route)  
**BRD Requirements:** BRD FR-CA-6.1–6.3; Design §2.2 `complianceLockProvider`  
**User-Facing:** NO (routing config)

**Files:**
- Modify: `lib/main.dart`

- [ ] **Step 1: Add go_router redirect guard for compliance LOCKED state**

```dart
// In main.dart GoRouter setup:
redirect: (context, state) {
  final complianceLocked = ref.read(complianceProvider).isLocked;
  if (complianceLocked && state.fullPath != '/compliance-lock') {
    return '/compliance-lock'; // Dead-end route
  }
  if (!complianceLocked && state.fullPath == '/compliance-lock') {
    return '/dashboard'; // Unlock redirects home
  }
  return null;
},
```

- [ ] **Step 2: Run full test suite**

```bash
flutter test --coverage -v
```

Expected: All tests PASS. Report coverage ≥ 70% for new providers.

- [ ] **Step 3: Final integration test**

```bash
flutter test integration/ -v
```

- [ ] **Step 4: Final commit**

```bash
git add lib/main.dart
git commit -m "feat: go_router compliance lock dead-end guard; Phase 2 complete (BRD FR-CA-6.1–6.4)"
git tag phase2-complete
```

---

## Summary: Phase 2 User Stories Delivered

| User Story | Feature | Task |
|-----------|---------|------|
| US-CA-05 | DuitNow 3-proxy + polling | Task 1 |
| US-CA-07, 26–28 | JomPAY OFF-US/ON-US Cash+Card | Task 2 |
| US-CA-08, 29–34 | Bill Payments Cash+Card (ASTRO, TM, EPF) | Task 2 |
| US-CA-08, 35–37 | Prepaid Top-Up Cash+Card | Task 2 |
| US-CA-09, 38–41 | Sarawak Pay e-Wallet | Task 2 |
| US-CA-10, 42–43 | eSSP Cash+Card | Task 2 |
| US-CA-24 | MyKad Biometric Withdrawal | Task 2 |
| US-CA-25 | Card-funded Cash Deposit | Task 2 |
| US-CA-17, 18, 19 | Merchant Services | Task 3 |
| US-CA-44 | PIN Purchase Card | Task 3 |
| US-CA-21 | Compliance Unlock Webhook | Task 4 |
| US-CA-22 | EOD Settlement UI | Task 5 |
| US-CA-20 | Agent Self-Onboarding | Task 6 |
| US-CA-16 | Compliance LOCKED dead-end route | Task 7 |
