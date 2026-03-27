# BDD Specification: Agent Banking Channel App

**Version:** 3.0  
**Date:** 2026-03-27  
**Status:** Revised — Aligned with Platform BRD v1.1 & Supplementary Docs  
**Module:** Channel App (Flutter POS Terminal)  
**Supersedes:** `2026-03-25-agent-banking-channel-bdd.md`  
**BRD Reference:** `docs/superpowers/specs/agent-banking-channel/2026-03-27-agent-banking-channel-brd.md`

Each BDD scenario is tagged with exactly one `@US` (User Story) and one or more `@FR` (Functional Requirement) for atomic traceability. Each scenario also carries a `@Phase` tag (`@MVP` or `@Phase2`).

---

## 1. Agent Authentication & Session Management

```gherkin
Feature: Agent Authentication and Session

  @US-CA-01 @FR-CA-1.1 @MVP
  Scenario: Agent logs in with valid biometric
    Given the channel app is launched on a whitelisted device
    When the agent authenticates using fingerprint biometrics
    Then a JWT session is created and stored securely
    And the agent is navigated to the home screen
    And the UI displays the agent's pre-funded Float Ledger balance

  @US-CA-01 @FR-CA-1.1 @MVP
  Scenario: Device not whitelisted is rejected on login
    Given the agent's device MAC Address is not whitelisted in the backend
    When the agent attempts to log in
    Then the login is rejected with error code "ERR_AUTH_DEVICE_NOT_WHITELISTED"
    And the session is not created

  @US-CA-01 @FR-CA-1.3 @MVP
  Scenario: Session expires during idle — non-blocking re-auth
    Given the agent is logged in with an active session
    When 2 hours of inactivity has elapsed
    Then the app shows a non-blocking "Session expired" dialog
    And allows the agent to re-authenticate without losing transaction context

  @US-CA-01 @FR-CA-1.3 @MVP
  Scenario: Session expires mid-transaction
    Given the agent is in the middle of a pricing quote workflow
    When the system detects an expired JWT token
    Then the app shows a non-blocking "Session expired — please re-authenticate" overlay
    And resumes the transaction flow after successful re-authentication

  @US-CA-01 @FR-CA-1.3 @MVP
  Scenario: Secure logout clears all sensitive data
    Given the agent is logged in with an active session
    When the agent logs out
    Then the JWT token is deleted from secure storage
    And all session state is cleared
    And the app returns to the login screen
```

---

## 2. Geofence Enforcement

```gherkin
Feature: Geofence Enforcement

  @US-CA-02 @FR-CA-1.2 @MVP
  Scenario: Transaction allowed within 100m geofence
    Given the agent's registered location is at (3.1390, 101.6869)
    And the device GPS shows (3.1395, 101.6872)
    When the agent attempts to initiate any STP transaction
    Then the geofence check passes (distance < 100m)
    And the transaction proceeds to the Dual-Handshake workflow

  @US-CA-02 @FR-CA-1.2 @MVP
  Scenario: Transaction blocked outside 100m geofence
    Given the agent's registered location is at (3.1390, 101.6869)
    And the device GPS shows (3.1500, 101.7000)
    When the agent attempts to initiate a transaction
    Then the geofence check fails
    And the app displays error "ERR_VAL_GEOFENCE_BREACH"
    And the transaction is instantly blocked

  @US-CA-02 @FR-CA-1.2 @MVP
  Scenario: GPS coordinates sent in all API request headers
    Given the agent is within geofence
    When any transaction request is sent to the backend
    Then the request contains headers:
      | X-GPS-Latitude  | Decimal(9,6) |
      | X-GPS-Longitude | Decimal(9,6) |

  @US-CA-02 @FR-CA-1.2 @MVP
  Scenario: GPS unavailable blocks transaction
    Given the device GPS is unavailable (hardware off or denied permission)
    When the agent attempts to initiate a transaction
    Then the app displays "ERR_VAL_GPS_UNAVAILABLE"
    And all STP transactions are blocked until GPS is restored
```

---

## 3. Parameter & Pricing Engine (Fees & Commissions)

```gherkin
Feature: Parameter Engine

  @US-CA-06 @FR-CA-2.1 @MVP
  Scenario: Transaction initiates fee engine quote API call
    Given the agent has entered all required transaction inputs
    When the agent taps "Proceed"
    Then the app automatically pauses the workflow
    And calls backend POST /api/v1/transactions/quote
    And displays a loading indicator while awaiting the fee response

  @US-CA-06 @FR-CA-2.2 @MVP
  Scenario: Customer explicitly consents to the transaction fee
    Given the app has retrieved the transaction quote successfully
    When the Dual-Handshake begins
    Then the customer-facing display prominently shows:
      """
      Principal: RM 500.00 | Fee: RM 1.00 | Total Deducted: RM 501.00
      """
    And blocks hardware PIN entry until the customer taps "Agree"

  @US-CA-06 @FR-CA-2.3 @MVP
  Scenario: Agent views commission earned — never shown on customer display
    Given the app has retrieved the transaction quote successfully
    When the Dual-Handshake begins
    Then the agent-facing display shows "Estimated Commission: RM 0.50"
    And this commission value is NEVER shown on the customer-facing display

  @US-CA-06 @FR-CA-2.1 @MVP
  Scenario: STP hard cap pre-check blocks over-limit transaction
    Given a customer requests a transaction of RM 4,000
    When the app performs the client-side STP hard cap pre-check
    Then the app blocks the transaction before calling /quote
    And displays "ERR_VAL_AMOUNT_EXCEEDS_LIMIT: Maximum RM 3,000 per STP transaction"
```

---

## 4. STP Dual-Handshake & Transaction Funding

```gherkin
Feature: Dual-Handshake Payment Execution

  @US-CA-03 @FR-CA-3.1 @MVP
  Scenario: Cash-Out using ATM Card (EMV chip)
    Given the customer agreed to the Principal + Fee amount on their display
    When the customer inserts their EMV card into the hardware reader
    And enters their 6-digit PIN on the encrypted hardware PIN pad
    Then the POS hardware encrypts the PIN block via DUKPT immediately
    And the app fires POST /api/v1/withdrawal
    And the agent NEVER sees or has access to the customer's PIN

  @US-CA-04 @FR-CA-3.2 @MVP
  Scenario: Cash Deposit via Agent Validation (Physical Cash)
    Given the transaction is a Cash Deposit and the destination is verified via ProxyEnquiry
    When the app prompts the agent for physical confirmation
    Then the UI requires the agent to click "Confirm Cash Received"
    And upon clicking, the backend is notified to credit the destination account
    And the customer receives an SMS receipt from the backend notification gateway

  @US-CA-04 @FR-CA-3.2 @MVP
  Scenario: Cash Deposit > RM 3,000 requires MyKad biometric scan
    Given the customer deposits physical cash of RM 3,500
    When the transaction amount exceeds the RM 3,000 STP threshold
    Then the app forces a MyKad biometric scan to unmask customer identity for AML

  @US-CA-05 @FR-CA-3.3 @FR-CA-3.4 @Phase2
  Scenario: DuitNow transfer using Mobile Number proxy
    Given the customer's funding source is DuitNow
    And the customer provides a Mobile Number as their DuitNow proxy
    When the agent submits the transfer request
    Then the backend fires a Push Notification to the customer's Mobile Banking App
    And the terminal enters "Waiting for Customer Approval" polling state
    When the customer approves on their smartphone
    Then the terminal receives confirmation and completes the transaction

  @US-CA-05 @FR-CA-3.3 @FR-CA-3.4 @Phase2
  Scenario: DuitNow transfer using MyKad Number proxy
    Given the customer provides a MyKad Number as their DuitNow proxy
    When the agent submits the transfer request
    Then the backend resolves the proxy to the registered account
    And the Push Notification is fired to the customer's Mobile Banking App

  @US-CA-05 @FR-CA-3.3 @FR-CA-3.4 @Phase2
  Scenario: DuitNow transfer using Business Registration Number (BRN) proxy
    Given the customer provides a BRN as their DuitNow proxy
    When the agent submits the transfer request
    Then the backend resolves the BRN proxy to the registered business account
    And the Push Notification is fired to the account holder's Mobile Banking App
```

---

## 5. Service Orchestration & Validations

```gherkin
Feature: 31 Core Services Orchestration Validation

  @US-CA-11 @FR-CA-4.3 @MVP
  Scenario: Cash Deposit — ProxyEnquiry masked name verification
    Given the agent types a destination account number
    When the app queries the backend ProxyEnquiry
    Then the customer display shows a masked recipient name like "MOHD A***D BIN AL*"
    And the customer must verbally or digitally confirm ownership before funds are collected

  @US-CA-03 @FR-CA-4.4 @MVP
  Scenario: Client-side withdrawal limit pre-check
    Given the customer requests a Cash Withdrawal of RM 6,000
    When the app performs the client-side limit pre-check
    Then the app detects a breach of the RM 5,000 per-transaction hard cap
    And displays "ERR_VAL_AMOUNT_EXCEEDS_LIMIT: Maximum RM 5,000 per transaction"
    And does NOT call the backend API

  @US-CA-07 @FR-CA-4.1 @Phase2
  Scenario: Bill Payment — JomPAY Ref-1 validation
    Given the agent selected the Bill Payment feature
    When the agent keys in the customer's Ref-1 account number
    Then the app executes a Biller Inquiry pre-check against the backend
    And proceeds or blocks the financial handshake based on the real-time API response

  @US-CA-08 @FR-CA-4.2 @Phase2
  Scenario: Prepaid Top-Up — invalid phone number blocked
    Given the agent selected Prepaid RM 50 (CELCOM)
    When the agent keys in an invalid phone number format "019999999X"
    Then the app blocks the financial handshake immediately
    And displays "ERR_VAL_INVALID_PHONE_FORMAT"

  @US-CA-08 @FR-CA-4.2 @Phase2
  Scenario: Prepaid Top-Up — Telco API rejects number
    Given the agent entered a correctly formatted phone number
    When the Telco API pre-check returns a rejection
    Then the app blocks the financial handshake
    And displays "ERR_EXT_BILLER_UNAVAILABLE" or "Number not found"
```

---

## 6. Conditional STP (e-KYC & Account Opening)

```gherkin
Feature: e-KYC Verification and Face AI

  @US-CA-12 @FR-CA-5.1 @MVP
  Scenario: Scan MyKad OCR/Chip
    Given an unregistered customer wants to open an account
    When the agent inserts the MyKad into the Smart Card Reader
    Then the OCR/Chip-read extracts Name, IC Number, and Address

  @US-CA-12 @FR-CA-5.2 @MVP
  Scenario: Happy Path — Biometric Match-on-Card succeeds
    Given the MyKad data is extracted successfully
    When the customer presses their thumb on the Biometric Peripheral
    Then a verified "MATCH" status is returned from the hardware
    And the app proceeds to send the payload to /api/v1/kyc/verify

  @US-CA-13 @FR-CA-5.3 @MVP
  Scenario: Failed thumbprint triggers Face AI Liveness Fallback
    Given the Match-on-Card thumbprint check returns "NO_MATCH" or "FAILED"
    When the app transitions state
    Then the POS frontal camera activates immediately
    And prompts the customer "Please Blink Twice" for Video Liveness capture

  @US-CA-13 @FR-CA-5.4 @MVP
  Scenario: Payload dispatched to KYC endpoint for 3rd-party & AML
    Given the Liveness video blob is captured
    When the app triggers POST /api/v1/kyc/verify with GPS coordinates
    Then the backend routes the media to the configured KYC provider (Innov8tif/Jumio)
    And concurrently runs an AML Sanctions check

  @US-CA-14 @FR-CA-5.5 @MVP
  Scenario: AUTO_APPROVED routes directly to initial deposit collection
    Given the KYC payload returns status "AUTO_APPROVED"
    When the app handles the HTTP 200 OK response
    Then it bypasses the main menu and forces an initial Cash Deposit collection flow
    And provisions the Core Savings Account within the same session

  @US-CA-14 @FR-CA-5.6 @MVP
  Scenario: MANUAL_REVIEW stops workflow and notifies customer
    Given the KYC payload returns status "MANUAL_REVIEW"
    Then the app stops the onboarding workflow
    And informs the customer "Application Queued for Analyst Review. You will be notified via SMS."
```

---

## 7. Anti-Smurfing & Compliance Freezes

```gherkin
Feature: Anti-Smurfing Category 3 Fallbacks

  @US-CA-16 @FR-CA-6.1 @FR-CA-6.2 @Phase2
  Scenario: Velocity breach immediately locks terminal
    Given an agent initiates their 10th Cash Deposit of RM 2,900 within an hour
    When the backend velocity engine detects deliberate structuring (smurfing)
    Then the API rejects the request with error "ERR_BIZ_COMPLIANCE_FREEZE"
    And the app enters a local "LOCKED" state immediately
    And all financial services are disabled and grayed out
    And a red banner reading "COMPLIANCE REVIEW — Dial 1-800-XXX-XXXX for Support" is permanently displayed

  @US-CA-16 @FR-CA-6.2 @FR-CA-6.3 @Phase2
  Scenario: LOCKED state persists across app restarts
    Given the terminal is in the "LOCKED" compliance state
    When the agent closes and re-opens the app
    Then the LOCKED state is restored from encrypted local storage
    And financial services remain disabled

  @US-CA-21 @FR-CA-6.4 @Phase2
  Scenario: Compliance unlock webhook restores STP operations
    Given the terminal is in the "LOCKED" compliance state
    When the backend sends a Compliance Unlock webhook to the app
    Then the app clears the LOCKED flag from encrypted local storage
    And financial services are re-enabled automatically
    And the agent sees "Terminal Unlocked. You may resume operations."
    And no manual app restart is required
```

---

## 8. Store & Forward (Offline Queuing & Reversals)

```gherkin
Feature: Edge Case Automation

  @US-CA-15 @FR-CA-7.1 @FR-CA-7.2 @MVP
  Scenario: ZERO retries on financial authorization — immediate reversal on timeout
    Given a Cash Withdrawal authorization request is sent to the backend
    When the backend does not respond within the timeout threshold (25 seconds)
    Then the app does NOT retry the financial request
    And immediately queues an MTI 0400 Reversal payload with the original X-Idempotency-Key
    And the Agent Float is NOT manually adjusted locally

  @US-CA-15 @FR-CA-7.3 @MVP
  Scenario: Printer jam after HTTP 200 triggers automatic MTI 0400 Reversal
    Given the backend returned HTTP 200 OK for a Cash Withdrawal
    When the physical POS printer detects "Out Of Paper" or "Paper Jam"
    Then the app queues an MTI 0400 Reversal Payload in the encrypted SQLite queue
    And the Agent Float is NOT adjusted locally — defers to backend resolution

  @US-CA-15 @FR-CA-7.4 @MVP
  Scenario: Store & Forward re-transmits reversal every 60 seconds via X-Idempotency-Key
    Given an MTI 0400 Reversal is queued in the encrypted offline store
    When the POS recovers network connectivity
    Then the app continuously retries the reversal every 60 seconds
    And uses the original X-Idempotency-Key to prevent duplicate reversals
    And permanently clears the SQLite cache upon HTTP 200 Reversal confirmation

  @US-CA-15 @FR-CA-7.5 @MVP
  Scenario: Non-financial requests use exponential backoff
    Given a non-financial request (e.g., Balance Inquiry, ProxyEnquiry) fails
    When the app retries the request
    Then it uses exponential backoff: 1s wait, then 2s, then 4s
    And makes a maximum of 3 retry attempts before displaying an error
```

---

## 9. Merchant Services (New — Phase 2)

```gherkin
Feature: Merchant Services (Retail, PIN, Cash-Back)

  @US-CA-17 @FR-CA-9.1 @FR-CA-9.4 @Phase2
  Scenario: Retail Sale — agent accepts card payment as merchant
    Given the agent enters "Merchant Mode" on the POS
    And the customer pays RM 100 for groceries by inserting their card and entering PIN
    When the card authorization succeeds
    Then the backend credits the agent's float with RM 99.00 (RM 100 minus 1% MDR = RM 1.00)
    And the app shows "Float credited: RM 99.00 | MDR: RM 1.00"
    And a Sales Receipt is issued to the customer

  @US-CA-17 @FR-CA-9.1 @Phase2
  Scenario: Retail Sale — agent accepts DuitNow QR payment
    Given the agent is in Merchant Mode
    And the terminal generates a Dynamic QR Code for RM 50
    When the customer scans the QR code with their banking app and confirms payment
    Then PayNet notifies the backend
    And the agent's float is credited with RM 50 minus MDR
    And a Sales Receipt is issued

  @US-CA-18 @FR-CA-9.2 @FR-CA-9.5 @Phase2
  Scenario: PIN Voucher Purchase — agent sells digital voucher for cash
    Given the agent selects "PIN Purchase" and chooses "DIGI RM 10"
    When the customer pays RM 10 physical cash to the agent
    And the agent confirms "Cash Received"
    Then the system debits the agent's float by RM 10
    And the terminal prints a slip with the 16-digit PIN code
    And the agent earns a commission on the sale

  @US-CA-19 @FR-CA-9.3 @Phase2
  Scenario: Cash-Back Hybrid — single card swipe for purchase + cash-back
    Given the customer wants to buy RM 20 of goods AND get RM 50 cash-back
    When the agent swipes the customer's card for RM 70 total
    And the customer enters their PIN
    Then the backend performs split accounting automatically:
      | Purchase Amount | RM 20 credited to merchant sale |
      | Cash-Back Amount| RM 50 to be handed over by agent |
    And the agent's float movement reflects the net position
    And a combined Sales + Cash-Back Receipt is issued
```

---

## 10. Agent Self-Onboarding (New — Phase 2)

```gherkin
Feature: Micro-Agent STP Self-Onboarding

  @US-CA-20 @FR-CA-10.1 @FR-CA-10.2 @FR-CA-10.3 @Phase2
  Scenario: Micro-Agent STP self-onboarding — all checks pass
    Given a prospective Micro-Agent opens the self-onboarding flow on the POS
    When the applicant completes MyKad OCR scan, liveness video, and enters their SSM number
    And the backend fires concurrent checks: JPN identity (PASS), SSM active (PASS), AML (CLEAN)
    Then the app shows "Agent ID Activated. Float account created."
    And no bank officer is required at any step

  @US-CA-20 @FR-CA-10.4 @Phase2
  Scenario: Micro-Agent self-onboarding — AML flag routes to manual review
    Given a prospective Micro-Agent completes the onboarding form
    When the backend AML check returns a potential flag
    Then the app shows "Application queued for review. A bank officer will contact you shortly."
    And the POS returns to the idle screen
```

---

## 11. EOD Settlement UI (New — Phase 2)

```gherkin
Feature: EOD Cut-Off Operations

  @US-CA-22 @FR-CA-8.2 @Phase2
  Scenario: 23:55 MYT warning displayed to agent
    Given the POS terminal local clock reaches 23:55:00 MYT
    When the agent is logged in and active
    Then the app displays a warning banner:
      "End of Day Settlement initiates in 5 minutes. Please wrap up."

  @US-CA-22 @FR-CA-8.3 @Phase2
  Scenario: 23:59:59 MYT — all STP financial workflows disabled
    Given the POS terminal local clock reaches 23:59:59 MYT
    When the agent attempts to initiate any financial transaction
    Then all STP workflows are disabled
    And the UI shows "Settlement in progress... Please wait."

  @US-CA-22 @FR-CA-8.4 @Phase2
  Scenario: Settlement finalization notification re-enables operations
    Given the terminal is in the "Settlement in progress" state
    When the backend signals settlement finalization (expected by 02:00 AM MYT)
    Then the app displays "Settlement complete. New business day has started."
    And all STP financial workflows are re-enabled
```

---

---

## 12. Financial Services — Extended (All 31 Functions)

```gherkin
Feature: All 31 Financial Services by Funding Method

  # ── Balance Inquiry ──────────────────────────────────────

  @US-CA-23 @FR-CA-3.1 @FR-CA-4.5 @MVP
  Scenario: Balance Inquiry using ATM Card
    Given the customer inserts their EMV card
    And enters their PIN on the hardware PIN pad
    When the agent selects "Balance Inquiry" and the app calls POST /api/v1/balance-inquiry
    Then the customer balance is shown on the customer-facing display (masked: "RM ****")
    And no funds are deducted
    And a receipt is printed on request

  # ── Cash Withdrawal — MyKad Biometric ────────────────────

  @US-CA-24 @FR-CA-5.2 @FR-CA-4.5 @Phase2
  Scenario: Cash Withdrawal using MyKad biometric (no ATM card)
    Given the customer does not have their ATM card
    When the customer places their MyKad in the reader and presses thumb on biometric scanner
    And the Match-on-Card returns "MATCH"
    Then the app fires POST /api/v1/withdrawal with fundingSource=MYKAD_BIOMETRIC
    And the agent hands over the requested cash amount

  # ── Cash Deposit — Card Funded ────────────────────────────

  @US-CA-25 @FR-CA-3.1 @FR-CA-4.3 @FR-CA-4.7 @Phase2
  Scenario: Cash Deposit funded by ATM Card
    Given the agent runs ProxyEnquiry and shows masked destination name to customer
    And the customer confirms the destination is correct
    When the customer inserts their ATM card and enters PIN (DUKPT encrypted)
    Then the app fires POST /api/v1/deposit with fundingSource=CARD_EMV
    And the destination account is credited
    And the agent receives an SMS confirmation

  # ── JomPAY OFF-US — Cash ────────────────────────────────

  @US-CA-07 @FR-CA-4.1 @FR-CA-4.8 @Phase2
  Scenario: JomPAY OFF-US bill payment — cash funding
    Given the agent selects JomPAY and enters the biller code and customer Ref-1
    When the Biller Inquiry returns billerRouting=OFF_US and validationStatus=VALID
    Then the agent accepts cash from the customer and clicks "Confirm Cash Collected"
    And the app fires POST /api/v1/bill/pay with fundingSource=CASH, billerRouting=OFF_US
    And a JomPAY payment receipt is printed

  # ── JomPAY OFF-US — Card ────────────────────────────────

  @US-CA-26 @FR-CA-4.1 @FR-CA-4.7 @Phase2
  Scenario: JomPAY OFF-US bill payment — card funding
    Given the agent validates Ref-1 and Biller Inquiry returns billerRouting=OFF_US
    When the customer inserts their ATM card and enters PIN (DUKPT encrypted)
    Then the app fires POST /api/v1/bill/pay with fundingSource=CARD_EMV, billerRouting=OFF_US
    And a JomPAY payment receipt is printed

  # ── JomPAY ON-US — Cash ────────────────────────────────

  @US-CA-27 @FR-CA-4.1 @FR-CA-4.8 @FR-CA-4.9 @Phase2
  Scenario: JomPAY ON-US bill payment — cash funding (internal routing)
    Given the Biller Inquiry returns billerRouting=ON_US
    When the agent accepts cash and clicks "Confirm Cash Collected"
    Then the app fires the payment to the ON-US internal endpoint (skipping PayNet switch)
    And settlement is faster than OFF-US routing
    And a biller receipt is printed

  # ── JomPAY ON-US — Card ────────────────────────────────

  @US-CA-28 @FR-CA-4.1 @FR-CA-4.7 @FR-CA-4.9 @Phase2
  Scenario: JomPAY ON-US bill payment — card funding (internal routing)
    Given the Biller Inquiry returns billerRouting=ON_US
    When the customer inserts ATM card and enters PIN
    Then the app fires the payment to the ON-US internal endpoint
    And a biller receipt is printed

  # ── ASTRO RPN — Cash ────────────────────────────────────

  @US-CA-29 @FR-CA-4.1 @FR-CA-4.8 @Phase2
  Scenario: ASTRO RPN bill payment — cash funding
    Given the agent enters the customer's ASTRO RPN account number
    And the Biller Inquiry confirms the account and outstanding amount
    When the agent accepts cash and clicks "Confirm Cash Collected"
    Then the app fires POST /api/v1/bill/pay (billerCode=ASTRO, fundingSource=CASH)
    And a Biller Receipt with ASTRO acknowledgment number is issued

  # ── ASTRO RPN — Card ────────────────────────────────────

  @US-CA-30 @FR-CA-4.1 @FR-CA-4.7 @Phase2
  Scenario: ASTRO RPN bill payment — card funding
    Given the agent enters the ASTRO RPN account and Biller Inquiry passes
    When the customer inserts their ATM card and enters PIN
    Then the app fires POST /api/v1/bill/pay (billerCode=ASTRO, fundingSource=CARD_EMV)
    And a Biller Receipt is issued

  # ── TM RPN — Cash ────────────────────────────────────────

  @US-CA-31 @FR-CA-4.1 @FR-CA-4.8 @Phase2
  Scenario: TM Unifi bill payment — cash funding
    Given the agent enters the customer's TM account number (Ref-1)
    And the Biller Inquiry confirms validity
    When the agent accepts cash and clicks "Confirm Cash Collected"
    Then the app fires POST /api/v1/bill/pay (billerCode=TM, fundingSource=CASH)
    And a Biller Receipt with TM acknowledgment reference is issued

  # ── TM RPN — Card ────────────────────────────────────────

  @US-CA-32 @FR-CA-4.1 @FR-CA-4.7 @Phase2
  Scenario: TM Unifi bill payment — card funding
    Given the TM Biller Inquiry passes
    When the customer inserts their ATM card and enters PIN
    Then the app fires POST /api/v1/bill/pay (billerCode=TM, fundingSource=CARD_EMV)
    And a Biller Receipt is issued

  # ── EPF Contribution — Cash ──────────────────────────────

  @US-CA-33 @FR-CA-4.1 @FR-CA-4.8 @Phase2
  Scenario: EPF i-SARAAN contribution — cash funding
    Given the agent selects EPF and the customer chooses contribution type (i-SARAAN/i-SURI)
    And the EPF account reference is validated
    When the agent accepts cash and clicks "Confirm Cash Collected"
    Then the app fires POST /api/v1/bill/pay (billerCode=EPF, fundingSource=CASH)
    And an EPF contribution receipt is printed

  # ── EPF Contribution — Card ──────────────────────────────

  @US-CA-34 @FR-CA-4.1 @FR-CA-4.7 @Phase2
  Scenario: EPF i-SARAAN contribution — card funding
    Given the EPF account reference is validated
    When the customer inserts their ATM card and enters PIN
    Then the app fires POST /api/v1/bill/pay (billerCode=EPF, fundingSource=CARD_EMV)
    And an EPF receipt is printed

  # ── Prepaid CELCOM — Card ────────────────────────────────

  @US-CA-35 @FR-CA-4.2 @FR-CA-4.7 @Phase2
  Scenario: CELCOM prepaid top-up — card funding
    Given the agent enters the customer's CELCOM phone number and it is validated
    When the customer inserts their ATM card and enters PIN
    Then the app fires POST /api/v1/topup (telco=CELCOM, fundingSource=CARD_EMV)
    And the top-up is applied instantly to the phone number
    And a Top-Up receipt is printed

  # ── Prepaid M1 — Cash ─────────────────────────────────────

  @US-CA-36 @FR-CA-4.2 @FR-CA-4.8 @Phase2
  Scenario: M1 prepaid top-up — cash funding
    Given the agent enters the customer's M1 phone number and it is validated
    When the agent accepts cash and clicks "Confirm Cash Collected"
    Then the app fires POST /api/v1/topup (telco=M1, fundingSource=CASH)
    And the top-up is applied to the M1 number
    And a Top-Up receipt is printed

  # ── Prepaid M1 — Card ─────────────────────────────────────

  @US-CA-37 @FR-CA-4.2 @FR-CA-4.7 @Phase2
  Scenario: M1 prepaid top-up — card funding
    Given the M1 phone number is validated
    When the customer inserts their ATM card and enters PIN
    Then the app fires POST /api/v1/topup (telco=M1, fundingSource=CARD_EMV)
    And a Top-Up receipt is printed

  # ── Sarawak Pay e-Wallet Withdrawal — Cash ───────────────

  @US-CA-38 @FR-CA-4.6 @FR-CA-4.8 @Phase2
  Scenario: Sarawak Pay e-Wallet withdrawal — agent disburses physical cash
    Given the customer provides their Sarawak Pay account identifier
    And the e-Wallet account is validated and has sufficient balance
    When the customer confirms the withdrawal amount on-screen
    Then the app fires POST /api/v1/ewallet/withdraw (wallet=SARAWAK_PAY, fundingSource=CASH)
    And the agent hands over physical cash from their float
    And the agent's float increases (bank credits agent for cash disbursed)

  # ── Sarawak Pay e-Wallet Withdrawal — Card ───────────────

  @US-CA-39 @FR-CA-4.6 @FR-CA-4.7 @Phase2
  Scenario: Sarawak Pay e-Wallet withdrawal — card authentication
    Given the customer provides their Sarawak Pay account identifier
    When the customer inserts their ATM card and enters PIN to authenticate
    Then the app fires POST /api/v1/ewallet/withdraw (wallet=SARAWAK_PAY, fundingSource=CARD_EMV)
    And the agent hands over physical cash

  # ── Sarawak Pay e-Wallet TOP-UP — Cash ───────────────────

  @US-CA-40 @FR-CA-4.6 @FR-CA-4.8 @Phase2
  Scenario: Sarawak Pay e-Wallet top-up — customer pays cash to agent
    Given the customer provides their Sarawak Pay account identifier
    When the agent accepts cash from the customer and clicks "Confirm Cash Collected"
    Then the app fires POST /api/v1/ewallet/topup (wallet=SARAWAK_PAY, fundingSource=CASH)
    And the agent's float decreases (agent is now holding bank's money)
    And the customer's Sarawak Pay e-Wallet is credited

  # ── Sarawak Pay e-Wallet TOP-UP — Card ───────────────────

  @US-CA-41 @FR-CA-4.6 @FR-CA-4.7 @Phase2
  Scenario: Sarawak Pay e-Wallet top-up — card funding
    Given the customer provides their Sarawak Pay account identifier
    When the customer inserts their ATM card and enters PIN
    Then the app fires POST /api/v1/ewallet/topup (wallet=SARAWAK_PAY, fundingSource=CARD_EMV)
    And the customer's Sarawak Pay e-Wallet is credited

  # ── eSSP Purchase — Cash ─────────────────────────────────

  @US-CA-42 @FR-CA-4.6 @FR-CA-4.8 @Phase2
  Scenario: eSSP certificate purchase — cash funding
    Given the agent selects eSSP and enters the customer's NRIC and eSSP certificate type
    When the customer pays physical cash to the agent
    And the agent clicks "Confirm Cash Collected"
    Then the app fires POST /api/v1/essp/purchase (fundingSource=CASH)
    And a printed eSSP Certificate Slip is issued to the customer
    And the agent's float decreases

  # ── eSSP Purchase — Card ──────────────────────────────────

  @US-CA-43 @FR-CA-4.6 @FR-CA-4.7 @Phase2
  Scenario: eSSP certificate purchase — card funding
    Given the eSSP certificate type and NRIC are entered and validated
    When the customer inserts their ATM card and enters PIN
    Then the app fires POST /api/v1/essp/purchase (fundingSource=CARD_EMV)
    And a printed eSSP Certificate Slip is issued

  # ── PIN Purchase — Card ───────────────────────────────────

  @US-CA-44 @FR-CA-9.2 @FR-CA-4.7 @Phase2
  Scenario: PIN Purchase (digital voucher) — card funding
    Given the agent selects "PIN Purchase" and chooses the voucher type (e.g., Digi RM 10)
    When the customer inserts their ATM card and enters PIN (DUKPT encrypted)
    Then the app fires POST /api/v1/retail/pin-purchase with fundingSource=CARD_EMV
    And the agent's float decreases by RM 10
    And the terminal prints a slip with the 16-digit PIN code
    And the agent earns a commission on the sale

  # ── Card-Funded Services — Generic Validation ────────────

  @US-CA-26 @US-CA-30 @FR-CA-4.7 @Phase2
  Scenario: Card-funded service — DUKPT PIN entry always before API call
    Given any card-funded service (bill, top-up, eSSP, Sarawak Pay, PIN voucher)
    When the service-specific validation (Ref-1 or phone check) has passed
    Then the hardware PIN pad is activated ONLY AFTER validation
    And the app sends the encrypted PIN block via DUKPT in the API request body
    And the agent NEVER has access to the raw PIN

  # ── Cash-Funded Services — Generic Validation ────────────

  @US-CA-07 @US-CA-08 @FR-CA-4.8 @Phase2
  Scenario: Cash-funded service — MyKad required for large cash collections
    Given any cash-funded service where the agent collects > RM 3,000 in cash
    When the Agent clicks "Confirm Cash Collected"
    Then the app interrupts and requires a MyKad scan to record the customer's identity for AML
    And only then submits the API call with the MyKad reference number
```

---

## 13. Traceability Matrix (Updated — All 44 User Stories)

### User Story → BDD Scenario Coverage

| User Story | Description | Feature(s) | Phase |
|-----------|-------------|-----------|-------|
| **US-CA-01** | Auth & Session | Feature 1 | MVP |
| **US-CA-02** | Geofence | Feature 2 | MVP |
| **US-CA-03** | Cash Withdrawal — ATM Card | Feature 4, 5 | MVP |
| **US-CA-04** | Cash Deposit — Physical Cash | Feature 4 | MVP |
| **US-CA-05** | DuitNow Transfer | Feature 4 | Phase 2 |
| **US-CA-06** | Pricing & Commission | Feature 3 | MVP |
| **US-CA-07** | JomPAY OFF-US — Cash | Feature 5, 12 | Phase 2 |
| **US-CA-08** | Prepaid CELCOM — Cash | Feature 5, 12 | Phase 2 |
| **US-CA-11** | Cash Deposit — ProxyEnquiry | Feature 5 | MVP |
| **US-CA-12** | e-KYC MyKad | Feature 6 | MVP |
| **US-CA-13** | e-KYC Face AI | Feature 6 | MVP |
| **US-CA-14** | Account Provisioning | Feature 6 | MVP |
| **US-CA-15** | SAF Auto-Reversal | Feature 8 | MVP |
| **US-CA-16** | Compliance Freeze | Feature 7 | Phase 2 |
| **US-CA-17** | Retail Sale | Feature 9 | Phase 2 |
| **US-CA-18** | PIN Purchase — Cash | Feature 9 | Phase 2 |
| **US-CA-19** | Cash-Back Hybrid | Feature 9 | Phase 2 |
| **US-CA-20** | Agent Self-Onboarding | Feature 10 | Phase 2 |
| **US-CA-21** | Compliance Unlock | Feature 7 | Phase 2 |
| **US-CA-22** | EOD Settlement UI | Feature 11 | Phase 2 |
| **US-CA-23** | Balance Inquiry — ATM Card | Feature 12 | MVP |
| **US-CA-24** | Cash Withdrawal — MyKad Biometric | Feature 12 | Phase 2 |
| **US-CA-25** | Cash Deposit — Card Funded | Feature 12 | Phase 2 |
| **US-CA-26** | JomPAY OFF-US — Card | Feature 12 | Phase 2 |
| **US-CA-27** | JomPAY ON-US — Cash | Feature 12 | Phase 2 |
| **US-CA-28** | JomPAY ON-US — Card | Feature 12 | Phase 2 |
| **US-CA-29** | ASTRO RPN — Cash | Feature 12 | Phase 2 |
| **US-CA-30** | ASTRO RPN — Card | Feature 12 | Phase 2 |
| **US-CA-31** | TM RPN — Cash | Feature 12 | Phase 2 |
| **US-CA-32** | TM RPN — Card | Feature 12 | Phase 2 |
| **US-CA-33** | EPF Contribution — Cash | Feature 12 | Phase 2 |
| **US-CA-34** | EPF Contribution — Card | Feature 12 | Phase 2 |
| **US-CA-35** | Prepaid CELCOM — Card | Feature 12 | Phase 2 |
| **US-CA-36** | Prepaid M1 — Cash | Feature 12 | Phase 2 |
| **US-CA-37** | Prepaid M1 — Card | Feature 12 | Phase 2 |
| **US-CA-38** | Sarawak Pay Withdrawal — Cash | Feature 12 | Phase 2 |
| **US-CA-39** | Sarawak Pay Withdrawal — Card | Feature 12 | Phase 2 |
| **US-CA-40** | Sarawak Pay TOP-UP — Cash | Feature 12 | Phase 2 |
| **US-CA-41** | Sarawak Pay TOP-UP — Card | Feature 12 | Phase 2 |
| **US-CA-42** | eSSP Purchase — Cash | Feature 12 | Phase 2 |
| **US-CA-43** | eSSP Purchase — Card | Feature 12 | Phase 2 |
| **US-CA-44** | PIN Purchase — Card | Feature 12 | Phase 2 |

---
**End of BDD Specification**



