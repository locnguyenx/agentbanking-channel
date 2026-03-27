# Business Requirements Document (BRD)
## Agent Banking Channel App

**Version:** 3.0  
**Date:** 2026-03-27  
**Status:** Revised — Aligned with Platform BRD v1.1 & Supplementary Docs  
**Module:** Channel App (com.banking.channel)  
**Supersedes:** `2026-03-25-agent-banking-channel-brd.md`  
**Platform BRD Reference:** `docs/superpowers/specs/agent-banking-platform/2026-03-25-agent-banking-platform-brd.md`

---

## 1. Project Overview & Goals

### Project Name
Agent Banking Channel App — POS Terminal (Android/Flutter)

### Business Purpose
Provide third-party agents (retail merchants) with a secure, STP-compliant Flutter/Android POS application to deliver banking services to underserved customers. The app legally substitutes human judgment with cryptographic proof for Category 1 (100% STP) operations, relies on data-intelligence for Category 2 (Conditional STP), and surfaces Category 3 events to the agent as actionable UI states (Compliance Lock). The app communicates exclusively with the backend platform via REST/HTTPS through the Spring Cloud Gateway.

### STP Strategy (Three Categories)

| Category | Description | Channel Behaviour |
|----------|-------------|-------------------|
| **Category 1 — 100% STP** | Core automated transactions using hardware Dual-Handshake (PIN/EMV/DuitNow) | App drives full workflow end-to-end; no human approval needed |
| **Category 2 — Conditional STP** | Risk-based flows (e-KYC, account opening) using biometrics, AI, AML | App drives workflow; routes to backend rules engine; shows AUTO_APPROVED or MANUAL_REVIEW result |
| **Category 3 — Non-STP** | Compliance events (velocity breaches, dispute resolution) | App enters LOCKED state; directs agent to contact Compliance Officer |

### STP Hard Limits (enforced at API Gateway — channel must pre-check client-side)
- Maximum **RM 3,000** per STP transaction
- Maximum **5 transactions per hour** per customer MyKad

---

## 2. Scope by Phase

### MVP Scope (Phase 1)
| Service | Funding |
|---------|---------|
| Agent Authentication & Session | — |
| Geofence Enforcement | — |
| Agent Float Balance Display | — |
| **Cash Withdrawal** | ATM Card (EMV + PIN) |
| **Cash Deposit** | Cash only |
| **Balance Inquiry** (Customer) | ATM Card (EMV + PIN) |
| **e-KYC / Account Opening** | MyKad Biometric + JPN |
| Store & Forward Reversal | Auto |

### Phase 2+ Scope
| Service | Funding |
|---------|---------|
| Cash Withdrawal | MyKad biometric |
| Cash Deposit | Card |
| **DuitNow Fund Transfer** | Card / Cash / Digital |
| **Bill Payments** (JomPAY, ASTRO, TM, EPF) | Cash / Card |
| **Prepaid Top-Up** (CELCOM, M1) | Cash / Card |
| **Sarawak Pay e-Wallet** (Top-Up / Withdrawal) | Cash / Card |
| **eSSP Purchase** | Cash / Card |
| **PIN Purchase (Digital Voucher)** | Cash |
| **Cashless Retail Sale (Merchant Acquiring)** | Card / DuitNow QR |
| **Cash-Back Hybrid** | Card |
| **Agent Self-Onboarding** (Micro-Agent STP) | — |
| Compliance Unlock (Webhook) | — |
| EOD Settlement UI | — |

---

## 3. Backend / API Dependencies

The Channel App is a pure consumer of the backend platform. It calls Gateway-exposed endpoints only.

| Function | Endpoint (Gateway) | Platform Service |
|----------|--------------------|-----------------|
| Quote (Fee + Commission) | `POST /api/v1/transactions/quote` | Rules Service |
| Cash Withdrawal | `POST /api/v1/withdrawal` | Ledger & Float |
| Cash Deposit | `POST /api/v1/deposit` | Ledger & Float |
| Balance Inquiry | `POST /api/v1/balance-inquiry` | Ledger & Float |
| Agent Float Balance | `GET /api/v1/agent/balance` | Ledger & Float |
| DuitNow Transfer | `POST /api/v1/transfer/duitnow` | Switch Adapter |
| Bill Payment | `POST /api/v1/bill/pay` | Biller Service |
| Prepaid Top-Up | `POST /api/v1/topup` | Biller Service |
| e-Wallet | `POST /api/v1/ewallet/withdraw` / `topup` | Biller Service |
| eSSP Purchase | `POST /api/v1/essp/purchase` | Biller Service |
| Retail Sale | `POST /api/v1/retail/sale` | Merchant Service |
| PIN Purchase | `POST /api/v1/retail/pin-purchase` | Merchant Service |
| Cash-Back Hybrid | `POST /api/v1/retail/cashback` | Merchant Service |
| e-KYC Verify | `POST /api/v1/kyc/verify` | Onboarding Service |
| e-KYC Biometric | `POST /api/v1/kyc/biometric` | Onboarding Service |
| Agent Self-Onboarding | `POST /api/v1/kyc/agent-onboard` | Onboarding Service |

All requests include mandatory headers: `Authorization`, `X-Idempotency-Key`, `X-POS-Terminal-Id`, `X-GPS-Latitude`, `X-GPS-Longitude`.

---

## 4. User Roles & Stories

### Roles

| Role | Responsibilities |
|------|-----------------|
| **Agent** | Operates POS terminal, handles cash, scans IDs, drives UI. Never sees customer PINs. |
| **Customer** | Presents Funding Source (Card/Cash/DuitNow), confirms amounts, enters PIN securely. |
| **Bank Operations** | Configure agents, manage exceptions via backoffice web — **out of scope for channel app**. |

> **Scope Boundary:** Backoffice RBAC roles (VIEWER, OPERATOR, ADMIN) and Maker-Checker workflows are strictly in-scope for the backoffice platform, not the channel app.

---

### Auth, Hardware & Setup

| ID | Story | Phase |
|----|-------|-------|
| **US-CA-01** | As an agent, I want to authenticate via Biometric/OTP so I can start a session and see my pre-funded Float balance. | MVP |
| **US-CA-02** | As an agent, the app must continuously verify I am within a 100m GPS radius of my registered location; otherwise it must block STP transactions. | MVP |

### STP Dual-Handshake & Funding

| ID | Story | Phase |
|----|-------|-------|
| **US-CA-03** | As a customer paying with an **ATM Card**, I want to insert my EMV chip, enter my PIN on the hardware pad, and see the amount deducted instantly. | MVP |
| **US-CA-04** | As a customer using **Physical Cash**, I want the agent to scan my MyKad (for AML/limit tracking) before taking my cash, while I confirm my masked name on the display. | MVP |
| **US-CA-05** | As a customer requesting a **DuitNow Fund Transfer**, I want to give the agent my proxy ID (Mobile Number, MyKad Number, or Business Registration Number), receive a push notification on my phone, and authenticate the transfer there. | Phase 2 |

### Parameter Pricing & Commissions

| ID | Story | Phase |
|----|-------|-------|
| **US-CA-06** | As an agent, before confirming any transaction, I want the UI to display my calculated Commission Earned, while the customer display asks for consent to the Transaction Fee. | MVP |

### Balance Inquiry

| ID | Story | Phase |
|----|-------|-------|
| **US-CA-23** | As a customer, I want to check my bank account balance at the agent's POS terminal using my ATM Card + PIN, without withdrawing any funds. | MVP |

### Cash Withdrawal (Extended Funding)

| ID | Story | Phase |
|----|-------|-------|
| **US-CA-24** | As a customer without an ATM card, I want to withdraw cash using **MyKad biometric** (thumbprint + MyKad chip) as my authentication. | Phase 2 |

### Cash Deposit (Extended Funding)

| ID | Story | Phase |
|----|-------|-------|
| **US-CA-11** | As an agent processing a **Cash Deposit (funded by physical cash)**, I must run a `ProxyEnquiry` and show the recipient's masked name before accepting funds. | MVP |
| **US-CA-25** | As a customer, I want to deposit funds into a destination account funded by my **ATM Card** (EMV + PIN) at the agent's terminal. | Phase 2 |

### Bill Payments — JomPAY

| ID | Story | Phase |
|----|-------|-------|
| **US-CA-07** | As a customer, I want to pay a **JomPAY OFF-US** bill by giving **physical cash** to the agent; the agent validates Ref-1 and confirms cash collected before submitting. | Phase 2 |
| **US-CA-26** | As a customer, I want to pay a **JomPAY OFF-US** bill using my **ATM Card** at the agent's terminal, with Ref-1 validated before PIN entry. | Phase 2 |
| **US-CA-27** | As a customer, I want to pay a **JomPAY ON-US** bill (same bank) using **physical cash** at the agent's terminal; app routes internally without the external PayNet switch. | Phase 2 |
| **US-CA-28** | As a customer, I want to pay a **JomPAY ON-US** bill using my **ATM Card** at the agent's terminal with ON-US internal routing. | Phase 2 |

### Bill Payments — ASTRO RPN

| ID | Story | Phase |
|----|-------|-------|
| **US-CA-29** | As a customer, I want to pay my **ASTRO RPN** subscription bill using **physical cash** at the agent's terminal. | Phase 2 |
| **US-CA-30** | As a customer, I want to pay my **ASTRO RPN** subscription bill using my **ATM Card** at the agent's terminal. | Phase 2 |

### Bill Payments — TM RPN

| ID | Story | Phase |
|----|-------|-------|
| **US-CA-31** | As a customer, I want to pay my **TM Unifi/Streamyx** bill using **physical cash** at the agent's terminal. | Phase 2 |
| **US-CA-32** | As a customer, I want to pay my **TM Unifi/Streamyx** bill using my **ATM Card** at the agent's terminal. | Phase 2 |

### Bill Payments — EPF

| ID | Story | Phase |
|----|-------|-------|
| **US-CA-33** | As a customer, I want to make an **EPF i-SARAAN / i-SURI / Self-Employed** contribution using **physical cash** at the agent's terminal. | Phase 2 |
| **US-CA-34** | As a customer, I want to make an **EPF** contribution using my **ATM Card** at the agent's terminal. | Phase 2 |

### Prepaid Top-Up

| ID | Story | Phase |
|----|-------|-------|
| **US-CA-08** | As a customer, I want to top up my **CELCOM** prepaid using **physical cash** at the agent's terminal; the agent validates my phone number before collecting payment. | Phase 2 |
| **US-CA-35** | As a customer, I want to top up my **CELCOM** prepaid using my **ATM Card** at the agent's terminal. | Phase 2 |
| **US-CA-36** | As a customer, I want to top up my **M1** prepaid using **physical cash** at the agent's terminal. | Phase 2 |
| **US-CA-37** | As a customer, I want to top up my **M1** prepaid using my **ATM Card** at the agent's terminal. | Phase 2 |

### Sarawak Pay e-Wallet

| ID | Story | Phase |
|----|-------|-------|
| **US-CA-38** | As a customer, I want to **withdraw from my Sarawak Pay e-Wallet** and receive physical cash from the agent (e-Wallet debit, agent float credit). | Phase 2 |
| **US-CA-39** | As a customer, I want to **withdraw from my Sarawak Pay e-Wallet** using my **ATM Card** as authentication at the agent's terminal. | Phase 2 |
| **US-CA-40** | As a customer, I want to **top up my Sarawak Pay e-Wallet** by paying **physical cash** to the agent (agent float decreases). | Phase 2 |
| **US-CA-41** | As a customer, I want to **top up my Sarawak Pay e-Wallet** using my **ATM Card** at the agent's terminal. | Phase 2 |

### eSSP Purchase

| ID | Story | Phase |
|----|-------|-------|
| **US-CA-42** | As a customer, I want to **purchase an eSSP certificate** by paying **physical cash** to the agent. | Phase 2 |
| **US-CA-43** | As a customer, I want to **purchase an eSSP certificate** using my **ATM Card** at the agent's terminal. | Phase 2 |

### PIN Purchase (Digital Voucher — Extended)

| ID | Story | Phase |
|----|-------|-------|
| **US-CA-44** | As a customer, I want to **purchase a PIN Voucher** (mobile reload, gaming PIN, BSN voucher) using my **ATM Card** at the agent's terminal; agent earns a commission on the sale. | Phase 2 |

### Conditional STP & Onboarding

| ID | Story | Phase |
|----|-------|-------|
| **US-CA-12** | As an agent opening a new account, I tap the MyKad to run OCR/Chip read and ask the customer to confirm their thumb on the biometric scanner. | MVP |
| **US-CA-13** | If the thumbprint match fails, I want the app to trigger a **Face AI Fallback** (video liveness) and send it with GPS for AML screening. | MVP |
| **US-CA-14** | If e-KYC returns `AUTO_APPROVED`, I want the app to immediately collect the initial deposit and provision the account. | MVP |

### Edge Cases & Safeguards

| ID | Story | Phase |
|----|-------|-------|
| **US-CA-15** | If the network drops after switch approval, I want the app to queue an automated **MTI 0400 Reversal** (Store & Forward) to protect the customer's funds. | MVP |
| **US-CA-16** | If the backend detects structuring (Anti-Smurfing), I want my terminal to transition into a **Compliance Lock** state and direct me to call Support. | Phase 2 |

### Merchant Services (New — Phase 2)

| ID | Story | Phase |
|----|-------|-------|
| **US-CA-17** | As an agent acting as a **merchant**, I want to accept card or DuitNow QR payments for goods/services at my shop, with my float credited instantly after MDR deduction. | Phase 2 |
| **US-CA-18** | As an agent, I want to sell a **Digital PIN Voucher** (mobile reload, gaming PIN, BSN voucher) to a cash-paying customer, with a printed PIN slip as the receipt. | Phase 2 |
| **US-CA-19** | As an agent and a customer, I want to perform a **Cash-Back Hybrid** — a single card swipe that pays for goods and dispenses cash simultaneously, with the system handling the split accounting. | Phase 2 |

### Agent Self-Onboarding (New — Phase 2)

| ID | Story | Phase |
|----|-------|-------|
| **US-CA-20** | As a prospective **Micro-Agent**, I want to self-onboard via the POS app (OCR + Liveness + SSM API + AML check) and receive instant activation if all checks pass, without requiring a bank officer. | Phase 2 |

### Compliance Unlock (New — Phase 2)

| ID | Story | Phase |
|----|-------|-------|
| **US-CA-21** | As an agent whose terminal is compliance-locked, I want the app to automatically exit the `LOCKED` state when the backend sends an Unlock webhook, resuming STP operations without requiring a manual app restart. | Phase 2 |

### EOD Settlement UI (New — Phase 2)

| ID | Story | Phase |
|----|-------|-------|
| **US-CA-22** | As an agent, I want to see an EOD warning at 23:55 MYT, have all STP workflows disabled at 23:59:59 MYT, and receive a notification once settlement is finalized by 02:00 AM so I can begin the next business day. | Phase 2 |

---

## 5. Functional Requirements

### FR-CA-1: Security & Geofencing

| ID | Requirement | Phase |
|----|-------------|-------|
| FR-CA-1.1 | Device binding: Sessions bound via MAC Address/Android ID whitelists. | MVP |
| FR-CA-1.2 | Geofence: Block transactions outside 100m radius of registered lat/lng. Send `X-GPS-Lat`/`X-GPS-Long` headers on all API calls. | MVP |
| FR-CA-1.3 | Session Timeout: JWT auto-expires after 8 hours or 2 hours inactivity. Mid-transaction expiry shows non-blocking re-auth dialog. | MVP |

### FR-CA-2: Parameter & Pricing Engine

| ID | Requirement | Phase |
|----|-------------|-------|
| FR-CA-2.1 | After input validation but *before* the financial handshake, app calls `POST /api/v1/transactions/quote`. | MVP |
| FR-CA-2.2 | Customer display shows: `Amount Due + Fee = Total Signed`. Blocks hardware PIN entry until customer taps "Agree". | MVP |
| FR-CA-2.3 | Agent display shows `Estimated Commission` based on their Tier (Micro, Standard, Premier). NEVER shown on customer display. | MVP |

### FR-CA-3: Transaction Proof & Authentication Handshakes

| ID | Requirement | Phase |
|----|-------------|-------|
| FR-CA-3.1 | **ATM Card Funding:** Enforce EMV Chip + encrypted hardware PIN entry. POS encrypts PIN via DUKPT. App fires `POST /api/v1/withdrawal` or equivalent. Agent NEVER sees customer PIN. | MVP |
| FR-CA-3.2 | **Cash Funding:** Agent clicks "Confirm Cash Received" as physical handshake. MyKad scan required for transactions > RM 3,000 to unmask customer identity for AML. | MVP |
| FR-CA-3.3 | **DuitNow RTP:** App fires request to backend. Backend triggers push notification to customer phone. Terminal polls status until customer approves on their device. | Phase 2 |
| FR-CA-3.4 | **DuitNow Proxy Types:** App must support all three proxy types: Mobile Number, MyKad Number, and Business Registration Number (BRN). | Phase 2 |
| FR-CA-3.5 | SMS Receipt: Backend fires SMS to customer mobile on success (non-repudiation). Channel app does not send SMS directly. | MVP |

### FR-CA-4: Service Orchestration & Validations

| ID | Requirement | Phase |
|----|-------------|-------|
| FR-CA-4.1 | **JomPAY & Bills:** Enforce `Ref-1` validation formatting and Biller Inquiry pre-check before accepting funds. | Phase 2 |
| FR-CA-4.2 | **Prepaid Top-Up:** Validate phone number format and Telco API pre-check before transaction. | Phase 2 |
| FR-CA-4.3 | **Deposits/Transfers:** Enforce `ProxyEnquiry` displaying masked recipient name (e.g., `MOHD A***D BIN AL*`) for customer verbal or digital confirmation. | MVP |
| FR-CA-4.4 | **Withdrawal Limits:** Client-side pre-check enforces RM 5,000 per-transaction limit (configurable). Graceful block with message before API call. | MVP |
| FR-CA-4.5 | **STP Hard Cap Pre-Check:** Client-side guards: max RM 3,000 per STP transaction, max 5 transactions/hour per customer. | MVP |
| FR-CA-4.6 | **Specific Integrations:** Dynamic forms for eSSP, Sarawak Pay, PIN Purchases that conform to external provider API validations. | Phase 2 |
| FR-CA-4.7 | **Card-Funded Service Flow:** For any service funded via ATM Card (bill payments, top-ups, deposits, eSSP, Sarawak Pay, PIN Purchase-Card), the app MUST enforce EMV Chip insert + encrypted hardware PIN entry (DUKPT) before submitting to the backend. The card funding handshake happens AFTER service-specific validation (Ref-1 / phone check). | Phase 2 |
| FR-CA-4.8 | **Cash-Funded Service Flow:** For any service funded via physical cash (bill payments, top-ups, eSSP, Sarawak Pay), the agent MUST click "Confirm Cash Collected" as proof of physical handshake before the financial API call fires. MyKad scan required if total cash collected > RM 3,000. | Phase 2 |
| FR-CA-4.9 | **JomPAY ON-US Routing:** When `billerRouting = ON_US` (returned by Biller Inquiry), the app sends the payment to the internal direct-debit endpoint. This avoids the external PayNet switch round-trip and settles faster with a distinct transaction type code. | Phase 2 |

### FR-CA-5: Conditional STP (e-KYC & Account Opening)

| ID | Requirement | Phase |
|----|-------------|-------|
| FR-CA-5.1 | App reads physical MyKad via hardware Smart Card/NFC reader. OCR/Chip-read extracts Name, IC, Address. | MVP |
| FR-CA-5.2 | Biometric Verification via Match-on-Card thumbprint on POS biometric peripheral. | MVP |
| FR-CA-5.3 | If thumbprint fails, app launches device camera for Face Liveness video capture ("Please Blink Twice"). | MVP |
| FR-CA-5.4 | Payload (OCR data + liveness blob + GPS) sent to `POST /api/v1/kyc/verify` for 3rd-party scoring and AML screening. | MVP |
| FR-CA-5.5 | If status `AUTO_APPROVED`: app routes agent to collect initial cash deposit and triggers Account Provision endpoint. | MVP |
| FR-CA-5.6 | If status `MANUAL_REVIEW`: app stops the workflow and informs customer their application is queued for analyst review. | MVP |

### FR-CA-6: Anti-Smurfing & Compliance Freezes

| ID | Requirement | Phase |
|----|-------------|-------|
| FR-CA-6.1 | If backend returns `ERR_BIZ_COMPLIANCE_FREEZE` due to velocity breaches (structuring), app enters `LOCKED` state locally. | Phase 2 |
| FR-CA-6.2 | `LOCKED` terminals: all financial services disabled and grayed out. Red banner permanently displayed: "COMPLIANCE REVIEW — Contact Support". | Phase 2 |
| FR-CA-6.3 | `LOCKED` state persists across app reboots via encrypted local storage until backend sends an Unlock webhook. | Phase 2 |
| FR-CA-6.4 | On receipt of backend Unlock webhook signal, app clears the `LOCKED` flag and resumes STP flows without requiring a manual restart. | Phase 2 |

### FR-CA-7: Store & Forward (Offline Queuing & Reversals)

| ID | Requirement | Phase |
|----|-------------|-------|
| FR-CA-7.1 | STP transaction timeouts do NOT manually adjust Agent Float locally; app defers entirely to backend ledger source of truth. | MVP |
| FR-CA-7.2 | **Zero Retry on Financial Auth:** Authorization requests use ZERO retries at the app level; timeout triggers immediate reversal queuing. | MVP |
| FR-CA-7.3 | **Reversal Rule:** If POS hardware fails mid-transaction (printer jam) OR network drops *immediately after* receiving HTTP 200 success, app automatically queues an `MTI 0400 Reversal` with the original `X-Idempotency-Key`. | MVP |
| FR-CA-7.4 | System re-transmits queued reversals every **60 seconds** using AES-256 encrypted SQLite (SQLCipher) and the `X-Idempotency-Key` until HTTP 200 confirmation. | MVP |
| FR-CA-7.5 | Non-financial requests (echo, inquiry) use exponential backoff retry (1s, 2s, 4s, max 3 retries). | MVP |

### FR-CA-8: EOD Settlement & Reconciliation (UI)

| ID | Requirement | Phase |
|----|-------------|-------|
| FR-CA-8.1 | Channel app displays agent's running net summary: Total Withdrawals, Total Deposits, Total Commissions, and Estimated Net Settlement direction. | Phase 2 |
| FR-CA-8.2 | At **23:55 MYT**: app displays warning banner — "End of Day Settlement initiates in 5 minutes. Please wrap up." | Phase 2 |
| FR-CA-8.3 | At **23:59:59 MYT**: all STP financial workflows are disabled. App shows a settlement-in-progress state. | Phase 2 |
| FR-CA-8.4 | When backend signals settlement finalization (expected by 02:00 AM), app displays settlement confirmation and enables the new business day. | Phase 2 |

### FR-CA-9: Merchant Services (Phase 2)

| ID | Requirement | Phase |
|----|-------------|-------|
| FR-CA-9.1 | **Retail Sale (RETAIL_SALE):** Agent enters "Merchant Mode" to accept card or DuitNow QR payments for goods. Backend credits agent float minus MDR. Receipt type: Sales Receipt. | Phase 2 |
| FR-CA-9.2 | **PIN Voucher Purchase (PIN_PURCHASE):** Agent sells digital voucher; system debits agent float; terminal prints slip with 16-digit PIN code. Receipt type: PIN Slip. | Phase 2 |
| FR-CA-9.3 | **Cash-Back Hybrid (CASHBACK_HYBRID):** Single card swipe covers product purchase + cash withdrawal. System performs split accounting automatically. | Phase 2 |
| FR-CA-9.4 | App displays MDR rate to agent before completing a Retail Sale (e.g., "MDR: 1.0% = RM 1.00 deducted from float credit"). | Phase 2 |
| FR-CA-9.5 | App displays commission earned for PIN Purchase (same as standard commission flow). | Phase 2 |

### FR-CA-10: Agent Self-Onboarding (Phase 2)

| ID | Requirement | Phase |
|----|-------------|-------|
| FR-CA-10.1 | Prospective Micro-Agent enters a self-onboarding flow on the POS app: MyKad OCR → Liveness video → SSM number entry. | Phase 2 |
| FR-CA-10.2 | App sends payload to `POST /api/v1/kyc/agent-onboard`. Backend concurrently checks: JPN identity, SSM business status, AML watchlists. | Phase 2 |
| FR-CA-10.3 | If all checks pass: app shows "Agent ID Activated" with Float Ledger created. No bank officer required (Micro-Agent STP). | Phase 2 |
| FR-CA-10.4 | If any check fails (AML flag, SSM inactive, partial liveness): app informs applicant their request is routed to manual review; a bank officer will contact them. | Phase 2 |

---

## 6. Entity Definitions
*(Channel App local state — not persisted to backend DB)*

### ENT-CA-1: Agent Float Ledger State

| Field | Type | Description |
|-------|------|-------------|
| balance | BigDecimal | Total pre-funded amount (MYR) |
| reservedBalance | BigDecimal | Funds locked in pending transaction |
| availableBalance | BigDecimal | `balance - reservedBalance` |
| tierLevel | Enum | MICRO, STANDARD, PREMIER |
| isLocked | Boolean | `true` upon compliance freeze |
| awaitingUnlock | Boolean | `true` once unlock webhook received, pending confirmation |

### ENT-CA-2: Transaction Local Context

| Field | Type | Description |
|-------|------|-------------|
| txId | UUID | Same as `X-Idempotency-Key` sent in headers |
| transactionType | Enum | CASH_WITHDRAWAL, CASH_DEPOSIT, RETAIL_SALE, PIN_PURCHASE, CASHBACK_HYBRID, BILL_PAYMENT, DUITNOW_TRANSFER, BALANCE_INQUIRY, TOPUP, ESSP, EWALLET_TOPUP, EWALLET_WITHDRAW, ... |
| customerFee | BigDecimal | Pulled from Parameter Engine (`/quote`) |
| agentCommission | BigDecimal | Agent's cut (shown on agent display only) |
| needsReversal | Boolean | `true` if terminal failed to verify final state |
| fundingSource | Enum | CARD_EMV, CASH, DUITNOW_MOBILE, DUITNOW_MYKAD, DUITNOW_BRN, MYKAD_BIOMETRIC |
| billerRouting | Enum | ON_US, OFF_US (for JomPAY only) |

### ENT-CA-3: Merchant Transaction Context

| Field | Type | Description |
|-------|------|-------------|
| merchantType | Enum | RETAIL_SALE, PIN_PURCHASE, CASHBACK_HYBRID |
| mdrRate | BigDecimal | MDR rate applied (for RETAIL_SALE, e.g., 0.0100) |
| mdrAmount | BigDecimal | MDR amount deducted from float credit |
| productDescription | String | Description of goods/PIN voucher sold |
| cashBackAmount | BigDecimal | Cash portion for CASHBACK_HYBRID |
| purchaseAmount | BigDecimal | Goods portion for CASHBACK_HYBRID |

---

## 7. Non-Functional Requirements & Security

### NFR-CA-1: Performance
- All STP API pre-flight checks (ProxyEnquiry, Pricing Quote) must execute under ≤ 2 seconds.
- Geofence check is local and must complete under ≤ 100ms.

### NFR-CA-2: Security
- **Zero PII Data:** No full PANs, PINs, MyKads, or raw biometric blobs stored locally or printed on receipts.
- **Hardware Abstraction:** All card readers and PIN pads interact via `MethodChannels`/`PlatformChannels`. App MUST NOT capture PINs via virtual keyboards.
- **TLS 1.2+:** All `dio` client traffic. SHA-256 certificate hash pinning enforced.
- **Display Obfuscation:** `WindowManager.LayoutParams.FLAG_SECURE` prevents OS-level screenshots.
- **Encrypted Local DB:** SQLCipher AES-256 for Store & Forward queue; key in Android Keystore via `flutter_secure_storage`.
- **Zero PII Logging:** Custom Logger redacts 16-digit PANs and 12-digit MyKads via regex before any log write.

### NFR-CA-3: Error Code Alignment (Platform Taxonomy)

| Platform Code Pattern | Channel Usage Example |
|----------------------|-----------------------|
| `ERR_AUTH_xxx` | `ERR_AUTH_TOKEN_EXPIRED`, `ERR_AUTH_DEVICE_NOT_WHITELISTED` |
| `ERR_VAL_xxx` | `ERR_VAL_GPS_UNAVAILABLE`, `ERR_VAL_GEOFENCE_BREACH`, `ERR_VAL_AMOUNT_EXCEEDS_LIMIT` |
| `ERR_BIZ_xxx` | `ERR_BIZ_COMPLIANCE_FREEZE`, `ERR_BIZ_INSUFFICIENT_FLOAT`, `ERR_BIZ_LIMIT_EXCEEDED` |
| `ERR_EXT_xxx` | `ERR_EXT_SWITCH_DECLINED`, `ERR_EXT_KYC_SERVICE_UNAVAILABLE`, `ERR_EXT_BILLER_UNAVAILABLE` |
| `ERR_SYS_xxx` | `ERR_SYS_INTERNAL`, `ERR_SYS_SERVICE_UNAVAILABLE` |

> **Legacy code migration:** `ERR_COMPLIANCE_FREEZE` → `ERR_BIZ_COMPLIANCE_FREEZE`. `ERR_GPS_UNAVAILABLE` → `ERR_VAL_GPS_UNAVAILABLE`.

### NFR-CA-4: Compliance
- Geofencing enforced pre-every transaction; `X-GPS-Latitude` / `X-GPS-Longitude` headers sent on all API calls.
- All float changes deferred to backend; channel app NEVER self-adjusts float without backend confirmation.

---

## 8. Traceability Matrix: User Stories → Functional Requirements

| User Story | Description | Functional Requirements | Phase |
|-----------|-------------|------------------------|-------|
| US-CA-01 | Agent Auth & Session | FR-CA-1.1, FR-CA-1.3 | MVP |
| US-CA-02 | Geofence | FR-CA-1.2 | MVP |
| US-CA-03 | Cash Withdrawal — ATM Card | FR-CA-3.1, FR-CA-4.4, FR-CA-4.5 | MVP |
| US-CA-04 | Cash Deposit — Physical Cash handshake | FR-CA-3.2 | MVP |
| US-CA-05 | DuitNow Fund Transfer | FR-CA-3.3, FR-CA-3.4 | Phase 2 |
| US-CA-06 | Pricing & Commission Display | FR-CA-2.1, FR-CA-2.2, FR-CA-2.3 | MVP |
| US-CA-07 | JomPAY OFF-US — Cash | FR-CA-4.1, FR-CA-4.8 | Phase 2 |
| US-CA-08 | Prepaid CELCOM — Cash | FR-CA-4.2, FR-CA-4.8 | Phase 2 |
| US-CA-11 | Cash Deposit — ProxyEnquiry | FR-CA-4.3 | MVP |
| US-CA-12 | e-KYC MyKad OCR + Biometric | FR-CA-5.1, FR-CA-5.2 | MVP |
| US-CA-13 | e-KYC Face AI Fallback | FR-CA-5.3, FR-CA-5.4 | MVP |
| US-CA-14 | Account Provisioning | FR-CA-5.5, FR-CA-5.6 | MVP |
| US-CA-15 | Store & Forward Auto-Reversal | FR-CA-7.1, FR-CA-7.2, FR-CA-7.3, FR-CA-7.4 | MVP |
| US-CA-16 | Compliance Freeze | FR-CA-6.1, FR-CA-6.2, FR-CA-6.3 | Phase 2 |
| US-CA-17 | Retail Sale (Merchant) | FR-CA-9.1, FR-CA-9.4 | Phase 2 |
| US-CA-18 | PIN Purchase — Cash | FR-CA-9.2, FR-CA-9.5 | Phase 2 |
| US-CA-19 | Cash-Back Hybrid | FR-CA-9.3 | Phase 2 |
| US-CA-20 | Agent Self-Onboarding | FR-CA-10.1, FR-CA-10.2, FR-CA-10.3, FR-CA-10.4 | Phase 2 |
| US-CA-21 | Compliance Unlock Webhook | FR-CA-6.4 | Phase 2 |
| US-CA-22 | EOD Settlement UI | FR-CA-8.1, FR-CA-8.2, FR-CA-8.3, FR-CA-8.4 | Phase 2 |
| US-CA-23 | Balance Inquiry — ATM Card | FR-CA-3.1, FR-CA-4.5 | MVP |
| US-CA-24 | Cash Withdrawal — MyKad Biometric | FR-CA-5.2, FR-CA-4.5 | Phase 2 |
| US-CA-25 | Cash Deposit — Card Funded | FR-CA-3.1, FR-CA-4.3, FR-CA-4.7 | Phase 2 |
| US-CA-26 | JomPAY OFF-US — Card | FR-CA-4.1, FR-CA-4.7 | Phase 2 |
| US-CA-27 | JomPAY ON-US — Cash | FR-CA-4.1, FR-CA-4.8, FR-CA-4.9 | Phase 2 |
| US-CA-28 | JomPAY ON-US — Card | FR-CA-4.1, FR-CA-4.7, FR-CA-4.9 | Phase 2 |
| US-CA-29 | ASTRO RPN — Cash | FR-CA-4.1, FR-CA-4.8 | Phase 2 |
| US-CA-30 | ASTRO RPN — Card | FR-CA-4.1, FR-CA-4.7 | Phase 2 |
| US-CA-31 | TM RPN — Cash | FR-CA-4.1, FR-CA-4.8 | Phase 2 |
| US-CA-32 | TM RPN — Card | FR-CA-4.1, FR-CA-4.7 | Phase 2 |
| US-CA-33 | EPF Contribution — Cash | FR-CA-4.1, FR-CA-4.8 | Phase 2 |
| US-CA-34 | EPF Contribution — Card | FR-CA-4.1, FR-CA-4.7 | Phase 2 |
| US-CA-35 | Prepaid CELCOM — Card | FR-CA-4.2, FR-CA-4.7 | Phase 2 |
| US-CA-36 | Prepaid M1 — Cash | FR-CA-4.2, FR-CA-4.8 | Phase 2 |
| US-CA-37 | Prepaid M1 — Card | FR-CA-4.2, FR-CA-4.7 | Phase 2 |
| US-CA-38 | Sarawak Pay Withdrawal — Cash | FR-CA-4.6, FR-CA-4.8 | Phase 2 |
| US-CA-39 | Sarawak Pay Withdrawal — Card | FR-CA-4.6, FR-CA-4.7 | Phase 2 |
| US-CA-40 | Sarawak Pay TOP-UP — Cash | FR-CA-4.6, FR-CA-4.8 | Phase 2 |
| US-CA-41 | Sarawak Pay TOP-UP — Card | FR-CA-4.6, FR-CA-4.7 | Phase 2 |
| US-CA-42 | eSSP Purchase — Cash | FR-CA-4.6, FR-CA-4.8 | Phase 2 |
| US-CA-43 | eSSP Purchase — Card | FR-CA-4.6, FR-CA-4.7 | Phase 2 |
| US-CA-44 | PIN Purchase — Card | FR-CA-9.2, FR-CA-4.7 | Phase 2 |

---
**End of Document**
