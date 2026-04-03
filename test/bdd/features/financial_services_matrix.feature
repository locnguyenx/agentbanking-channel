Feature: All 31 Financial Services by Funding Method
  
  Background:
    Given the agent is logged in with an active session

  # ── Balance Inquiry ──────────────────────────────────────

 
  @US_CA_23
  @FR_CA_3_1
  @FR_CA_4_5
  @MVP
  Scenario: Balance Inquiry using ATM Card
    Given the customer inserts their EMV card
    And enters their PIN on the hardware PIN pad
    When the agent selects "Balance Inquiry" and the app calls POST /api/v1/balance-inquiry
    Then the customer balance is shown on the customer-facing display (masked: "RM ****")
    And no funds are deducted
    And a receipt is printed on request

  # ── Cash Withdrawal — MyKad Biometric ────────────────────

 
  @US_CA_24
  @FR_CA_5_2
  @FR_CA_4_5
  @Phase2
  Scenario: Cash Withdrawal using MyKad biometric (no ATM card)
    Given the customer does not have their ATM card
    When the customer places their MyKad in the reader and presses thumb on biometric scanner
    And the Match-on-Card returns "MATCH"
    Then the app fires POST /api/v1/withdrawal with fundingSource=MYKAD_BIOMETRIC
    And the agent hands over the requested cash amount

  # ── Cash Deposit — Card Funded ────────────────────────────

 
  @US_CA_25
  @FR_CA_3_1
  @FR_CA_4_3
  @FR_CA_4_7
  @Phase2
  Scenario: Cash Deposit funded by ATM Card
    Given the agent runs ProxyEnquiry and shows masked destination name to customer
    And the customer confirms the destination is correct
    When the customer inserts their ATM card and enters their PIN on the hardware PIN pad
    Then the app fires POST /api/v1/deposit with fundingSource=CARD_EMV
    And the destination account is credited
    And the agent receives an SMS confirmation

  # ── JomPAY OFF-US — Cash ────────────────────────────────

 
  @US_CA_07
  @FR_CA_4_1
  @FR_CA_4_8
  @Phase2
  Scenario: JomPAY OFF-US bill payment — cash funding
    Given the agent selects JomPAY and enters the biller code and customer Ref-1
    When the Biller Inquiry returns billerRouting=OFF_US and validationStatus=VALID
    Then the agent accepts cash from the customer and clicks "Confirm Cash Collected"
    And the app fires POST /api/v1/bill/pay with fundingSource=CASH, billerRouting=OFF_US
    And a JomPAY payment receipt is printed

  # ── JomPAY OFF-US — Card ────────────────────────────────

 
  @US_CA_26
  @FR_CA_4_1
  @FR_CA_4_7
  @Phase2
  Scenario: JomPAY OFF-US bill payment — card funding
    Given the agent validates Ref-1 and Biller Inquiry returns billerRouting=OFF_US
    When the customer inserts their ATM card and enters their PIN on the hardware PIN pad
    Then the app fires POST /api/v1/bill/pay with fundingSource=CARD_EMV, billerRouting=OFF_US
    And a JomPAY payment receipt is printed

  # ── JomPAY ON-US — Cash ────────────────────────────────

 
  @US_CA_27
  @FR_CA_4_1
  @FR_CA_4_8
  @FR_CA_4_9
  @Phase2
  Scenario: JomPAY ON-US bill payment — cash funding (internal routing)
    Given the Biller Inquiry returns billerRouting=ON_US
    When the agent accepts cash and clicks "Confirm Cash Collected"
    Then the app fires the payment to the ON-US internal endpoint (skipping PayNet switch)
    And settlement is faster than OFF-US routing
    And a biller receipt is printed

  # ── JomPAY ON-US — Card ────────────────────────────────

 
  @US_CA_28
  @FR_CA_4_1
  @FR_CA_4_7
  @FR_CA_4_9
  @Phase2
  Scenario: JomPAY ON-US bill payment — card funding (internal routing)
    Given the Biller Inquiry returns billerRouting=ON_US
    When the customer inserts ATM card and enters their PIN on the hardware PIN pad
    Then the app fires the payment to the ON-US internal endpoint
    And a biller receipt is printed

  # ── ASTRO RPN — Cash ────────────────────────────────────

 
  @US_CA_29
  @FR_CA_4_1
  @FR_CA_4_8
  @Phase2
  Scenario: ASTRO RPN bill payment — cash funding
    Given the agent enters the customer's ASTRO RPN account number
    And the Biller Inquiry confirms the account and outstanding amount
    When the agent accepts cash and clicks "Confirm Cash Collected"
    Then the app fires POST /api/v1/bill/pay (billerCode=ASTRO, fundingSource=CASH)
    And a Biller Receipt with ASTRO acknowledgment number is issued

  # ── ASTRO RPN — Card ────────────────────────────────────

 
  @US_CA_30
  @FR_CA_4_1
  @FR_CA_4_7
  @Phase2
  Scenario: ASTRO RPN bill payment — card funding
    Given the agent enters the ASTRO RPN account and Biller Inquiry passes
    When the customer inserts their ATM card and enters their PIN on the hardware PIN pad
    Then the app fires POST /api/v1/bill/pay (billerCode=ASTRO, fundingSource=CARD_EMV)
    And a Biller Receipt is issued

  # ── TM RPN — Cash ────────────────────────────────────────

 
  @US_CA_31
  @FR_CA_4_1
  @FR_CA_4_8
  @Phase2
  Scenario: TM Unifi bill payment — cash funding
    Given the agent enters the customer's TM account number (Ref-1)
    And the Biller Inquiry confirms validity
    When the agent accepts cash and clicks "Confirm Cash Collected"
    Then the app fires POST /api/v1/bill/pay (billerCode=TM, fundingSource=CASH)
    And a Biller Receipt with TM acknowledgment reference is issued

  # ── TM RPN — Card ────────────────────────────────────────

 
  @US_CA_32
  @FR_CA_4_1
  @FR_CA_4_7
  @Phase2
  Scenario: TM Unifi bill payment — card funding
    Given the TM Biller Inquiry passes
    When the customer inserts their ATM card and enters their PIN on the hardware PIN pad
    Then the app fires POST /api/v1/bill/pay (billerCode=TM, fundingSource=CARD_EMV)
    And a Biller Receipt is issued

  # ── EPF Contribution — Cash ──────────────────────────────

 
  @US_CA_33
  @FR_CA_4_1
  @FR_CA_4_8
  @Phase2
  Scenario: EPF i-SARAAN contribution — cash funding
    Given the agent selects EPF and the customer chooses contribution type (i-SARAAN/i-SURI)
    And the EPF account reference is validated
    When the agent accepts cash and clicks "Confirm Cash Collected"
    Then the app fires POST /api/v1/bill/pay (billerCode=EPF, fundingSource=CASH)
    And an EPF contribution receipt is printed

  # ── EPF Contribution — Card ──────────────────────────────

 
  @US_CA_34
  @FR_CA_4_1
  @FR_CA_4_7
  @Phase2
  Scenario: EPF i-SARAAN contribution — card funding
    Given the EPF account reference is validated
    When the customer inserts their ATM card and enters their PIN on the hardware PIN pad
    Then the app fires POST /api/v1/bill/pay (billerCode=EPF, fundingSource=CARD_EMV)
    And an EPF receipt is printed

  # ── Prepaid CELCOM — Card ────────────────────────────────

 
  @US_CA_35
  @FR_CA_4_2
  @FR_CA_4_7
  @Phase2
  Scenario: CELCOM prepaid top-up — card funding
    Given the agent enters the customer's CELCOM phone number and it is validated
    When the customer inserts their ATM card and enters their PIN on the hardware PIN pad
    Then the app fires POST /api/v1/topup (telco=CELCOM, fundingSource=CARD_EMV)
    And the top-up is applied instantly to the phone number
    And a Top-Up receipt is printed

  # ── Prepaid M1 — Cash ─────────────────────────────────────

 
  @US_CA_36
  @FR_CA_4_2
  @FR_CA_4_8
  @Phase2
  Scenario: M1 prepaid top-up — cash funding
    Given the agent enters the customer's M1 phone number and it is validated
    When the agent accepts cash and clicks "Confirm Cash Collected"
    Then the app fires POST /api/v1/topup (telco=M1, fundingSource=CASH)
    And the top-up is applied to the M1 number
    And a Top-Up receipt is printed

  # ── Prepaid M1 — Card ─────────────────────────────────────

 
  @US_CA_37
  @FR_CA_4_2
  @FR_CA_4_7
  @Phase2
  Scenario: M1 prepaid top-up — card funding
    Given the M1 phone number is validated
    When the customer inserts their ATM card and enters their PIN on the hardware PIN pad
    Then the app fires POST /api/v1/topup (telco=M1, fundingSource=CARD_EMV)
    And a Top-Up receipt is printed

  # ── Sarawak Pay e-Wallet Withdrawal — Cash ───────────────

 
  @US_CA_38
  @FR_CA_4_6
  @FR_CA_4_8
  @Phase2
  Scenario: Sarawak Pay e-Wallet withdrawal — agent disburses physical cash
    Given the customer provides their Sarawak Pay account identifier
    And the e-Wallet account is validated and has sufficient balance
    When the customer confirms the withdrawal amount on-screen
    Then the app fires POST /api/v1/ewallet/withdraw (wallet=SARAWAK_PAY, fundingSource=CASH)
    And the agent hands over physical cash from their float
    And the agent's float increases (bank credits agent for cash disbursed)

  # ── Sarawak Pay e-Wallet Withdrawal — Card ───────────────

 
  @US_CA_39
  @FR_CA_4_6
  @FR_CA_4_7
  @Phase2
  Scenario: Sarawak Pay e-Wallet withdrawal — card authentication
    Given the customer provides their Sarawak Pay account identifier
    When the customer inserts their ATM card and enters their PIN on the hardware PIN pad
    Then the app fires POST /api/v1/ewallet/withdraw (wallet=SARAWAK_PAY, fundingSource=CARD_EMV)
    And the agent hands over physical cash

  # ── Sarawak Pay e-Wallet TOP-UP — Cash ───────────────────

 
  @US_CA_40
  @FR_CA_4_6
  @FR_CA_4_8
  @Phase2
  Scenario: Sarawak Pay e-Wallet top-up — customer pays cash to agent
    Given the customer provides their Sarawak Pay account identifier
    When the agent accepts cash from the customer and clicks "Confirm Cash Collected"
    Then the app fires POST /api/v1/ewallet/topup (wallet=SARAWAK_PAY, fundingSource=CASH)
    And the agent's float decreases (agent is now holding bank's money)
    And the customer's Sarawak Pay e-Wallet is credited

  # ── Sarawak Pay e-Wallet TOP-UP — Card ───────────────────

 
  @US_CA_41
  @FR_CA_4_6
  @FR_CA_4_7
  @Phase2
  Scenario: Sarawak Pay e-Wallet top-up — card funding
    Given the customer provides their Sarawak Pay account identifier
    When the customer inserts their ATM card and enters their PIN on the hardware PIN pad
    Then the app fires POST /api/v1/ewallet/topup (wallet=SARAWAK_PAY, fundingSource=CARD_EMV)
    And the customer's Sarawak Pay e-Wallet is credited

  # ── eSSP Purchase — Cash ─────────────────────────────────

 
  @US_CA_42
  @FR_CA_4_6
  @FR_CA_4_8
  @Phase2
  Scenario: eSSP certificate purchase — cash funding
    Given the agent selects eSSP and enters the customer's NRIC and eSSP certificate type
    When the customer pays physical cash to the agent
    And the agent clicks "Confirm Cash Collected"
    Then the app fires POST /api/v1/essp/purchase (fundingSource=CASH)
    And a printed eSSP Certificate Slip is issued to the customer
    And the agent's float decreases

  # ── eSSP Purchase — Card ──────────────────────────────────

 
  @US_CA_43
  @FR_CA_4_6
  @FR_CA_4_7
  @Phase2
  Scenario: eSSP certificate purchase — card funding
    Given the eSSP certificate type and NRIC are entered and validated
    When the customer inserts their ATM card and enters their PIN on the hardware PIN pad
    Then the app fires POST /api/v1/essp/purchase (fundingSource=CARD_EMV)
    And a printed eSSP Certificate Slip is issued

  # ── PIN Purchase — Card ───────────────────────────────────

 
  @US_CA_44
  @FR_CA_9_2
  @FR_CA_4_7
  @Phase2
  Scenario: PIN Purchase (digital voucher) — card funding
    Given the agent selects "PIN Purchase" and chooses the voucher type (e.g., Digi RM 10)
    When the customer inserts their ATM card and enters their PIN on the hardware PIN pad
    Then the app fires POST /api/v1/retail/pin-purchase with fundingSource=CARD_EMV
    And the agent's float decreases by RM 10
    And the terminal prints a slip with the 16-digit PIN code
    And the agent earns a commission on the sale

  # ── Card-Funded Services — Generic Validation ────────────

 
  @US_CA_26
  @US_CA_30
  @FR_CA_4_7
  @Phase2
  Scenario: Card-funded service — DUKPT PIN entry always before API call
    Given any card-funded service (bill, top-up, eSSP, Sarawak Pay, PIN voucher)
    When the service-specific validation (Ref-1 or phone check) has passed
    Then the hardware PIN pad is activated ONLY AFTER validation
    And the app sends the encrypted PIN block via DUKPT in the API request body
    And the agent NEVER has access to the raw PIN

  # ── Cash-Funded Services — Generic Validation ────────────

 
  @US_CA_07
  @US_CA_08
  @FR_CA_4_8
  @Phase2
  Scenario: Cash-funded service — MyKad required for large cash collections
    Given any cash-funded service where the agent collects > RM 3,000 in cash
    When the Agent clicks "Confirm Cash Collected"
    Then the app interrupts and requires a MyKad scan to record the customer's identity for AML
    And only then submits the API call with the MyKad reference number
