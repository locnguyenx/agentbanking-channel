# System Design Specification: Agent Banking Channel App

**Version:** 2.0  
**Date:** 2026-03-27  
**Module:** Channel App (Flutter POS/Mobile)  
**Supersedes:** `2026-03-25-agent-banking-channel-design.md`  
**BRD Reference:** `docs/superpowers/specs/agent-banking-channel/2026-03-27-agent-banking-channel-brd.md`  
**Platform Design Reference:** `docs/superpowers/specs/agent-banking-platform/2026-03-25-agent-banking-platform-design.md`  
**Arch Supplementary:** `docs/ideas/ARCH-supplementary/Detailed Service Processing.md`, `docs/ideas/ARCH-supplementary/Microservices Domain Map.md`

---

## 1. Architectural Overview

### 1.1 The Channel App's Role in the 5-Tier Platform

The Channel App lives exclusively in **Tier 1: Channel Layer**. It communicates only with the **Tier 2: Spring Cloud Gateway** and NEVER directly with any Tier 3/4/5 services.

```
┌─────────────────────────────────────────────────────┐
│  Tier 1: Channel App (Flutter/Android POS)          │
│  - Drives UI (Dual-Display: Agent + Customer views) │
│  - Enforces geofence, pre-checks, and state machine │
│  - Sends X-GPS, X-Idempotency-Key on every request  │
└──────────────────────┬──────────────────────────────┘
                       │ HTTPS REST (Bearer JWT)
┌──────────────────────▼──────────────────────────────┐
│  Tier 2: Spring Cloud Gateway (backend platform)     │
│  - JWT validation, rate limiting, routing            │
│  - Returns clean business errors (ERR_BIZ_xxx etc.) │
└─────────────────────────────────────────────────────┘
```

**The app is a consumer.** It never implements business rules that belong to the backend (float balances, fee calculation, velocity checks, AML). Those are backend responsibilities accessed via API calls.

### 1.2 Backend Transaction Saga (What the App Observes)

Understanding the platform's internal Saga pattern is critical for the app's state machine design. From the app's perspective, a financial transaction follows this backend sequence:

```
App sends POST /api/v1/withdrawal
          │
          ▼ (Platform Tier 3 → Tier 2 internally)
  BlockFloat (Pessimistic Lock on agent float)
          │
          ▼
  Switch Authorize (ISO 8583 → PayNet, 25s timeout)
          │
     ┌────┴─────┐
   PASS       FAIL / TIMEOUT
     │              │
   Commit        Rollback → MTI 0400 Reversal
     │
  HTTP 200 OK  →  App shows SUCCESS
```

**Implications for the app:**
1. While awaiting HTTP response: show persistent loading (the backend has funds locked)
2. On HTTP 200 OK: commit success — print receipt
3. On HTTP 4xx/5xx timeout: assume **unknown state** — immediately queue MTI 0400 reversal via Store & Forward
4. ZERO retries for financial authorization — one attempt, then reversal

### 1.3 Clean Architecture Layers

```
lib/
├── core/                     # Cross-cutting concerns
│   ├── network/              # Dio client, interceptors, TLS pinning, GPS header injection
│   ├── security/             # Secure storage manager, PII redaction logger
│   ├── errors/               # Error code constants (aligned to ERR_BIZ_xxx / ERR_EXT_xxx)
│   └── constants/            # STP hard caps (RM 3,000/txn, 5 txn/hr), timeout values
├── features/
│   ├── auth/                 # Login, biometric unlock, session timer, JWT lifecycle
│   ├── dashboard/            # Float balance polling (30s), geofence indicator, EOD banner
│   ├── hardware/             # HAL: ICardReader, IPinPad, IPrinter, IBiometricScanner,
│   │                         #      IMerchantTerminal (QR display for DuitNow QR)
│   ├── transactions/         # Withdrawal, Deposit, DuitNow, Balance Inquiry — state machine
│   ├── bills/                # Bill Payments, JomPAY, Prepaid Top-Up
│   ├── ekyc/                 # OCR extractor, Face AI Liveness bridge, KYC state machine
│   ├── merchant/             # Retail Sale, PIN Purchase, Cash-Back Hybrid
│   └── agent_onboarding/     # Micro-Agent self-onboarding STP flow (Phase 2)
└── main.dart                 # Riverpod ProviderScope, App Theme, GoRouter
```

### 1.4 Phased Feature Availability

| Feature Folder | MVP | Phase 2 |
|---------------|-----|---------|
| `auth/` | ✅ | ✅ |
| `dashboard/` (float, geofence) | ✅ | ✅ (+ EOD banner) |
| `hardware/` (HAL core) | ✅ | ✅ (+ IMerchantTerminal) |
| `transactions/` (withdrawal, deposit, balance) | ✅ | ✅ (+ DuitNow) |
| `ekyc/` | ✅ | ✅ |
| `bills/` | ❌ | ✅ |
| `merchant/` | ❌ | ✅ |
| `agent_onboarding/` | ❌ | ✅ |

---

## 2. State Management & Dependency Injection

### 2.1 Framework
**Riverpod** (`hooks_riverpod`) with `StateNotifier` for state machines.

### 2.2 Core Providers

#### `authProvider` — JWT Lifecycle
- States: `UNAUTHENTICATED → AUTHENTICATING → AUTHENTICATED → SESSION_EXPIRED → LOCKED`
- Manages JWT storage in `flutter_secure_storage`
- Background timer checks session expiry every 30 seconds
- On `SESSION_EXPIRED`: shows non-blocking re-auth dialog (does not clear transaction context)
- On `ERR_BIZ_COMPLIANCE_FREEZE` response from any API: flips `isComplianceLocked = true`, sets `awaitingUnlock = false`
- On Compliance Unlock webhook: flips `isComplianceLocked = false` without app restart

#### `floatBalanceProvider` — Agent Float Display
- Polls `GET /api/v1/agent/balance` every **30 seconds**
- Displays: `balance`, `reservedBalance`, `availableBalance`
- Alerts agent when available balance drops below safety buffer (configurable, default RM 100)

#### `geofenceProvider` — GPS Pre-Flight
- Checks GPS distance against registered lat/lng before every transaction workflow
- Returns: `WITHIN_BOUNDS`, `OUTSIDE_BOUNDS`, `GPS_UNAVAILABLE`
- Injects `X-GPS-Latitude` / `X-GPS-Longitude` into all outbound API headers via Dio interceptor

#### `transactionProvider` — Core Transaction State Machine

```
INIT
  │── (Input validation + STP hard cap pre-check)
  ▼
QUOTING   ── POST /api/v1/transactions/quote ──►
  │
  ▼
WAITING_CONSENT   ← Customer taps "Agree" on touch display
  │
  ▼
WAITING_CARD   ← EMV chip inserted (or DuitNow proxy entered)
  │
  ▼
WAITING_PIN   ← Hardware PIN pad activated (card) OR polling backend (DuitNow)
  │
  ▼
PROCESSING   ── POST /api/v1/withdrawal (or equivalent) ──►
  │        (25-second hard timeout ceiling)
  ├── SUCCESS ──► commit UI state, print receipt
  ├── CLEAN_FAILURE (ERR_EXT_SWITCH_DECLINED etc.) ──► show error, unwind
  └── TIMEOUT / UNKNOWN ──► REVERSAL_QUEUED (MTI 0400 → SAF queue)
```

**DuitNow extension states:**
```
PROCESSING_DUITNOW
  │── polling backend for customer approval (every 5s, max 3 min)
  ├── APPROVED ──► SUCCESS
  └── DECLINED / TIMEOUT ──► REVERSAL_QUEUED
```

**Merchant Service states:**
```
MERCHANT_SALE_INIT ──► WAITING_CARD ──► PROCESSING_RETAIL ──► SUCCESS / REVERSAL_QUEUED
PIN_PURCHASE_INIT  ──► WAITING_CASH_CONFIRM ──► PROCESSING_PIN ──► SUCCESS (prints PIN slip)
CASHBACK_INIT      ──► WAITING_CARD ──► PROCESSING_CASHBACK ──► SUCCESS (prints combined receipt)
```

#### `complianceLockProvider` — Compliance State
- States: `UNLOCKED → LOCKED → UNLOCKED`
- `LOCKED` state persists across app reboots via encrypted local storage
- Transition `LOCKED → UNLOCKED` only happens on verified backend unlock webhook
- When `LOCKED`: `go_router` redirects entire navigation stack to `ComplianceLockScreen` (dead-end route, all financial routes inaccessible)

---

## 3. Hardware Abstraction Layer (HAL)

All hardware interactions occur via abstract Dart contracts. The app never calls vendor-specific SDKs directly.

### 3.1 HAL Contracts

| Interface | Responsibility |
|-----------|---------------|
| `ICardReader` | EMV chip read, card data extraction |
| `IPinPad` | Encrypted hardware PIN entry (DUKPT); returns encrypted PIN block only |
| `IPrinter` | Receipt printing; `isAvailable()` check; falls back to SMS-only on unavailability |
| `IBiometricScanner` | Fingerprint Match-on-Card for e-KYC and agent login |
| `IMerchantTerminal` | Dynamic QR code display for DuitNow QR payments (Phase 2) |

### 3.2 HAL Implementation Pattern

```
VendorAPrinterImpl implements IPrinter
  └── communicates over MethodChannel("com.banking.channel/printer")
       └── native Android host executes proprietary vendor .jar/.aar SDK
```

All vendor adapters follow this pattern: `Vendor[Name][Device]Impl implements I[Device]`.

### 3.3 HAL Failure Modes

| Hardware | `isAvailable()` = false | Action |
|----------|------------------------|--------|
| `IPrinter` | No printer detected / paper jam | Auto-fallback to SMS receipt; queue MTI 0400 reversal |
| `IPinPad` | Hardware PIN pad not responding | Block all card-funded transactions; show `ERR_SYS_PIN_PAD_UNAVAILABLE` |
| `ICardReader` | Reader not responding | Block card-funded transactions; offer DuitNow / Cash alternatives |
| `IBiometricScanner` | Scanner unavailable | Fall back to Face AI Liveness (for e-KYC); block agent login biometric, offer OTP |
| `IMerchantTerminal` | QR display not available | Block DuitNow QR merchant mode; offer card or DuitNow Request-to-Pay |

---

## 4. Store & Forward Engine (Offline Queue)

### 4.1 Architecture
- **Engine:** `sqflite` with `sqlcipher` (AES-256 encryption at rest)
- **Encryption Key:** Generated once per device install, stored in **Android Keystore** via `flutter_secure_storage`
- **Queue Table:** `txn_queue`

| Field | Type | Description |
|-------|------|-------------|
| id | INTEGER PK | Local queue ID |
| idempotency_key | TEXT UNIQUE | Original `X-Idempotency-Key` (UUID) |
| payload | TEXT (JSON) | MTI 0400 Reversal request payload |
| queue_type | TEXT | `REVERSAL`, `OFFLINE_LOG` |
| retry_count | INTEGER | Number of transmission attempts |
| created_at | DATETIME | Queue entry timestamp |
| last_attempt_at | DATETIME | Last retry timestamp |

### 4.2 Retry Policy — Aligned to Platform Arch Supplementary

| Request Type | Retry Strategy | Max Retries | On Timeout |
|-------------|----------------|-------------|------------|
| **Financial Authorization** | **ZERO retries** | 0 | Immediately queue MTI 0400 |
| **MTI 0400 Reversal (SAF)** | Every **60 seconds** | Unlimited until HTTP 200 | Continue queuing |
| **Non-financial (Inquiry)** | Exponential backoff: 1s, 2s, 4s | 3 | Show error to agent |

> **Rationale:** Zero retries for financial auth is a hard banking requirement — retrying a timed-out financial request risks double-deduction. The 60-second SAF retry aligns with Platform FR-18.2 and the arch supplementary "Never Give Up" reversal rule.

### 4.3 Background Sync Worker
- **Framework:** `workmanager` background isolate
- **Schedule:** Every **15 minutes** (when app is in background)
- **On foreground:** Real-time retry every **60 seconds** while app is active and network is available
- **Logic:** Picks all items from `txn_queue` where `queue_type = REVERSAL`, sends to backend, removes on HTTP 200

---

## 5. Security Architecture

### 5.1 Protection Layers

| Layer | Mechanism |
|-------|-----------|
| **Transport** | TLS 1.2+ mandatory; SHA-256 certificate hash pinned in `dio` client |
| **Authentication** | Bearer JWT (8h / 2h inactivity); re-auth dialog preserves transaction context |
| **Display** | `WindowManager.LayoutParams.FLAG_SECURE` — blocks OS-level screenshots/recordings |
| **PIN Processing** | NEVER uses virtual keyboard; 100% delegated to `IPinPad` HAL (DUKPT encrypted PIN block) |
| **PAN Masking** | All card numbers displayed as `411111******1111` (first 6, last 4) |
| **MyKad Masking** | MyKad numbers never logged or displayed in plaintext anywhere in the app |
| **Local Storage** | SQLCipher AES-256 for SAF queue; `flutter_secure_storage` (Android Keystore) for keys |
| **PII Logging** | Custom Logger intercepts all log calls; regex redacts 16-digit PANs and 12-digit MyKads before write |

### 5.2 Error Code Registry (Channel App)

All error codes align to the platform taxonomy. The app maps backend error codes (from JSON responses) to user-facing messages.

| Platform Code | User-Facing Message |
|--------------|---------------------|
| `ERR_AUTH_TOKEN_EXPIRED` | "Session expired — please log in again" |
| `ERR_AUTH_DEVICE_NOT_WHITELISTED` | "Device not authorized for this account" |
| `ERR_VAL_GEOFENCE_BREACH` | "Transaction outside 100m geofence — please verify location" |
| `ERR_VAL_GPS_UNAVAILABLE` | "GPS unavailable — enable location to proceed" |
| `ERR_VAL_AMOUNT_EXCEEDS_LIMIT` | "Amount exceeds STP limit — maximum RM [limit]" |
| `ERR_VAL_INVALID_PHONE_FORMAT` | "Invalid phone number format" |
| `ERR_BIZ_COMPLIANCE_FREEZE` | "Compliance Review — Contact Compliance Officer: 1-800-XXX-XXXX" |
| `ERR_BIZ_INSUFFICIENT_FLOAT` | "Insufficient float balance — please top up" |
| `ERR_BIZ_LIMIT_EXCEEDED` | "Daily transaction limit reached" |
| `ERR_EXT_SWITCH_DECLINED` | "Transaction declined — please ask customer to contact their bank" |
| `ERR_EXT_BILLER_UNAVAILABLE` | "Biller service unavailable — please try again later" |
| `ERR_EXT_KYC_SERVICE_UNAVAILABLE` | "KYC service temporarily unavailable" |
| `ERR_SYS_SERVICE_UNAVAILABLE` | "System unavailable — please try again" |

---

## 6. System Workflows (API Sequence Diagrams)

### 6.1 Standard STP Transaction (Cash Withdrawal)

```
Agent App                  Spring Cloud Gateway          Backend (Tier 2+)
    │                              │                           │
    ├── Geofence pre-check ───────────────────────────────────┤
    │   (local, < 100ms)           │                           │
    ├── POST /transactions/quote ──►                           │
    │                              ├── Rules Service: fees ───►│
    │◄─ {customerFee, commission} ─┤                           │
    │   (Customer taps "Agree")    │                           │
    │   (Hardware PIN entry)       │                           │
    ├── POST /withdrawal ──────────►                           │
    │   (X-Idempotency-Key, X-GPS) │  BlockFloat (Pessimistic Lock)
    │                              │  Switch Auth (ISO 8583 → PayNet)
    │                              │  [25s timeout on Switch]     │
    │◄─ HTTP 200 {COMPLETED} ──────┤  CommitTransaction           │
    │   Print receipt              │  Publish Kafka → SMS          │
    │                              │
    --- OR (on timeout / 5xx) ---
    │◄─ TIMEOUT                   │
    │   Queue MTI 0400 Reversal   │
    │   SAF retry every 60s       │
```

### 6.2 DuitNow Transfer (ISO 20022 Push Notification Flow)

```
Agent App                  Gateway                  Customer Phone
    │                         │                           │
    ├── POST /transfer/duitnow ►                           │
    │   (proxy: Mobile/NRIC/BRN)│  ISO 20022 → PayNet     │
    │                           │  PayNet → Customer Bank  │
    │                           │◄─ Push Notification ─────►│
    │   Polling: GET /transfer/status                       │
    │   every 5s (max 3 min)    │    Customer approves      │
    │◄─ {status: COMPLETED} ────┤    on Mobile Banking App  │
    │   Print banking slip       │                          │
```

### 6.3 Merchant Retail Sale (MDR Flow)

```
Agent App (Merchant Mode)      Gateway          Backend Ledger
    │                              │                 │
    │  IMerchantTerminal           │                 │
    │  displays Dynamic QR code    │                 │
    │  (or card insertion)         │                 │
    ├── POST /retail/sale ─────────►                 │
    │                              │  Credit agent float minus MDR
    │♦DuitNow QR: PayNet webhook──►│                 │
    │◄─ {COMPLETED, mdrAmount} ────┤                 │
    │  Print Sales Receipt          │                 │
```

### 6.4 Cash-Back Hybrid (Split Accounting)

```
Agent App                Gateway             Backend (Split Accounting)
    │                        │                         │
    │  Agent enters:         │                         │
    │  Purchase: RM 20       │                         │
    │  Cash-Back: RM 50      │                         │
    │  Total swipe: RM 70    │                         │
    ├── POST /retail/cashback►                          │
    │                        │  Debit customer: RM 70  │
    │                        │  Credit agent (retail): RM 20 minus MDR
    │                        │  Flag RM 50 as cash-back disbursement
    │◄─ {COMPLETED}──────────┤                         │
    │  Agent hands RM 50 cash│                         │
    │  Print combined receipt│                         │
```

### 6.5 Store & Forward — SAF Reversal Lifecycle

```
App                         Encrypted SQLite Queue        Backend
 │                                │                          │
 │  HTTP 200 received             │                          │
 │  Printer JAMS ────────────────►│  Queue MTI 0400 entry    │
 │  Float NOT adjusted locally    │  idempotency_key stored  │
 │                          [60s later]                      │
 │  Background worker            ─┤                          │
 │                                ├── POST /reversal ─────────►
 │                                │◄─ HTTP 200 (confirmed) ───┤
 │                                │  DELETE queue entry       │
```

---

## 7. EOD Settlement UI Flow (Phase 2)

```
23:55 MYT    ──► Warning banner: "Settlement in 5 minutes. Please wrap up."
23:59:59 MYT ──► All STP workflows disabled. UI: "Settlement in progress..."
[Backend EOD batch runs: BlockFloat locked, CommitTransaction, CSV generated]
~02:00 AM    ──► Backend signals completion
             ──► App clears EOD lock. UI: "Settlement complete. New business day."
             ──► All STP workflows re-enabled
```

---

## 8. Compliance Lock / Unlock Lifecycle (Phase 2)

```
Normal Operation
    │
    ▼ (backend returns ERR_BIZ_COMPLIANCE_FREEZE)
LOCKED
    │  go_router clears all routes → ComplianceLockScreen
    │  isComplianceLocked = true persisted in encrypted storage
    │  All financial routes inaccessible
    │
    ▼ (backend sends Unlock webhook)
UNLOCKED (automatically)
    │  isComplianceLocked = false cleared from encrypted storage
    │  go_router allows navigation to home screen
    │  Agent notified: "Terminal Unlocked. You may resume operations."
    │  NO app restart required
```

---

## 9. Key Technical Decisions (Derived from Arch Supplementary)

| Decision | Rationale |
|----------|-----------|
| **ZERO retries for financial auth** | Retrying a timed-out payment risks double-deduction (Platform FR-18.4, Arch Supplementary "30-Second Rule") |
| **60s SAF retry interval** | Aligned to Platform FR-18.2 and Arch Supplementary "Never Give Up" reversal rule |
| **25s client-side timeout** | Mirror of Tier 2→Tier 3 internal timeout; if no HTTP response in 25s, assume unknown state |
| **Pessimistic lock observance** | App must show persistent loading during PROCESSING state — backend has funds locked and cannot be interrupted mid-Saga |
| **Float never adjusted locally** | Float is owned by the Ledger Service; app only reflects balance from `GET /api/v1/agent/balance` |
| **IMerchantTerminal HAL** | DuitNow QR merchant mode requires a display surface abstracted from vendor QR rendering SDKs |
| **GoRouter dead-end for LOCKED** | Compliance Lock must be irreversible from the app side; only backend webhook can unlock it |
| **mTLS not required at Tier 1** | mTLS is for internal service-to-service (Tier 2 intranet); Tier 1 uses TLS 1.2+ + JWT |

---
**End of System Design Specification**
