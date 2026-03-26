# Business Requirements Document (BRD)
## Agent Banking Channel App

**Version:** 2.0  
**Date:** 2026-03-25  
**Status:** Draft — Pending Final Review  
**Module:** Channel App (com.banking.channel)  

---

## 1. Project Overview & Goals

### Project Name
Agent Banking Channel App for POS Terminal, Mobile, Tablet

### Business Purpose
Provide third-party agents (retail merchants) with a secure, STP-compliant mobile/POS application to provide 31 distinct essential banking services. The app legally substitutes human judgment with cryptographic proof to operate safely under BNM guidelines, relying strictly on Agent Pre-Funded Floats to eliminate bank credit risk.

### STP Strategy (Straight-Through Processing Categories)
The system divides its rules into three distinct processing categories:
*   **Category 1 (100% STP):** Core automated transactions (Cash-In, Cash-Out, Bill Payments, Transations < RM5,000) using strict hardware/digital Dual-Handshakes.
*   **Category 2 (Conditional STP):** Risk-based engines (e-KYC, Account Opening) using Match-on-Card biometrics, OCR, Face AI Fallback, and real-time AML background checks.
*   **Category 3 (Strictly Non-STP):** For compliance velocity breaches (Smurfing), system falls back to Maker-Checker queues and triggers Terminal freezes.

### Full Implementation Scope
*   **General Services:** Balance Inquiry, Cash Withdrawal (ATM Card / MyKad), Cash Deposit (Cash/Card Funding), Opening Account (MyKad, New/Existing), DuitNow Fund Transfers.
*   **Payments & Reloads:** Bill Payments (ASTRO, TM, EPF i-SARAAN/i-SURI), JomPAY (On-Us/Off-Us), Prepaid Top-Up (CELCOM, M1), Cashless Payment.
*   **Special Services:** eSSP Purchase, PIN Purchase.
*   **e-Wallet Integration:** Sarawak Pay e-Wallet (Withdrawal / Top-Up).

### Backend / API Dependencies (Impact on other modules)
While this BRD defines the Channel App, it strictly relies on the Backend Platform to expose endpoints for:
1.  **AI Integration:** Proxy endpoints (e.g., `/api/v1/kyc/verify`) to route payload to Innov8tif/Jumio for Face AI extraction and liveness scoring.
2.  **Fee Engine:** Endpoint (`/api/v1/transactions/quote`) to fetch `customerFee` and `agentCommission` based on Agent Tier prior to execution.
3.  **Compliance:** Rules engine that tracks velocity and returns `action_code: ERR_COMPLIANCE_FREEZE` if anti-smurfing thresholds are breached.

---

## 2. User Roles & Stories

### Roles
| Role | Responsibilities |
|------|------------------|
| **Agent** | Operates POS terminal, handles cash physically, scans IDs, drives UI. Never sees customer PINs. |
| **Customer** | Presents Funding Source (Card/Cash/DuitNow), confirms amounts, enters PIN safely on terminal. |
| **Bank Operations** | Configure agents, maker-checker exception tracking (uses backoffice web, not channel app). |

### Core Agent & Customer Stories

**Auth, Hardware & Setup**
*   **US-CA-01**: As an agent, I want to authenticate via Biometric/OTP so I can start a session and see my pre-funded Float balance.
*   **US-CA-02**: As an agent, the app must continuously verify I am within a 100m GPS radius of my shop; otherwise, it must block STP transactions.

**STP Dual Handshake & Funding**
*   **US-CA-03**: As a customer paying with an **ATM Card**, I want to insert my EMV chip, enter my PIN on the hardware pad, and see the amount deducted instantly.
*   **US-CA-04**: As a customer using **Physical Cash**, I want the agent to scan my MyKad (for AML/Limit tracking) before taking my cash, while I confirm my name on the display.
*   **US-CA-05**: As a customer requesting a **Digital Fund Transfer (DuitNow)**, I want to give my proxy ID to the agent, receive a Push Notification on my phone, and authenticate the transfer there.

**Parametric Pricing & Commissions**
*   **US-CA-06**: As an agent, before confirming any transaction, I want the UI to display my calculated **Commission Earned**, while the customer display asks for consent to the **Transaction Fee**.

**Financial Services (The 31 Functions)**
*   **US-CA-07**: As an agent, I want to process **Bill Payments** (ASTRO, TM, EPF) by capturing the Ref-1 number and validating it against the biller API before accepting funds (Card/Cash).
*   **US-CA-08**: As an agent, I want to process **Prepaid Top-ups** (Celcom, M1) by validating the phone number first.
*   **US-CA-09**: As an agent, I want to facilitate **Sarawak Pay e-Wallet** top-ups and cash withdrawals.
*   **US-CA-10**: As an agent, I want to sell **eSSP certificates** and Government **PINs**.
*   **US-CA-11**: As an agent processing a **Cash Deposit** (Cash-In), I must perform a `ProxyEnquiry` and show the recipient's masked name to the customer before accepting funds.

**Conditional STP & Onboarding**
*   **US-CA-12**: As an agent opening an account, I tap the MyKad to run an OCR/Chip read and ask the customer to place their thumb on the POS biometric scanner.
*   **US-CA-13**: If the thumbprint match fails, I want the app to trigger a **Face AI Fallback** (video selfie) and instantly send it with my GPS location for AML watchlist screening.
*   **US-CA-14**: If e-KYC returns `AUTO_APPROVED`, I want the app to instantly step into collecting the initial deposit and provisioning the account.

**Edge Cases & Safeguards**
*   **US-CA-15**: If the terminal printer jams or the POS network drops *after* the switch approval, I want the app to queue an automated **MTI 0400 Reversal** (Store & Forward) to safely return the customer's funds.
*   **US-CA-16**: If the backend detects structuring (Anti-Smurfing), I want my terminal to transition into a **Compliance Lock** state, directing me to call Support.

---

## 3. Functional Requirements

### FR-CA-1: Security & Geofencing
| ID | Requirement |
|----|-------------|
| FR-CA-1.1 | Device binding: Sessions are bound via MAC Address/Android ID whitelists. |
| FR-CA-1.2 | Geofence: Block transactions outside 100m radius of registered lat/lng. Send `X-GPS-Lat`/`Long` headers on all API calls. |
| FR-CA-1.3 | Session Timeout: Secure JWT token auto-expires after 8 hours or 2 hours inactivity. |

### FR-CA-2: The Parameter & Pricing Engine
| ID | Requirement |
|----|-------------|
| FR-CA-2.1 | After input validation but *before* the financial handshake, app shall call `/api/v1/transactions/quote`. |
| FR-CA-2.2 | The customer display shall show: `Amount Due + Fee = Total Signed`. |
| FR-CA-2.3 | The Agent display shall show their `Estimated Commission` based on their Tier (Micro, Premier, etc.). |

### FR-CA-3: Transaction Proof & Authentication Handshakes
| ID | Requirement |
|----|-------------|
| FR-CA-3.1 | **ATM Card Funding:** Must enforce EMV Chip + Encrypted Hardware PIN entry. POS encrypts PIN immediately (DUKPT). |
| FR-CA-3.2 | **Cash Funding:** Agent acts as validator. App requires agent to click "Confirm Cash Received". Requires customer MyKad read for transactions > RM 3000 to unmask the identity. |
| FR-CA-3.3 | **Digital (DuitNow RTP):** App fires request to backend, which triggers a push notification to customer phone. Agent terminal polls status until customer approves on their own device. |
| FR-CA-3.4 | SMS Receipt Trigger: Backend fires SMS to customer mobile upon success (Non-repudiation proof). |

### FR-CA-4: Service Orchestration & Validations
| ID | Requirement |
|----|-------------|
| FR-CA-4.1 | **JomPAY & Bills:** Enforce `Ref-1` validation formatting and Biller Inquiry pre-check. |
| FR-CA-4.2 | **Prepaid Top-Up:** Validate phone number formatting and Telco API pre-check. |
| FR-CA-4.3 | **Deposits/Transfers:** Enforce `ProxyEnquiry` (Name Inquiry) displaying masked recipient name for verification. |
| FR-CA-4.4 | **Withdrawals:** Max threshold enforced locally ($\le$ RM 5,000 based on config). Over-limit transactions gracefully blocked. |
| FR-CA-4.5 | **Specific Integrations:** App provides dynamic forms for eSSP, Sarawak Pay, PIN Purchases that conform to external provider API validations. |

### FR-CA-5: Conditional STP (e-KYC & Onboarding)
| ID | Requirement |
|----|-------------|
| FR-CA-5.1 | App accesses physical MyKad using hardware Smart Card / NFC reader. Local OCR/Chip-read extracts Name, IC, Address. |
| FR-CA-5.2 | Biometric Verification occurs via Match-on-Card thumbprint. |
| FR-CA-5.3 | If thumbprint fails, app automatically launches device camera for Face Liveness Video capture (Face AI Fallback). |
| FR-CA-5.4 | Payload (OCR data + Liveness blob) sent to backend endpoint (`/api/v1/kyc/verify`) for 3rd-party scoring and local AML screening. |
| FR-CA-5.5 | If status is `AUTO_APPROVED`, app routes agent to collect initial cash deposit and triggers Account Provision endpoint. |
| FR-CA-5.6 | If status is `MANUAL_REVIEW`, app stops the workflow and informs the customer their application is queued. |

### FR-CA-6: Anti-Smurfing & Compliance Freezes
| ID | Requirement |
|----|-------------|
| FR-CA-6.1 | If backend returns `ERR_COMPLIANCE_FREEZE` due to velocity breaches (structuring), app enters `LOCKED` state locally. |
| FR-CA-6.2 | `LOCKED` terminals cannot process STP; UI forces a "Contact Compliance Officer" dial prompt. |

### FR-CA-7: Store & Forward (Offline Queuing & Reversals)
| ID | Requirement |
|----|-------------|
| FR-CA-7.1 | Regular STP transactions gracefully timeout without locking the float locally, reverting to the backend's source of truth. |
| FR-CA-7.2 | **Reversal Rule:** If POS hardware fails mid-transaction (e.g. Printer Out of Paper) OR network drops *immediately after* receiving success, the app automatically generates an MTI 0400 Reversal request dynamically and puts it in the offline queue to instantly protect the customer float. |
| FR-CA-7.3 | System securely re-transmits queued reversals every 30s using encrypted SQLite caching and the `X-Idempotency-Key`. |

### FR-CA-8: EOD Settlement & Reconciliation
| ID | Requirement |
|----|-------------|
| FR-CA-8.1 | Agents are settled "Net" (Total Deposits - Total Withdrawals + Total Commissions). |
| FR-CA-8.2 | Terminal enforces local UX Cut-off limits aligned with the backend's 23:59:59 MYT settlement batch limits. At 23:55 MYT, app displays a warning to Agents. |

---

## 4. Entity Definitions
*(Selected Channel App local state elements)*

### ENT-CA-1: Agent Float Ledger State
| Field | Type | Description |
|-------|------|-------------|
| balance | BigDecimal | Total pre-funded amount |
| reserved | BigDecimal | Funds locked in pending transaction |
| tierLevel | String | Tier (MICRO, STANDARD, PREMIER) drives velocity |
| isLocked | Boolean | Set to true upon compliance freeze |

### ENT-CA-2: Transaction Local Context
| Field | Type | Description |
|-------|------|-------------|
| txId | UUID | Same as `X-Idempotency-Key` sent in headers |
| customerFee | BigDecimal | Pulled from Parameter Engine beforehand |
| agentCommission | BigDecimal | Calculated cut for the agent |
| needsReversal | Boolean | True if terminal failed to verify final state |

---

## 5. Non-Functional Requirements & Security
*   **Zero PII Data:** No full PANs, PINs, MyKads, or raw biometric blobs are stored locally or printed on receipts.
*   **Hardware Abstraction:** All card readers and PIN pads interact via `MethodChannels`/`PlatformChannels`. Apps must not direct-capture PINs via virtual keyboards.
*   **Payload Encryption:** TLS 1.2+ Required. JSON payloads are hashed via HMAC to prevent Man-in-the-Middle token injections.
*   **Performance:** All STP API pre-flight checks (ProxyEnquiry, Pricing) must execute under $\le$ 2 seconds.

---
**End of Document**
