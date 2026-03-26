# Business Requirements Document (BRD)
## Agent Banking Channel App

**Version:** 1.0  
**Date:** 2026-03-25  
**Status:** Draft — Pending Review  
**Module:** Channel App (com.banking.channel)  

---

## 1. Project Overview & Goals

### Project Name
Agent Banking Channel App for POS Terminal, Mobile, Tablet

### Business Purpose
Provide agents (retail merchants) with a secure, STP-compliant mobile/POS application to process banking transactions (Withdrawal, Deposit, Balance Inquiry, e-KYC) by consuming the existing Agent Banking Platform backend APIs. The app must enforce the Dual-Handshake workflow, geofencing, and pre-funded float constraints to achieve 100% Straight-Through Processing (STP) for eligible transactions.

### Target Users
- **Agents** (Micro/Standard/Premier tiers) — retail merchants operating POS terminals
- **Customers** — individuals receiving banking services (indirect users, interact via agent's device)
- **Bank Operations** — not direct users (use backoffice web app)

### Deliverables
1. **Channel App** — Flutter application for Android phones/tablets/POS terminals
2. **Hardware Integration Layer** — Platform channels for EMV card reader, encrypted PIN pad, receipt printer, biometric scanner
3. **Offline Capability** — Store & Forward queue for network interruptions
4. **Compliance Enforcement** — Geofence, velocity checks, dual-handshake UI, no PII in logs

### External API Consumers
- Backend Platform (Spring Cloud Gateway) — consumes OpenAPI 3.0 spec at `docs/api/openapi.yaml`
- POS terminal hardware via Android platform channels

### Business Goals
1. Enable agents to process STP transactions with zero bank intervention (Category 1 STP)
2. Ensure 100% compliance with BNM Agent Banking guidelines (geofence, pre-funded float, dual-handshake)
3. Provide intuitive, bilingual (Bahasa Malaysia/English) UI for agent and customer
4. Achieve high reliability in intermittent network conditions (Store & Forward)
5. Enforce security: no PII in logs, encrypted storage, hardware-level PIN handling

### MVP Scope (Phase 1)
- Agent authentication (biometric/OTP, session management)
- Cash Withdrawal (EMV card + PIN, geofence, dual-handshake)
- Cash Deposit (account validation, cash receipt confirmation)
- Balance Inquiry (customer)
- e-KYC: MyKad verification + biometric (Conditional STP)
- Agent wallet balance display
- Offline mode with Store & Forward queue
- Receipt printing (optional)

### Phase 2 Scope
- Bill Payments (JomPAY, ASTRO RPN, TM RPN, EPF)
- Prepaid Top-up (CELCOM, M1)
- DuitNow Fund Transfer
- Sarawak Pay e-Wallet
- eSSP Purchase
- PIN Purchase, Cashless Payment
- Account opening (post-KYC auto-approval)
- Advanced backoffice features from agent app

---

## 2. User Roles & Stories

### Roles

| Role | Responsibilities |
|------|------------------|
| **Agent** | Logs into terminal, processes transactions, handles cash, verifies customer identity via KYC, manages device |
| **Customer** | Presents card/ID, enters PIN, confirms transactions, receives receipts (interacts via agent's device) |
| **Bank Operations** | Configure agents, view monitoring dashboards (use backoffice web, not channel app) |

---

### Agent User Stories

**Authentication & Setup**
- **US-CA-01**: As an agent, I want to log into the channel app with my credentials (biometric or OTP) so I can access my agent session securely
- **US-CA-02**: As an agent, I want the app to verify I'm within 100m of my registered GPS location before allowing any transaction (geofence enforcement)
- **US-CA-03**: As an agent, I want to see my current wallet balance (total, reserved, available) before initiating any transaction

**Dual-Handshake STP Transactions**
- **US-CA-04**: As an agent, I want to process a cash withdrawal using the Dual-Handshake workflow:
  1. I select "Withdrawal" and enter amount
  2. Customer inserts EMV card into hardware reader
  3. Customer enters PIN on encrypted hardware PIN pad (I never see PIN)
  4. Customer confirms amount on customer display
  5. Transaction executes instantly if all checks pass
- **US-CA-05**: As an agent, I want to see real-time status (processing, completed, failed) during a transaction
- **US-CA-06**: As an agent, if a transaction fails, I want clear error messages (e.g., "Insufficient float", "Daily limit exceeded", "Outside geofence") so I can advise the customer
- **US-CA-07**: As an agent, after successful withdrawal, I want the app to print a receipt and trigger an SMS to the customer

**Deposit & Balance Inquiry**
- **US-CA-08**: As an agent, I want to process a cash deposit by entering the customer's account number and validating it before accepting cash
- **US-CA-09**: As an agent, I want the app to validate the destination account (ProxyEnquiry) before I collect cash from the customer
- **US-CA-10**: As an agent, I want my wallet balance to update immediately after a successful deposit
- **US-CA-11**: As an agent, I want to check a customer's account balance (card + PIN) so they can see their funds
- **US-CA-12**: As an agent, I want only the masked account number (e.g., ****7890) to be displayed for privacy

**e-KYC (Conditional STP)**
- **US-CA-13**: As an agent, I want to verify a customer's MyKad using the device camera/NFC to read chip data
- **US-CA-14**: As an agent, I want to capture the customer's thumbprint using the biometric scanner
- **US-CA-15**: As an agent, I want to know immediately whether the KYC was auto-approved or flagged for manual review
- **US-CA-16**: As an agent, after auto-approval, I want to open a new account for the customer

**Customer-Facing UI**
- **US-CA-19**: As a customer, I want to see clear instructions on the customer-facing display in Bahasa Malaysia/English
- **US-CA-20**: As a customer, I want to confirm the transaction amount before entering my PIN
- **US-CA-21**: As a customer, I want audio prompts (optional) if I have difficulty reading
- **US-CA-22**: As an agent, my screen must never show the customer's full PAN or PIN
- **US-CA-23**: As an agent, after customer inserts card and enters PIN, I should see "Customer authenticated - processing" then result

**Offline & Error Handling**
- **US-CA-17**: As an agent, if the network drops, I want the app to queue transactions and auto-sync when network returns (Store & Forward)
- **US-CA-18**: As an agent, I want clear, actionable error messages when a transaction fails

**Hardware & Reliability**
- **US-CA-24**: As an agent, I want the app to detect hardware issues (card reader, printer) on startup and warn me
- **US-CA-25**: As an agent, I want the app to continue working even if the printer fails (transaction completes, print skipped)

---

### Customer User Stories
*Customers do not directly operate the app. All actions are facilitated by the agent. The app must provide customer-facing screens for card insertion, PIN entry, amount confirmation, and result display.*

---

### User Story → Functional Requirement Mapping

| User Story | Functional Requirements |
|------------|------------------------|
| US-CA-01 | FR-CA-1.1, FR-CA-1.2, FR-CA-1.3, FR-CA-1.4, FR-CA-1.5 |
| US-CA-02 | FR-CA-2.2, FR-CA-2.3, FR-CA-2.4, FR-CA-2.5 |
| US-CA-03 | FR-CA-3.1, FR-CA-3.2, FR-CA-3.4, FR-CA-3.5 |
| US-CA-04 | FR-CA-4.2, FR-CA-5.2, FR-CA-5.8 |
| US-CA-05 | FR-CA-4.5, FR-CA-5.5 |
| US-CA-06 | FR-CA-5.7, FR-CA-11.1, FR-CA-11.2 |
| US-CA-07 | FR-CA-5.6, FR-CA-10.1 |
| US-CA-08 | FR-CA-6.2, FR-CA-6.5 |
| US-CA-09 | FR-CA-6.3 |
| US-CA-10 | FR-CA-6.7, FR-CA-3.2 |
| US-CA-11 | FR-CA-7.2, FR-CA-7.3 |
| US-CA-12 | FR-CA-7.3 |
| US-CA-13 | FR-CA-8.1 |
| US-CA-14 | FR-CA-8.3 |
| US-CA-15 | FR-CA-8.6 |
| US-CA-16 | FR-CA-8.7 |
| US-CA-17 | FR-CA-9.1, FR-CA-9.3, FR-CA-9.5 |
| US-CA-18 | FR-CA-11.1 |
| US-CA-19 | FR-CA-4.1 |
| US-CA-20 | FR-CA-4.4 |
| US-CA-21 | FR-CA-4.1 (audio) |
| US-CA-22 | FR-CA-4.6 |
| US-CA-23 | FR-CA-4.5 |
| US-CA-24 | FR-CA-10.2 |
| US-CA-25 | FR-CA-10.3, FR-CA-11.3 |

---

## 3. Functional Requirements

### FR-CA-1: Agent Authentication & Session Management

| ID | Requirement | US |
|----|------------|-----|
| FR-CA-1.1 | App shall require agents to authenticate using biometric fingerprint or OTP on each launch | US-CA-01 |
| FR-CA-1.2 | App shall maintain a secure JWT session that expires after configurable timeout (default 8 hours) | US-CA-01 |
| FR-CA-1.3 | App shall bind device ID (MAC address) to agent session and validate against whitelist | US-CA-01 |
| FR-CA-1.4 | App shall clear all sensitive data (JWT, session state) on logout or session expiry | US-CA-01 |
| FR-CA-1.5 | App shall support re-authentication without full restart when session expires | US-CA-01 |

---

### FR-CA-2: Geofence Enforcement

| ID | Requirement | US |
|----|------------|-----|
| FR-CA-2.1 | App shall request GPS permission on first launch and continuously monitor location | US-CA-02 |
| FR-CA-2.2 | Before initiating any STP transaction, app shall verify current GPS coordinates are within 100m radius of registered merchant location | US-CA-02 |
| FR-CA-2.3 | If geofence check fails, app shall block transaction and display error "Transaction outside 100m geofence" | US-CA-02 |
| FR-CA-2.4 | App shall send GPS coordinates (lat, lng) in every API request header (`X-GPS-Latitude`, `X-GPS-Longitude`) | US-CA-02 |
| FR-CA-2.5 | App shall continuously display geofence status in UI (green icon when inside, red when outside) | US-CA-02 |

---

### FR-CA-3: Agent Float & Balance Display

| ID | Requirement | US |
|----|------------|-----|
| FR-CA-3.1 | App shall display agent's available float balance prominently on home screen | US-CA-03 |
| FR-CA-3.2 | App shall update balance in real-time after any transaction | US-CA-10 |
| FR-CA-3.3 | Balance display shall show: total balance, reserved balance (pending transactions), available balance | US-CA-03 |
| FR-CA-3.4 | App shall fetch latest balance on app foreground and every 30 seconds | US-CA-03 |
| FR-CA-3.5 | If balance fetch fails, app shall display last known balance with "stale" indicator | US-CA-03 |

---

### FR-CA-4: Dual-Handshake STP Workflow

| ID | Requirement | US |
|----|------------|-----|
| FR-CA-4.1 | App shall provide customer-facing display (or agent-customer shared view) for customer interactions | US-CA-19, US-CA-20 |
| FR-CA-4.2 | For card transactions, app shall: <br> a. Prompt customer to insert card into hardware reader <br> b. Detect card insertion via hardware API <br> c. Display "Please enter your 6-digit PIN" on customer display <br> d. Capture PIN via encrypted hardware PIN pad (PIN never visible in app logs) | US-CA-04, US-CA-04a, US-CA-04b |
| FR-CA-4.3 | App shall enforce that agent cannot proceed if customer PIN is not captured | US-CA-04 |
| FR-CA-4.4 | For cash transactions, app shall display transaction amount to customer for confirmation before processing | US-CA-04c |
| FR-CA-4.5 | App shall show distinct UI states: Agent action → Customer action → Processing → Result | US-CA-04, US-CA-05 |
| FR-CA-4.6 | App shall NOT log or store full PAN, PIN, MyKad, biometric data (only masked PAN in UI) | US-CA-22, Security |

---

### FR-CA-5: Cash Withdrawal (STP Transaction)

| ID | Requirement | US |
|----|------------|-----|
| FR-CA-5.1 | Agent selects "Withdrawal", enters amount (validated against agent limits) | US-CA-04 |
| FR-CA-5.2 | App performs client-side validation: amount ≤ min(agent daily limit, agent available float, max transaction limit) | US-CA-04 |
| FR-CA-5.3 | App triggers Dual-Handshake: card insert → PIN entry → amount confirmation | US-CA-04 |
| FR-CA-5.4 | App sends transaction request with headers: `X-Idempotency-Key`, `X-POS-Terminal-Id`, `X-GPS-Latitude`, `X-GPS-Longitude`, Authorization: Bearer JWT | US-CA-04 |
| FR-CA-5.5 | App displays processing indicator with timeout (default 15 seconds) | US-CA-05 |
| FR-CA-5.6 | On success: <br> a. Display "Transaction Successful" to both agent and customer <br> b. Print receipt (if printer available) <br> c. Show updated float balance <br> d. Backend triggers customer SMS receipt | US-CA-07 |
| FR-CA-5.7 | On failure, display specific error from backend with clear `action_code` (DECLINE/RETRY/REVIEW) | US-CA-06 |
| FR-CA-5.8 | App shall support transaction reversal (MTI 0400) if printer fails or network drops after switch approval (Store & Forward) | US-CA-07 |

---

### FR-CA-6: Cash Deposit (STP Transaction)

| ID | Requirement | US |
|----|------------|-----|
| FR-CA-6.1 | Agent selects "Deposit", enters destination account number | US-CA-08 |
| FR-CA-6.2 | App shows "Validating account..." while calling backend ProxyEnquiry/AccountEnquiry | US-CA-08 |
| FR-CA-6.3 | If account invalid, show error and prevent cash acceptance | US-CA-09 |
| FR-CA-6.4 | If account valid, agent enters amount | US-CA-08 |
| FR-CA-6.5 | Agent collects cash from customer, confirms "Cash Received" in app | US-CA-08 |
| FR-CA-6.6 | App triggers transaction (no customer PKI needed for deposit — agent holds cash) | US-CA-08 |
| FR-CA-6.7 | On success: agent float credited instantly, receipt printed, balance updates | US-CA-10 |

---

### FR-CA-7: Balance Inquiry (STP)

| ID | Requirement | US |
|----|------------|-----|
| FR-CA-7.1 | Agent selects "Balance Inquiry" from menu | US-CA-11 |
| FR-CA-7.2 | App requires customer card + PIN (Dual-Handshake) for authentication | US-CA-11 |
| FR-CA-7.3 | App displays customer balance on both agent and customer screens (masked account number) | US-CA-12 |
| FR-CA-7.4 | App shall NOT store or log balance data locally after inquiry | US-CA-12 |

---

### FR-CA-8: e-KYC Verification (Conditional STP)

| ID | Requirement | US |
|----|------------|-----|
| FR-CA-8.1 | Agent selects "KYC Verify", app launches MyKad scanner (camera/NFC) | US-CA-13 |
| FR-CA-8.2 | App captures MyKad image, performs OCR locally or sends to backend for data extraction | US-CA-13 |
| FR-CA-8.3 | Agent directs customer to place thumb on biometric scanner | US-CA-14 |
| FR-CA-8.4 | App sends MyKad data + biometric to backend for verification | US-CA-14 |
| FR-CA-8.5 | Backend returns status: AUTO_APPROVED / MANUAL_REVIEW / REJECTED | US-CA-15 |
| FR-CA-8.6 | App displays result immediately with clear messaging | US-CA-15 |
| FR-CA-8.7 | If AUTO_APPROVED, offer "Open Account" next step | US-CA-16 |
| FR-CA-8.8 | If MANUAL_REVIEW, inform agent "Queued for review — customer will be notified" | US-CA-15 |

---

### FR-CA-9: Offline & Store & Forward

| ID | Requirement | US |
|----|------------|-----|
| FR-CA-9.1 | App shall detect network connectivity loss (heartbeat to backend every 30s) | US-CA-17 |
| FR-CA-9.2 | If network available, all transactions real-time (STP) | US-CA-17 |
| FR-CA-9.3 | If network lost during transaction, app shall: <br> a. Show "Network unavailable" to customer <br> b. NOT reverse float locally (trust backend) <br> c. Queue transaction with X-Idempotency-Key for retry <br> d. Retry automatically every 30s until success or user cancels | US-CA-17, US-CA-18 |
| FR-CA-9.4 | App shall display "Offline mode" banner when disconnected | US-CA-17 |
| FR-CA-9.5 | Queued transactions shall be encrypted at rest on device (SQLite + encryption) | US-CA-17 |
| FR-CA-9.6 | App shall show sync status: pending count, last successful sync | US-CA-17 |

---

### FR-CA-10: Hardware Integration (POS)

| ID | Requirement | US |
|----|------------|-----|
| FR-CA-10.1 | App shall integrate with Android POS hardware via platform channels: <br> a. EMV card reader <br> b. Encrypted PIN pad (HSM-connected) <br> c. Receipt printer <br> d. Biometric scanner (thumbprint) | US-CA-04, US-CA-07, US-CA-14 |
| FR-CA-10.2 | App shall detect hardware availability on startup and warn if missing | US-CA-24 |
| FR-CA-10.3 | For card-less deposit, agent enters account manually (hardware not required) | US-CA-08 |
| FR-CA-10.4 | Receipt printing shall be optional (configurable) | US-CA-25 |
| FR-CA-10.5 | App shall gracefully handle hardware failures during transaction (e.g., printer jam) without losing transaction | US-CA-25 |

---

### FR-CA-11: Error Handling & User Experience

| ID | Requirement | US |
|----|------------|-----|
| FR-CA-11.1 | App shall display user-friendly error messages (translating backend error codes) | US-CA-06, US-CA-18 |
| FR-CA-11.2 | Agent-facing errors shall include error code for support (e.g., `ERR_GEOFENCE_VIOLATION`) | US-CA-06 |
| FR-CA-11.3 | Customer-facing screens shall avoid technical jargon (e.g., "Card declined" not "ERR_INSUFFICIENT_FLOAT") | US-CA-06 |
| FR-CA-11.4 | App shall retry idempotent operations automatically on network timeout (up to 3 retries with exponential backoff) | US-CA-17 |
| FR-CA-11.5 | App shall allow transaction cancellation at any step before final confirmation | US-CA-18 |
| FR-CA-11.6 | App shall show timeouts and progress indicators during long-running operations | US-CA-05 |

---

### FR-CA-12: Security & Compliance

| ID | Requirement | US |
|----|------------|-----|
| FR-CA-12.1 | App shall never log PAN, PIN, MyKad, biometric, or JWT in plaintext (zero PII in logs) | US-CA-01 |
| FR-CA-12.2 | All local storage of sensitive data shall use encrypted SharedPreferences/Flutter Secure Storage (Android Keystore) | US-CA-01 |
| FR-CA-12.3 | App shall enforce TLS 1.2+ for all API communications; implement certificate pinning (configurable) | US-CA-01 |
| FR-CA-12.4 | App shall clear clipboard and block screenshots on sensitive screens (KYC, PIN entry) | US-CA-01 |
| FR-CA-12.5 | App shall support remote logout/revocation of JWT by backend (force re-auth) | US-CA-01 |
| FR-CA-12.6 | App shall comply with STP Dual-Handshake: agent never sees customer PIN, customer authorizes independently | STP Rules |
| FR-CA-12.7 | App shall mask PAN in all displays and receipts (first 6, last 4 digits) | Security |
| FR-CA-12.8 | Biometric authentication for agent login shall use Android BiometricPrompt (templates not stored in app) | Security |

---

## 4. Entity Definitions

*Note: The channel app is a stateful client. Entities below represent **local persistent state** the app manages. Backend entities are defined in the backend BRD.*

---

### ENT-CA-1: AgentSession

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| sessionId | String (UUID) | Yes | Unique session identifier |
| agentId | String (UUID) | Yes | Agent identifier from JWT claims |
| agentCode | String | Yes | Human-readable agent code (e.g., "AGT-00123") |
| jwtToken | String (encrypted) | Yes | Active JWT token (stored in secure storage) |
| expiresAt | DateTime | Yes | Token expiry timestamp |
| deviceId | String | Yes | MAC address / Device unique ID (Android ID) |
| isAuthenticated | Boolean | Yes | Current auth state |
| createdAt | DateTime | Yes | Session start time |
| lastActivityAt | DateTime | Yes | Last user interaction timestamp |

**Key invariants**:
- One active session per device
- Session cleared on logout/expiry
- Device ID must match whitelist in backend

---

### ENT-CA-2: AgentFloat (Cached)

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| agentId | String (UUID) | Yes | Agent identifier |
| balance | BigDecimal | Yes | Current total balance in RM |
| reservedBalance | BigDecimal | Yes | Amount reserved for pending transactions (backend-managed) |
| availableBalance | BigDecimal | Yes | Computed: balance - reservedBalance |
| currency | String (3) | Yes | Always "MYR" |
| lastUpdated | DateTime | Yes | Last successful fetch from backend |
| syncStatus | Enum | Yes | SYNCED, SYNCING, STALE |

**Note**: Client maintains cached copy for instant UI; backend is source of truth. App fetches on foreground and every 30s.

---

### ENT-CA-3: Transaction (Local Queue)

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| transactionId | String (UUID) | Yes | Generated locally (used as X-Idempotency-Key) |
| agentId | String (UUID) | Yes | Agent initiating |
| type | Enum | Yes | WITHDRAWAL, DEPOSIT, BALANCE_INQUIRY, KYC_VERIFY |
| amount | BigDecimal | Conditional | Transaction amount (null for balance/KYC) |
| status | Enum | Yes | PENDING, PROCESSING, COMPLETED, FAILED, REVERSED, QUEUED_OFFLINE |
| requestPayload | JSON | Yes | Full request body to send to backend |
| responsePayload | JSON | Conditional | Backend response (if received) |
| errorCode | String | Conditional | Error code if failed |
| createdAt | DateTime | Yes | Local creation timestamp |
| completedAt | DateTime | Conditional | Transaction completion timestamp |
| retryCount | Integer | Yes | Number of auto-retry attempts (0-3 max) |
| xIdempotencyKey | String | Yes | Idempotency key (same as transactionId) |

**Queue management**:
- Offline transactions stored as `QUEUED_OFFLINE`
- Background service retries every 30s when network returns
- Max 3 retries before manual intervention flag

---

### ENT-CA-4: Geofence

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| merchantLat | Decimal(9,6) | Yes | Registered GPS latitude (from backend agent profile) |
| merchantLng | Decimal(9,6) | Yes | Registered GPS longitude |
| radiusMeters | Integer | Yes | Allowed radius (default 100, configurable) |
| currentLat | Decimal(9,6) | Yes | Latest device GPS reading |
| currentLng | Decimal(9,6) | Yes | Latest device GPS reading |
| isInside | Boolean | Yes | Computed: haversine distance ≤ radius |
| lastCheckedAt | DateTime | Yes | Last geofence calculation timestamp |
| gpsAccuracyMeters | Decimal(5,2) | Yes | Accuracy of current GPS reading (from GPS provider) |

**Computation**: Haversine distance formula in meters. Geofence check runs before every STP transaction.

---

### ENT-CA-5: HardwareStatus

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| cardReader | Enum | Yes | AVAILABLE, UNAVAILABLE, BUSY, ERROR |
| pinPad | Enum | Yes | AVAILABLE, UNAVAILABLE, BUSY, ERROR |
| printer | Enum | Yes | AVAILABLE, UNAVAILABLE, OUT_OF_PAPER, ERROR |
| biometricScanner | Enum | Yes | AVAILABLE, UNAVAILABLE, ERROR |
| lastCheckAt | DateTime | Yes | Last hardware health check timestamp |
| errorMessage | String | Conditional | Last error description if unavailable |
| printerPaperLevel | Integer | Conditional | Remaining paper count (if available) |

**Usage**: Checked on app startup and periodically (every 5 min). If critical hardware (card reader, PIN pad) unavailable, block STP transactions and show warning.

---

### ENT-CA-6: CustomerDisplayState

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| currentStep | Enum | Yes | IDLE, WAITING_CARD, WAITING_PIN, CONFIRM_AMOUNT, PROCESSING, SUCCESS, FAILURE |
| transactionType | Enum | Conditional | Current transaction type (WITHDRAWAL, DEPOSIT, etc.) |
| amount | BigDecimal | Conditional | Transaction amount (if applicable) |
| maskedCard | String | Conditional | Displayed masked PAN (e.g., `411111******1111`) |
| message | String | Yes | Text to show on customer-facing display |
| language | Enum | Yes | BM (Bahasa Malaysia), EN (English) |
| timeoutAt | DateTime | Conditional | Auto-cancel if customer inactive beyond this time |

**Purpose**: Controls what the customer sees on the shared/dual display. Agent's screen shows simplified state machine.

---

### ENT-CA-7: AuditLog (Client-Side)

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| auditId | String (UUID) | Yes | Unique audit ID |
| entityType | String | Yes | SESSION, TRANSACTION, HARDWARE, ERROR, GEOLOCATION |
| entityId | String | Yes | Reference ID (sessionId, transactionId, etc.) |
| action | Enum | Yes | LOGIN, LOGOUT, TRANSACTION_START, TRANSACTION_COMPLETE, HARDWARE_FAILURE, GEOLOCATION_CHANGE |
| performedBy | String | Yes | Agent ID or "SYSTEM" |
| changes | JSON | Conditional | Before/after values (for state changes) |
| ipAddress | String | Yes | Local device IP (for debugging) |
| userAgent | String | Yes | App version + OS + Device model |
| timestamp | DateTime | Yes | Event time (ISO 8601) |

**Note**: Client-side audit trail for local debugging only. Backend audit log is authoritative.

---

## 5. Non-Functional Requirements

### NFR-CA-1: Performance

| ID | Requirement |
|----|------------|
| NFR-CA-1.1 | App cold start to login screen: < 2 seconds on mid-range Android device (e.g., Snapdragon 700 series) |
| NFR-CA-1.2 | Transaction processing time (customer PIN entry to result): < 5 seconds for STP (p95) |
| NFR-CA-1.3 | Balance refresh API call: < 2 seconds (p95) over 4G network |
| NFR-CA-1.4 | Offline queue retrieval from SQLite: < 500ms (local) |
| NFR-CA-1.5 | App memory footprint: < 150MB typical usage (no memory leaks over 8-hour shift) |
| NFR-CA-1.6 | UI frame rate: 60fps during animations, no jank during transaction flows |

---

### NFR-CA-2: Reliability & Availability

| ID | Requirement |
|----|------------|
| NFR-CA-2.1 | App crash-free sessions: ≥ 99.5% (measured via crash reporting) |
| NFR-CA-2.2 | Automatic recovery from network interruptions without data loss or inconsistent state |
| NFR-CA-2.3 | Graceful degradation: If printer fails, transaction still completes and shows "Print failed" warning (retry option) |
| NFR-CA-2.4 | Offline queue durability: Transactions persisted to encrypted SQLite; survive app restarts, device reboots |
| NFR-CA-2.5 | Store & Forward: Queued transactions retry with exponential backoff (30s, 60s, 120s, then manual flag) |
| NFR-CA-2.6 | Hardware disconnection handling: App detects unplugged card reader/PIN pad and blocks affected transaction types |

---

### NFR-CA-3: Security

| ID | Requirement |
|----|------------|
| NFR-CA-3.1 | Zero PII in logs: No full PAN, PIN, MyKad, JWT, or biometric data in logcat or crash reports (verify with static analysis) |
| NFR-CA-3.2 | Secure storage: JWT, session keys stored in Flutter Secure Storage (Android Keystore-backed) |
| NFR-CA-3.3 | Certificate pinning for backend API (SHA-256 pins in prod, optional in dev) |
| NFR-CA-3.4 | TLS 1.2+ enforcement; reject weak ciphers (RC4, 3DES) |
| NFR-CA-3.5 | Screenshot protection: Block screenshots on sensitive screens (KYC, PIN entry, login) using `WindowManager.LayoutParams.FLAG_SECURE` |
| NFR-CA-3.6 | Auto-logout after 2 minutes of inactivity (configurable via backend) |
| NFR-CA-3.7 | Device integrity check: Detect rooted/jailbroken devices (flag only, not block unless policy requires) |
| NFR-CA-3.8 | Biometric authentication: Use Android BiometricPrompt for agent login; templates stored in TEE/SE, not in app |
| NFR-CA-3.9 | PIN handling: Never display PIN on screen; only hardware PIN pad (HSM) captures and encrypts |

---

### NFR-CA-4: Compliance (BNM & Regulatory)

| ID | Requirement |
|----|------------|
| NFR-CA-4.1 | Geofence compliance: Block transactions outside 100m radius (configurable per agent, enforced at client & backend) |
| NFR-CA-4.2 | Velocity limit client-side check: Pre-check against cached limits before sending request (reduces roundtrips for obvious failures) |
| NFR-CA-4.3 | PAN masking: Display only first 6 and last 4 digits; receipts, logs, UI all masked |
| NFR-CA-4.4 | Receipt printing: Include masked PAN, transaction ID, amount, timestamp, agent code |
| NFR-CA-4.5 | SMS receipt: Backend sends SMS to customer's registered mobile; app triggers by calling backend endpoint |
| NFR-CA-4.6 | Language support: Bahasa Malaysia and English (switchable in settings; default BM) |
| NFR-CA-4.7 | Audit trail: All agent actions logged with timestamp, agent ID, transaction ID (client + backend) |

---

### NFR-CA-5: Usability & Accessibility

| ID | Requirement |
|----|------------|
| NFR-CA-5.1 | Large touch targets: Minimum 48x48dp for all interactive elements (Material Design 3 standard) |
| NFR-CA-5.2 | High contrast mode support for outdoor sunlight readability (test on 1000 nits display) |
| NFR-CA-5.3 | Audio prompts: Optional voice guidance for customer-facing steps (configurable volume) |
| NFR-CA-5.4 | Error messages in clear Bahasa Malaysia and English (no jargon) |
| NFR-CA-5.5 | Transaction timeout indicator: Show countdown (e.g., 30s) during processing for customer awareness |
| NFR-CA-5.6 | Support landscape orientation for POS terminals (configurable per device type; portrait default for phones) |
| NFR-CA-5.7 | Color-blind-friendly palette: Avoid red/green as sole status indicator (use icons + text) |

---

### NFR-CA-6: Observability & Monitoring

| ID | Requirement |
|----|------------|
| NFR-CA-6.1 | Structured logging: Use `package:logging` with severity levels (INFO, WARNING, ERROR); JSON format optional for aggregation |
| NFR-CA-6.2 | Crash reporting: Integrate Sentry or Firebase Crashlytics with PII sanitization (scrub PAN, PIN, JWT from reports) |
| NFR-CA-6.3 | Performance monitoring: Track transaction duration, API latencies, UI frame drops (custom analytics) |
| NFR-CA-6.4 | Health check endpoint: `/health` for device monitoring (battery, GPS, network, hardware status) — used by MDM if needed |
| NFR-CA-6.5 | Telemetry: Optional anonymized usage stats (opt-in during first launch; can be disabled by bank policy) |
| NFR-CA-6.6 | Debug mode: Secure way for support to enable verbose logging (requires remote activation by bank admin) |

---

### NFR-CA-7: Maintainability & Testability

| ID | Requirement |
|----|------------|
| NFR-CA-7.1 | Feature-first architecture: `lib/features/` (withdrawal, deposit, kyc, etc.) with presentation, domain, data layers inside each feature |
| NFR-CA-7.2 | Unit test coverage: ≥ 70% for business logic (use cases, validators, state management) — not UI widgets |
| NFR-CA-7.3 | Widget test coverage: ≥ 50% for critical screens (login, transaction flows, error states) |
| NFR-CA-7.4 | Mockable hardware interfaces: All POS hardware accessed via abstract classes/interfaces with test doubles |
| NFR-CA-7.5 | Configurable via remote config: timeouts, retry counts, feature flags (using Firebase Remote Config or similar) |
| NFR-CA-7.6 | Dependency injection: Use `get_it` service locator or `riverpod` for clean separation and testability |
| NFR-CA-7.7 | Code generation: Use `freezed` for data classes, `json_serializable` for JSON parsing to reduce boilerplate |
| NFR-CA-7.8 | Static analysis: Enforce `analysis_options.yaml` with strict lint rules (no `// ignore` without justification) |

---

### NFR-CA-8: Platform & Device Support

| ID | Requirement |
|----|------------|
| NFR-CA-8.1 | Minimum Android API level: 23 (Android 6.0) |
| NFR-CA-8.2 | Target Android API level: Latest stable (34 at time of release) |
| NFR-CA-8.3 | Support both portrait and landscape orientations (configurable per deployment via remote config) |
| NFR-CA-8.4 | Optimize for 7-10 inch tablets (POS terminals) and 5-6 inch phones (agent smartphones) — responsive layouts |
| NFR-CA-8.5 | Battery optimization: Minimize background wake locks; use WorkManager for periodic sync; respect Doze mode |
| NFR-CA-8.6 | Multi-language: Bahasa Malaysia and English (language files in `assets/locales/`) |
| NFR-CA-8.7 | APK size: < 50MB (split by ABI if needed) |
| NFR-CA-8.8 | OTA updates: Support remote app update via MDM or self-update mechanism (optional) |

---

## 6. Constraints & Assumptions

### Constraints

| ID | Constraint |
|----|-----------|
| C-CA-1 | **Platform**: Flutter (Dart) only — no native Android-only unless hardware requires platform channel |
| C-CA-2 | **Backend API**: Must conform to OpenAPI 3.0 spec at `docs/api/openapi.yaml` (single source of truth) |
| C-CA-3 | **Architecture**: Feature-first layered (presentation, domain, data per feature) |
| C-CA-4 | **Hardware**: POS hardware via Android platform channels — no direct Dart API; must wrap in abstraction layer |
| C-CA-5 | **Security**: No PII in logs — all logging must go through sanitized logger wrapper |
| C-CA-6 | **Offline**: Store & Forward only — no local transaction processing without backend confirmation |
| C-CA-7 | **STP**: Must enforce Dual-Handshake — agent cannot enter/capture customer PIN |
| C-CA-8 | **Geofence**: Client-side check mandatory; backend also enforces (defense-in-depth) |
| C-CA-9 | **Idempotency**: Every transaction request must include unique `X-Idempotency-Key` (UUID) |
| C-CA-10 | **Testing**: Unit tests for business logic; widget tests for critical flows; no mocks of backend (use integration tests) |

---

### Assumptions

| ID | Assumption |
|----|-----------|
| A-CA-1 | POS terminals run Android 8+ with Google Play Services (for biometric, location) |
| A-CA-2 | EMV card reader and encrypted PIN pad are provided by hardware vendor with Android SDK/JAR libraries |
| A-CA-3 | Receipt printers support ESC/POS or similar standard; driver available |
| A-CA-4 | Biometric scanner (thumbprint) is separate from device's built-in fingerprint sensor (agent vs customer) |
| A-CA-5 | Network connectivity is intermittent; Store & Forward must handle days of offline queuing |
| A-CA-6 | Agents have assigned device IDs registered in backend; device pairing is out of scope (handled by operations) |
| A-CA-7 | Backend provides `/health` endpoint for app to check service availability |
| A-CA-8 | All monetary values in backend are MYR; app assumes MYR only (no currency conversion) |
| A-CA-9 | Customer mobile numbers are pre-registered in backend for SMS receipts |
| A-CA-10 | App will be distributed via enterprise MDM (Google Play Private Channel or sideloaded) |
| A-CA-11 | Hardware integration testing will require physical devices — emulators insufficient |
| A-CA-12 | Flutter version: ≥ 3.19 (stable channel) |

---

## 7. Traceability Matrix: User Stories → Functional Requirements

| User Story | Functional Requirements | Phase |
|------------|------------------------|-------|
| US-CA-01 | FR-CA-1.1, FR-CA-1.2, FR-CA-1.3, FR-CA-1.4, FR-CA-1.5 | MVP |
| US-CA-02 | FR-CA-2.2, FR-CA-2.3, FR-CA-2.4, FR-CA-2.5 | MVP |
| US-CA-03 | FR-CA-3.1, FR-CA-3.2, FR-CA-3.4, FR-CA-3.5 | MVP |
| US-CA-04 | FR-CA-4.2, FR-CA-5.2, FR-CA-5.8 | MVP |
| US-CA-05 | FR-CA-4.5, FR-CA-5.5 | MVP |
| US-CA-06 | FR-CA-5.7, FR-CA-11.1, FR-CA-11.2 | MVP |
| US-CA-07 | FR-CA-5.6, FR-CA-10.1 | MVP |
| US-CA-08 | FR-CA-6.2, FR-CA-6.5 | MVP |
| US-CA-09 | FR-CA-6.3 | MVP |
| US-CA-10 | FR-CA-6.7, FR-CA-3.2 | MVP |
| US-CA-11 | FR-CA-7.2, FR-CA-7.3 | MVP |
| US-CA-12 | FR-CA-7.3 | MVP |
| US-CA-13 | FR-CA-8.1 | MVP |
| US-CA-14 | FR-CA-8.3 | MVP |
| US-CA-15 | FR-CA-8.6 | MVP |
| US-CA-16 | FR-CA-8.7 | MVP |
| US-CA-17 | FR-CA-9.1, FR-CA-9.3, FR-CA-9.5 | MVP |
| US-CA-18 | FR-CA-11.1 | MVP |
| US-CA-19 | FR-CA-4.1 | MVP |
| US-CA-20 | FR-CA-4.4 | MVP |
| US-CA-21 | FR-CA-4.1 (audio) | MVP |
| US-CA-22 | FR-CA-4.6 | MVP |
| US-CA-23 | FR-CA-4.5 | MVP |
| US-CA-24 | FR-CA-10.2 | MVP |
| US-CA-25 | FR-CA-10.3, FR-CA-11.3 | MVP |

---

**End of Business Requirements Document**
