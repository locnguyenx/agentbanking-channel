# BDD Specification: Agent Banking Channel App

**Version:** 2.0  
**Date:** 2026-03-25  
**Status:** Draft — Pending Review  
**Module:** Channel App (Flutter POS Terminal)  
**BRD Reference:** `docs/superpowers/specs/agent-banking-channel/2026-03-25-agent-banking-channel-brd.md`

Each BDD scenario is expertly tagged with exactly one `@US` (User Story) and one `@FR` (Functional Requirement) for atomic traceability.

---

## 1. Agent Authentication & Session Management

```gherkin
Feature: Agent Authentication and Session

  @US-CA-01 @FR-CA-1.1
  Scenario: Agent logs in with valid biometric
    Given the channel app is launched
    When the agent authenticates using fingerprint biometrics
    Then a JWT session is created and stored securely
    And the agent is navigated to the home screen
    And the UI displays the agent's pre-funded Float Ledger balance

  @US-CA-01 @FR-CA-1.3
  Scenario: Session expires and requires re-authentication
    Given the agent is logged in with an expired session
    When the agent attempts to initiate a transaction
    Then the app redirects to the login screen
    And displays "Session expired. Please log in again."

  @US-CA-01 @FR-CA-1.1
  Scenario: Device ID validation on login
    Given the agent's device MAC Address is not whitelisted in the backend
    When the agent attempts to log in
    Then the login is rejected with error "Device not authorized"
    And the session is not created

  @US-CA-01 @FR-CA-1.3
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

  @US-CA-02 @FR-CA-1.2
  Scenario: Transaction allowed within geofence
    Given the agent's registered location is at (3.1390, 101.6869)
    And the device GPS shows (3.1395, 101.6872)
    When the agent attempts to initiate a transaction
    Then the geofence check passes (distance < 100m)
    And the transaction proceeds to the pricing engine workflow

  @US-CA-02 @FR-CA-1.2
  Scenario: Transaction blocked outside geofence
    Given the agent's registered location is at (3.1390, 101.6869)
    And the device GPS shows (3.1500, 101.7000)  // ~2km away
    When the agent attempts to initiate a transaction
    Then the geofence check fails
    And the app displays "Transaction outside 100m geofence"
    And the transaction is instantly blocked

  @US-CA-02 @FR-CA-1.2
  Scenario: GPS coordinates sent in API request headers
    Given the agent is within geofence
    When a transaction request is sent to the backend
    Then the request explicitly includes headers:
      | X-GPS-Latitude | Decimal(9,6) |
      | X-GPS-Longitude | Decimal(9,6) |
```

---

## 3. Parameter & Pricing Engine (Fees & Commissions)

```gherkin
Feature: Parameter Engine 

  @US-CA-06 @FR-CA-2.1
  Scenario: Transaction initiates fee engine API call
    Given the agent has entered all transaction inputs successfully
    When the agent taps "Proceed"
    Then the app automatically pauses the workflow
    And calls the backend `/api/v1/transactions/quote` endpoint

  @US-CA-06 @FR-CA-2.2
  Scenario: Customer explicitly consents to the Transaction Fee
    Given the app has successfully retrieved the transaction quote
    When the Dual-Handshake begins
    Then the customer-facing display prominently shows: "Principal: RM 500.00 | Fee: RM 1.00 | Total Deducted: RM 501.00"
    And blocks hardware PIN entry until the customer taps "Agree"

  @US-CA-06 @FR-CA-2.3
  Scenario: Agent silently views Commission earned
    Given the app has successfully retrieved the transaction quote
    When the Dual-Handshake begins
    Then the agent-facing display securely shows "Estimated Commission: RM 0.50"
    And this commission value is NEVER shown on the customer display
```

---

## 4. STP Dual-Handshake & Transaction Funding

```gherkin
Feature: Dual-Handshake Payment Execution

  @US-CA-03 @FR-CA-3.1
  Scenario: Cash-Out using ATM Card (Physical Chip)
    Given the customer agreed to the Principal + Fee amount
    When the customer inserts their EMV card into the hardware reader
    And enters entirely their 6-digit PIN on the encrypted peripheral
    Then the POS hardware directly encrypts the PIN block via DUKPT
    And the app fires the `/api/v1/transactions/execute` Call
    And the agent NEVER sees the customer PIN

  @US-CA-04 @FR-CA-3.2
  Scenario: Cash-In utilizing Agent Validation (Physical Cash)
    Given the transaction is a Cash Deposit and the customer is verified
    When the app prompts the agent for Physical Proof
    Then the UI strictly requires the Agent to click "Confirm Cash Received"
    And upon clicking, the Agent's pre-funded Float balance is debited
    And the Customer receives an SMS receipt

  @US-CA-05 @FR-CA-3.3
  Scenario: Digital Fund Transfer via DuitNow Push/Pull
    Given the customer's Funding Source is `DIGITAL_DUITNOW`
    When the agent submits the customer's DuitNow Proxy ID
    Then the Backend fires a Push Notification to the customer's Mobile Banking App
    And the POS terminal spins into a "Waiting for Customer Approval" polling state
    When the customer accepts on their own smartphone via FaceID
    Then the POS terminal receives the Webhook and completes the Transaction
```

---

## 5. Service Orchestration & Validations

```gherkin
Feature: 31 Core Services Orchestration Validation

  @US-CA-07 @FR-CA-4.1
  Scenario: Bill Payments using JomPAY Ref-1 Validation
    Given the agent selected the Bill Payment feature
    When the agent keys in the customer's `Ref-1` account number
    Then the app instantly executes a Biller Inquiry pre-check
    And dynamically locks or proceeds based on the real-time API response

  @US-CA-08 @FR-CA-4.2
  Scenario: Prepaid Top-Up Telco Validation
    Given the agent selected Prepaid RM 50 (Celcom)
    When the agent keys in the phone number "019999999X"
    And the format is inherently invalid or the Telco API rejects the number
    Then the app blocks the financial handshake immediately

  @US-CA-11 @FR-CA-4.3
  Scenario: Cash Deposit via ProxyEnquiry Name Verification
    Given the agent types destination account "123456789"
    When the app queries the backend ProxyEnquiry
    Then the customer display shows a masked recipient "MOHD A***D BIN AL*"
    And the customer must verbally or digitally confirm ownership before cash is collected

  @US-CA-03 @FR-CA-4.4
  Scenario: Client-side Withdrawal Limit Pre-Check 
    Given the agent's available balance is RM 10,000
    When the customer requests a Cash Withdrawal of RM 8,000
    Then the client-side Check detects a breach of the RM 5,000 STP Hard Cap
    And gracefully displays "Limit Exceeded: Maximum RM 5,000 per transaction"
```

---

## 6. Conditional STP (e-KYC & Onboarding)

```gherkin
Feature: e-KYC Verification and Face AI

  @US-CA-12 @FR-CA-5.1
  Scenario: Scan MyKad OCR
    Given an unregistered customer wants to Open an Account
    When the agent inserts the MyKad into the Smart Card Reader
    Then the OCR/Chip-read extracts Name, IC, Address perfectly

  @US-CA-12 @FR-CA-5.2
  Scenario: Happy Path: Biometric Match-on-Card
    Given the MyKad data is extracted
    When the customer presses their thumb on the Biometric Peripheral
    Then a verified "Match" is returned

  @US-CA-13 @FR-CA-5.3
  Scenario: Failed Thumbprint defaults to Face AI Liveness Fallback
    Given the Match-on-Card thumbprint check returns "FAILED" or "NO MATCH"
    When the app transitions state
    Then the POS frontal camera activates immediately
    And prompts the customer: "Please Blink Twice" for Video Liveness capture

  @US-CA-13 @FR-CA-5.4
  Scenario: Payload validation against 3rd-Party & AML
    Given the Liveness video blob is securely captured
    When the app triggers `POST /api/v1/kyc/verify`
    Then the Backend securely routes the media to Innov8tif/Jumio
    And concurrently runs an AML Sanctions check locally

  @US-CA-14 @FR-CA-5.5
  Scenario: Auto-Approve directly Provisions Account
    Given the e-KYC payload returns `AUTO_APPROVED`
    When the app handles the HTTP 200 OK
    Then it completely bypasses the core menu and forces an initial Cash Deposit collection
    And instantly provisions the Core Savings Account without leaving the session

  @US-CA-14 @FR-CA-5.6
  Scenario: Manual Review Routing
    Given the e-KYC payload returns `MANUAL_REVIEW` due to fuzzy AML matches
    Then the app stops the onboarding workflow
    And informs the customer: "Application Queued for Analyst Review. You will be notified via SMS."
```

---

## 7. Anti-Smurfing & Compliance Freezes

```gherkin
Feature: Anti-Smurfing Category 3 Fallbacks

  @US-CA-16 @FR-CA-6.1
  Scenario: Velocity Structuring immediately Locks Terminal
    Given an agent initiates their 10th Cash Deposit of RM 2,900 within an hour
    When the Backend API Rules Engine detects deliberate Smurfing
    Then the API rejects the request heavily with `ERR_COMPLIANCE_FREEZE`
    And the local App instantly drops into a `LOCKED` state

  @US-CA-16 @FR-CA-6.2
  Scenario: The LOCKED UI state blocks STP
    Given the terminal is `LOCKED`
    When the agent attempts to access the Core Menu
    Then all financial services are disabled and grayed out
    And a red banner reading "COMPLIANCE REVIEW - Dial 1-800-XXX-XXXX for Support" is permanently displayed
```

---

## 8. Store & Forward (Offline Queuing & Reversals)

```gherkin
Feature: Edge Case Automation

  @US-CA-15 @FR-CA-7.1
  Scenario: Graceful STP Timeout protects Float
    Given the Dual Handshake is completed 
    When the network is extraordinarily slow (Timeout 30s)
    Then the app aborts the UI but DOES NOT manually adjust the Agent Float blindly
    And defers entirely to the Backend ledger history sync

  @US-CA-15 @FR-CA-7.2
  Scenario: Critical Printer failure triggers MTI 0400 Reversal
    Given the backend returned 200 OK for a Cash Withdrawal
    And the Agent Float was successfully debited centrally
    When the physical POS printer detects "Out Of Paper" or "Paper Jam"
    Then the app actively queues an `MTI 0400 Reversal Payload` 
    And securely sends it to the backend completely returning the Agent Float to parity

  @US-CA-15 @FR-CA-7.3
  Scenario: Store & Forward re-transmits via X-Idempotency
    Given an `MTI 0400 Reversal` is queued offline
    When the POS recovers 4G connection
    Then it continuously pings the backend every 30s with the original `X-Idempotency-Key`
    And permanently clears the SQLite Cache upon successful HTTP 200 Reversal confirmation
```

---

## 9. EOD Settlement & Reconciliation

```gherkin
Feature: EOD Cut-Off Operations

  @US-CA-01 @FR-CA-8.2
  Scenario: Terminal blocks transactions beyond End of Day
    Given the POS terminal local clock reaches 23:55:00 MYT (Malaysia Time)
    When the agent remains logged in
    Then the App displays a warning "End of Day Batch Settlement initiates in 5 Minutes. Please wrap up."
    And strictly disables 100% STP workflows permanently at 23:59:59 MYT until the settlement is finalized.
```

---

## 10. Traceability Matrix

### User Story → BDD Scenario Coverage

| User Story | Associated FR(s) | Scenario ID / Location |
|------------|-------|-----------------|
| **US-CA-01** (Auth & Float) | FR-CA-1.1, FR-CA-1.3, FR-CA-8.2 | Feature 1 (S1.1, S1.2, S1.3, S1.4); Feature 9 (S9.1) |
| **US-CA-02** (Geofence) | FR-CA-1.2 | Feature 2 (S2.1, S2.2, S2.3) |
| **US-CA-03** (Cash-Out) | FR-CA-3.1, FR-CA-4.4 | Feature 4 (S4.1); Feature 5 (S5.4) |
| **US-CA-04** (Cash-In) | FR-CA-3.2 | Feature 4 (S4.2) |
| **US-CA-05** (DuitNow) | FR-CA-3.3 | Feature 4 (S4.3) |
| **US-CA-06** (Params/Pricing) | FR-CA-2.1, FR-CA-2.2, FR-CA-2.3 | Feature 3 (S3.1, S3.2, S3.3) |
| **US-CA-07** (Bills/JomPAY) | FR-CA-4.1 | Feature 5 (S5.1) |
| **US-CA-08** (Prepaid Top-Up) | FR-CA-4.2 | Feature 5 (S5.2) |
| **US-CA-11** (ProxyEnquiry) | FR-CA-4.3 | Feature 5 (S5.3) |
| **US-CA-12** (e-KYC MyKad) | FR-CA-5.1, FR-CA-5.2 | Feature 6 (S6.1, S6.2) |
| **US-CA-13** (e-KYC Face AI) | FR-CA-5.3, FR-CA-5.4 | Feature 6 (S6.3, S6.4) |
| **US-CA-14** (Acc. Provisioning)| FR-CA-5.5, FR-CA-5.6 | Feature 6 (S6.5, S6.6) |
| **US-CA-15** (Auto-Reversal) | FR-CA-7.1, FR-CA-7.2, FR-CA-7.3 | Feature 8 (S8.1, S8.2, S8.3) |
| **US-CA-16** (Compliance Freeze)| FR-CA-6.1, FR-CA-6.2 | Feature 7 (S7.1, S7.2) |

---
**End of BDD Specification**
