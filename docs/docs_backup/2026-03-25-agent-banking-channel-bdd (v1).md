# BDD Specification: Agent Banking Channel App

**Version:** 1.0  
**Date:** 2026-03-25  
**Status:** Draft — Pending Review  
**Module:** Channel App (Flutter POS Terminal)  
**BRD Reference:** `docs/superpowers/specs/agent-banking-channel/2026-03-25-agent-banking-channel-brd.md`

Each BDD scenario is tagged with exactly one `@US` (User Story) and one `@FR` (Functional Requirement) for atomic traceability.

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

  @US-CA-01 @FR-CA-1.2
  Scenario: Session expires and requires re-authentication
    Given the agent is logged in with an expired session
    When the agent attempts to initiate a transaction
    Then the app redirects to the login screen
    And displays "Session expired. Please log in again."

  @US-CA-01 @FR-CA-1.3
  Scenario: Device ID validation on login
    Given the agent's device is not whitelisted in the backend
    When the agent attempts to log in
    Then the login is rejected with error "Device not authorized"
    And the session is not created

  @US-CA-01 @FR-CA-1.4
  Scenario: Secure logout clears all sensitive data
    Given the agent is logged in with an active session
    When the agent logs out
    Then the JWT token is deleted from secure storage
    And all session state is cleared
    And the app returns to the login screen

  @US-CA-01 @FR-CA-1.5
  Scenario: Re-authentication without full restart on session expiry
    Given the agent is in the middle of a transaction when session expires
    When the system detects the expired token
    Then the app shows a non-blocking "session expired" dialog
    And allows the agent to re-authenticate and continue the transaction
```

---

## 2. Geofence Enforcement

```gherkin
Feature: Geofence Enforcement

  @US-CA-02 @FR-CA-2.2
  Scenario: Transaction allowed within geofence
    Given the agent's registered location is at (3.1390, 101.6869)
    And the device GPS shows (3.1395, 101.6872)
    When the agent attempts to initiate a withdrawal
    Then the geofence check passes (distance < 100m)
    And the transaction proceeds to the Dual-Handshake workflow

  @US-CA-02 @FR-CA-2.3
  Scenario: Transaction blocked outside geofence
    Given the agent's registered location is at (3.1390, 101.6869)
    And the device GPS shows (3.1500, 101.7000)  // ~2km away
    When the agent attempts to initiate a withdrawal
    Then the geofence check fails
    And the app displays "Transaction outside 100m geofence"
    And the transaction is not initiated

  @US-CA-02 @FR-CA-2.4
  Scenario: GPS coordinates sent in request headers
    Given the agent is within geofence
    When a transaction request is sent to the backend
    Then the request includes headers:
      | X-GPS-Latitude | Decimal(9,6) |
      | X-GPS-Longitude | Decimal(9,6) |

  @US-CA-02 @FR-CA-2.5
  Scenario: Geofence status indicator on home screen
    Given the app is on the home screen
    When the device GPS is within 100m of registered location
    Then a green geofence icon is displayed
    When the device GPS moves outside 100m
    Then a red geofence icon is displayed with warning "Outside geofence"
```

---

## 3. Agent Float & Balance Display

```gherkin
Feature: Agent Float and Balance Display

  @US-CA-03 @FR-CA-3.1
  Scenario: Home screen displays available float balance
    Given the agent is logged in
    When the home screen loads
    Then the agent's available balance is prominently displayed
    And the balance shows: total, reserved, available

  @US-CA-03 @FR-CA-3.2
  Scenario: Balance updates after transaction completion
    Given the agent's available balance is RM 10,000.00
    When a withdrawal of RM 500.00 is completed successfully
    Then the available balance updates to RM 9,500.00 within 5 seconds

  @US-CA-03 @FR-CA-3.4
  Scenario: Balance refresh on app foreground
    Given the app is in background for 10 minutes
    When the agent brings the app to foreground
    Then the app fetches the latest balance from backend
    And updates the display

  @US-CA-03 @FR-CA-3.5
  Scenario: Stale balance indicator when fetch fails
    Given the last balance fetch failed due to network error
    When the home screen displays
    Then the last known balance is shown with a "stale" indicator
    And the agent can still initiate transactions (backend will validate)
```

---

## 4. Dual-Handshake STP Workflow

```gherkin
Feature: Dual-Handshake STP Workflow

  @US-CA-04 @US-CA-04a @FR-CA-4.2
  Scenario: Customer inserts card during withdrawal
    Given the agent has initiated a withdrawal of RM 500.00
    When the system prompts the customer to insert their card
    And the customer inserts their EMV card into the hardware reader
    Then the card is detected and read successfully
    And the customer display shows "Please enter your 6-digit PIN"

  @US-CA-04 @US-CA-04b @FR-CA-4.2
  Scenario: Customer enters PIN on encrypted hardware pad
    Given the card has been read
    When the customer enters their 6-digit PIN on the encrypted hardware PIN pad
    Then the PIN is captured by the hardware module
    And the app receives an encrypted PIN block
    And the agent's screen does NOT display the PIN

  @US-CA-04 @US-CA-04c @FR-CA-4.4
  Scenario: Customer confirms transaction amount
    Given the card and PIN have been captured
    When the customer display shows "Confirm withdrawal: RM 500.00"
    And the customer taps "Confirm"
    Then the transaction proceeds to processing

  @US-CA-04 @US-CA-04d @FR-CA-4.6
  Scenario: Successful transaction triggers SMS receipt
    Given the withdrawal transaction has been approved by the backend
    When the transaction completes
    Then the backend automatically sends an SMS receipt to the customer's registered mobile
    And the app displays "Transaction Successful" to both agent and customer

  @US-CA-22 @FR-CA-4.6
  Scenario: Agent screen masks sensitive card data
    Given the customer has inserted their card
    When the agent views the transaction screen
    Then only the masked PAN is shown (e.g., "411111******1111")
    And the full PAN and PIN are never displayed

  @US-CA-04 @FR-CA-4.5
  Scenario: Transaction state progression
    Given the agent initiates a withdrawal
    When the customer inserts the card
    Then the UI shows "Card read - waiting for PIN"
    When the customer enters PIN
    Then the UI shows "Processing..."
    When the backend responds
    Then the UI shows either "Successful" or "Failed" with reason
```

---

## 5. Cash Withdrawal (STP Transaction)

```gherkin
Feature: Cash Withdrawal (STP)

  @US-CA-04 @FR-CA-5.2
  Scenario: Client-side validation before transaction
    Given the agent's available balance is RM 1,000.00
    And the agent's daily withdrawal limit is RM 3,000.00
    When the agent attempts to withdraw RM 1,200.00
    Then the client-side check passes (amount ≤ min(balance, limit))

  @US-CA-04 @FR-CA-5.2
  Scenario: Client-side validation fails - insufficient balance
    Given the agent's available balance is RM 500.00
    When the agent attempts to withdraw RM 1,000.00
    Then the app immediately displays "Insufficient float balance"
    And the transaction is not initiated

  @US-CA-05 @FR-CA-5.5
  Scenario: Transaction timeout handling
    Given the agent has completed Dual-Handshake
    When the backend takes longer than 15 seconds to respond
    Then the app shows "Processing... (timeout: 5s)"
    And if timeout occurs, displays "Transaction timed out. Please try again."

  @US-CA-06 @FR-CA-5.7
  Scenario: Backend error - insufficient customer balance
    Given the customer's account balance is RM 400.00
    When the agent attempts to withdraw RM 500.00
    Then the backend returns ERR_INSUFFICIENT_BALANCE
    And the app displays "Insufficient account balance" to the agent
    And the customer sees "Transaction declined"

  @US-CA-06 @FR-CA-5.7
  Scenario: Backend error - geofence violation
    Given the agent is outside the geofence
    When the agent attempts a withdrawal
    Then the backend returns ERR_GEOFENCE_VIOLATION
    And the app displays "Outside permitted area. Transaction declined."

  @US-CA-07 @FR-CA-5.6
  Scenario: Receipt printing on successful withdrawal
    Given the withdrawal transaction completed successfully
    When a receipt printer is available and configured
    Then the app prints a receipt with:
      | Field | Requirement |
      | Transaction ID | UUID |
      | Amount | RM 500.00 |
      | Agent | Agent Code (masked) |
      | PAN | Masked (first 6, last 4) |
      | Timestamp | Local time |
      | Status | COMPLETED |

  @US-CA-08 @FR-CA-5.8
  Scenario: Transaction reversal for printer failure after switch approval
    Given the switch has approved the withdrawal
    When the printer fails to print the receipt
    Then the app triggers an MTI 0400 reversal request
    And the agent float is restored within 60 seconds
    And the agent is notified "Printer failed. Transaction reversed."
```

---

## 6. Cash Deposit (STP Transaction)

```gherkin
Feature: Cash Deposit (STP)

  @US-CA-08 @FR-CA-6.2
  Scenario: Account validation before accepting cash
    Given the agent selects "Deposit" and enters account "1234567890"
    When the app calls the backend ProxyEnquiry API
    Then the app shows "Validating account..."
    And if valid, proceeds to amount entry
    And if invalid, displays "Account not found"

  @US-CA-08 @FR-CA-6.3
  Scenario: Deposit with invalid account number
    Given the agent enters account "9999999999"
    When the backend returns account validation failure
    Then the app displays "Invalid account number"
    And the agent cannot proceed to cash collection

  @US-CA-08 @FR-CA-6.5
  Scenario: Agent confirms cash receipt before finalizing
    Given the account validation passed
    When the agent enters amount RM 1,000.00
    Then the app displays "Confirm: Received RM 1,000.00 cash from customer?"
    And the agent taps "Confirm" only after physically receiving cash

  @US-CA-10 @FR-CA-6.7
  Scenario: Agent float credited instantly after deposit
    Given the deposit transaction is confirmed by the agent
    When the backend successfully processes the deposit
    Then the agent's float balance increases by the deposited amount
    And the updated balance is displayed within 5 seconds
```

---

## 7. Balance Inquiry (STP)

```gherkin
Feature: Balance Inquiry (STP)

  @US-CA-11 @FR-CA-7.2
  Scenario: Balance inquiry requires Dual-Handshake
    Given the agent selects "Balance Inquiry"
    When the app does not require card and PIN
    Then the transaction is blocked with error "Authentication required"

  @US-CA-11 @FR-CA-7.3
  Scenario: Successful balance inquiry displays masked account
    Given the customer inserts their card and enters correct PIN
    When the backend returns balance RM 15,000.00 for account ****7890
    Then the agent screen shows "Balance: RM 15,000.00"
    And the customer screen shows "Your balance: RM 15,000.00"
    And only the masked account number is displayed

  @US-CA-11 @FR-CA-7.4
  Scenario: Balance data not stored locally after inquiry
    Given a balance inquiry was completed
    When the agent leaves the app in background
    Then the balance data is cleared from memory
    And no balance data remains in app storage
```

---

## 8. e-KYC Verification (Conditional STP)

```gherkin
Feature: e-KYC Verification

  @US-CA-13 @FR-CA-8.1
  Scenario: MyKad scanning via camera
    Given the agent selects "KYC Verify"
    When the app launches the camera scanner
    And the agent scans the customer's MyKad
    Then the OCR extracts: name, MyKad number, date of birth
    And the app displays "Verifying identity..."

  @US-CA-14 @FR-CA-8.3
  Scenario: Biometric capture for liveness check
    Given the MyKad data has been extracted
    When the customer places their thumb on the biometric scanner
    Then the scanner captures the biometric template
    And the app sends both MyKad data and biometric to backend

  @US-CA-15 @FR-CA-8.6
  Scenario: Auto-approval result displayed immediately
    Given the backend verification completed with status AUTO_APPROVED
    When the app receives the response
    Then the agent sees "KYC Approved - Customer can open account"
    And the customer sees "Your identity has been verified"

  @US-CA-15 @FR-CA-8.6
  Scenario: Manual review queued result displayed
    Given the backend verification returned MANUAL_REVIEW (biometric mismatch)
    When the app receives the response
    Then the agent sees "Queued for review - Customer will be notified"
    And the customer sees "Your application is under review"

  @US-CA-15 @FR-CA-8.8
  Scenario: Rejection result displayed with reason
    Given the backend verification returned REJECTED (MyKad not found)
    When the app receives the response
    Then the agent sees "Verification failed: MyKad not found in records"
    And the customer sees "Unable to verify - Please visit branch"

  @US-CA-16 @FR-CA-8.7
  Scenario: Proceed to account opening after auto-approval
    Given the KYC resulted in AUTO_APPROVED
    When the agent selects "Open Account"
    Then the app navigates to the account opening flow
    And pre-fills the customer's name and MyKad number
```

---

## 9. Offline & Store & Forward

```gherkin
Feature: Offline Mode and Store & Forward

  @US-CA-17 @FR-CA-9.1
  Scenario: Network connectivity detection
    Given the app is running with network connectivity
    When the network connection is lost
    Then within 30 seconds the app detects the disconnection
    And displays "Offline Mode" banner at the top of the screen

  @US-CA-17 @FR-CA-9.3
  Scenario: Transaction queued when offline
    Given the app is in offline mode
    When the agent attempts a withdrawal
    And completes the Dual-Handshake (card + PIN)
    Then the app validates client-side limits
    And queues the transaction with status QUEUED_OFFLINE
    And shows "Transaction queued - will sync when online"
    And does NOT deduct the agent float locally

  @US-CA-17 @FR-CA-9.3
  Scenario: Queued transactions sync on network restoration
    Given there are 3 queued offline transactions
    When the network connection is restored
    Then the app begins syncing queued transactions every 30 seconds
    And each transaction is sent with its original X-Idempotency-Key
    And upon successful sync, the transaction status updates to COMPLETED
    And the agent's float balance updates accordingly

  @US-CA-17 @FR-CA-9.3
  Scenario: Transaction reversal on network failure (MTI 0400)
    Given the switch approved a withdrawal but network dropped before response
    When the app times out waiting for backend confirmation
    Then the app shows "Network timeout - Transaction being reversed"
    And does NOT manually adjust the agent float
    And the backend's reversal endpoint is called during sync retry

  @US-CA-17 @FR-CA-9.5
  Scenario: Queued transactions encrypted at rest
    Given a transaction is queued while offline
    When the app stores it to local SQLite
    Then the transaction payload is encrypted using device keystore
    And cannot be read by other apps or rooted device inspection
```

---

## 10. Hardware Integration (POS)

```gherkin
Feature: Hardware Integration

  @US-CA-04 @FR-CA-10.1
  Scenario: EMV card reader available and functional
    Given the app starts up
    When the hardware detection runs
    Then the card reader status is AVAILABLE
    And the agent can initiate card-based transactions

  @US-CA-04 @FR-CA-10.2
  Scenario: Card reader unavailability blocks card transactions
    Given the card reader is detected as UNAVAILABLE
    When the agent attempts a withdrawal
    Then the app displays "Card reader not available. Please check hardware."
    And the withdrawal flow cannot proceed past the amount entry

  @US-CA-07 @FR-CA-10.4
  Scenario: Receipt printing is optional
    Given the withdrawal succeeded
    When the printer is configured as disabled
    Then the transaction completes without attempting to print
    And the agent sees "Receipt skipped (printing disabled)"

  @US-CA-14 @FR-CA-10.1
  Scenario: Biometric scanner for customer thumbprint
    Given the agent is in the KYC verification flow
    When the customer places their thumb on the biometric scanner
    Then the scanner captures the print and sends to backend
    And the UI shows "Capturing biometric..."
```

---

## 11. Error Handling & User Experience

```gherkin
Feature: Error Handling and User Experience

  @US-CA-06 @FR-CA-11.1
  Scenario: Translation of backend error codes to user-friendly messages
    Given the backend returns error code ERR_LIMIT_EXCEEDED
    When the app receives the error
    Then the agent sees "Daily transaction limit exceeded"
    And the customer sees "Transaction limit reached"

  @US-CA-06 @FR-CA-11.2
  Scenario: Agent-facing error includes support code
    Given a transaction fails with ERR_VELOCITY_COUNT_EXCEEDED
    When the error is displayed
    Then the agent sees the error code in small text for support reference
    And the customer sees a simplified message "Too many transactions today"

  @US-CA-11 @FR-CA-11.4
  Scenario: Automatic retry on network timeout
    Given a transaction request times out after 10 seconds
    When the app has retry count < 3
    Then the app automatically retries the request after 5 seconds
    And displays "Retrying... (attempt 2)"

  @US-CA-11 @FR-CA-11.5
  Scenario: Transaction cancellation before final confirmation
    Given the agent has entered amount RM 500.00
    When the customer has NOT yet confirmed
    Then the agent can tap "Cancel" to abort the transaction
    And no request is sent to the backend
    And the float is not affected
```

---

## 12. Security & Compliance

```gherkin
Feature: Security and Compliance

  @US-CA-01 @FR-CA-12.1
  Scenario: No PII in application logs
    Given a withdrawal transaction is processed
    When the app writes logs
    Then the logs contain no full PAN, PIN, or JWT token
    And only masked card numbers appear (if any)

  @US-CA-01 @FR-CA-12.2
  Scenario: Sensitive data stored in secure storage
    Given the agent logs in successfully
    When the JWT token is saved
    Then it is stored using Flutter Secure Storage (Android Keystore)
    And cannot be extracted by other apps

  @US-CA-04 @FR-CA-12.5
  Scenario: Screenshot protection on sensitive screens
    Given the agent is on the PIN entry screen (customer-facing)
    When the agent attempts to take a screenshot
    Then the screen is blank/black
    And the app logs the attempted screenshot

  @US-CA-02 @FR-CA-12.6
  Scenario: Remote logout by backend
    Given the agent has an active session
    When the backend revokes the JWT token (compromise detected)
    Then the next API call fails with 401 Unauthorized
    And the app forces logout and returns to login screen
```

---

## 13. Traceability Matrix

### User Story → BDD Scenario Coverage

| User Story | FR(s) | BDD Scenario(s) |
|------------|-------|-----------------|
| US-CA-01 | FR-CA-1.1, FR-CA-1.2, FR-CA-1.3, FR-CA-1.4, FR-CA-1.5 | S1.1, S1.2, S1.3, S1.4, S1.5 |
| US-CA-02 | FR-CA-2.2, FR-CA-2.3, FR-CA-2.4, FR-CA-2.5 | S2.1, S2.2, S2.3, S2.4 |
| US-CA-03 | FR-CA-3.1, FR-CA-3.2, FR-CA-3.4, FR-CA-3.5 | S3.1, S3.2, S3.3, S3.4 |
| US-CA-04 | FR-CA-4.2, FR-CA-5.2, FR-CA-5.8 | S4.1, S4.2, S4.3, S4.4, S5.1, S5.2, S5.8 |
| US-CA-04a | FR-CA-4.2 | S4.1 |
| US-CA-04b | FR-CA-4.2, FR-CA-4.6 | S4.2 |
| US-CA-04c | FR-CA-4.4, FR-CA-4.5 | S4.3 |
| US-CA-04d | FR-CA-4.6 | S4.4 |
| US-CA-05 | FR-CA-5.5 | S5.3 |
| US-CA-06 | FR-CA-5.7 | S5.4, S5.5 |
| US-CA-07 | FR-CA-5.6 | S5.6, S5.8 |
| US-CA-08 | FR-CA-6.2, FR-CA-6.3, FR-CA-6.5 | S6.1, S6.2, S6.3 |
| US-CA-09 | FR-CA-6.3 | S6.2 |
| US-CA-10 | FR-CA-6.7, FR-CA-3.2 | S3.2, S6.3 |
| US-CA-11 | FR-CA-7.2, FR-CA-7.3, FR-CA-7.4 | S7.1, S7.2, S7.3 |
| US-CA-12 | FR-CA-7.3 | S7.2 |
| US-CA-13 | FR-CA-8.1 | S8.1 |
| US-CA-14 | FR-CA-8.3 | S8.2 |
| US-CA-15 | FR-CA-8.6 | S8.3, S8.4, S8.5 |
| US-CA-16 | FR-CA-8.7 | S8.8 |
| US-CA-17 | FR-CA-9.1, FR-CA-9.3, FR-CA-9.5 | S9.1, S9.2, S9.3, S9.4 |
| US-CA-18 | FR-CA-9.3 | S9.4 |
| US-CA-19 | FR-CA-4.1 | S4.2 (customer display) |
| US-CA-20 | FR-CA-4.4 | S4.3 |
| US-CA-21 | FR-CA-4.1 | Implied in customer display flows |
| US-CA-22 | FR-CA-4.6 | S4.2 |
| US-CA-23 | FR-CA-4.5 | S4.4 |

### Requirement Coverage Summary

| Requirement | Covered By Scenario(s) |
|-------------|----------------------|
| FR-CA-1.1 | S1.1 |
| FR-CA-1.2 | S1.2 |
| FR-CA-1.3 | S1.3 |
| FR-CA-1.4 | S1.4 |
| FR-CA-1.5 | S1.5 |
| FR-CA-2.2 | S2.1 |
| FR-CA-2.3 | S2.2 |
| FR-CA-2.4 | S2.3 |
| FR-CA-2.5 | S2.4 |
| FR-CA-3.1 | S3.1 |
| FR-CA-3.2 | S3.2, S6.3 |
| FR-CA-3.4 | S3.3 |
| FR-CA-3.5 | S3.4 |
| FR-CA-4.1 | S4.2 (customer display used) |
| FR-CA-4.2 | S4.1, S4.2, S4.3 |
| FR-CA-4.4 | S4.3 |
| FR-CA-4.5 | S4.4 |
| FR-CA-4.6 | S4.2, S4.4 |
| FR-CA-5.2 | S5.1, S5.2 |
| FR-CA-5.5 | S5.3 |
| FR-CA-5.7 | S5.4, S5.5 |
| FR-CA-5.6 | S5.6 |
| FR-CA-5.8 | S5.8 |
| FR-CA-6.2 | S6.1 |
| FR-CA-6.3 | S6.2 |
| FR-CA-6.5 | S6.3 |
| FR-CA-6.7 | S6.3 |
| FR-CA-7.2 | S7.1 |
| FR-CA-7.3 | S7.2 |
| FR-CA-7.4 | S7.3 |
| FR-CA-8.1 | S8.1 |
| FR-CA-8.3 | S8.2 |
| FR-CA-8.6 | S8.3, S8.4, S8.5 |
| FR-CA-8.7 | S8.8 |
| FR-CA-8.8 | S8.4, S8.5 |
| FR-CA-9.1 | S9.1 |
| FR-CA-9.3 | S9.2, S9.3, S9.4 |
| FR-CA-9.5 | S9.2 |
| FR-CA-10.1 | S10.1, S10.2 |
| FR-CA-10.2 | S10.2 |
| FR-CA-10.4 | S10.3 |
| FR-CA-11.1 | S11.1 |
| FR-CA-11.2 | S11.2 |
| FR-CA-11.4 | S11.3 |
| FR-CA-11.5 | S11.4 |
| FR-CA-12.1 | S12.1 |
| FR-CA-12.2 | S12.2 |
| FR-CA-12.5 | S12.3 |
| FR-CA-12.6 | S12.4 |

---

**End of BDD Specification**
