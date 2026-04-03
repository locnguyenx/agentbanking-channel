Feature: 31 Core Services Orchestration Validation
  
  Background:
    Given the agent is logged in with an active session

  @US_CA_11
  @FR_CA_4_3
  @MVP
  Scenario: Cash Deposit — ProxyEnquiry masked name verification
    Given the agent types a destination account number
    When the app queries the backend ProxyEnquiry
    Then the customer display shows a masked recipient name like "MOHD A***D BIN AL*"
    And the customer must verbally or digitally confirm ownership before funds are collected


  @US_CA_03
  @FR_CA_4_4
  @MVP
  Scenario: Client_side withdrawal limit pre_check
    Given the customer requests a Cash Withdrawal of RM 6,000
    When the app performs the client_side limit pre_check
    Then the app detects a breach of the RM 5,000 per_transaction hard cap
    And displays "ERR_VAL_AMOUNT_EXCEEDS_LIMIT: Maximum RM 5,000 per transaction"
    And does NOT call the backend API


  @US_CA_07
  @FR_CA_4_1
  @Phase2
  Scenario: Bill Payment — JomPAY Ref_1 validation
    Given the agent selected the Bill Payment feature
    When the agent keys in the customer's Ref_1 account number
    Then the app executes a Biller Inquiry pre_check against the backend
    And proceeds or blocks the financial handshake based on the real_time API response


  @US_CA_08
  @FR_CA_4_2
  @Phase2
  Scenario: Prepaid Top_Up — invalid phone number blocked
    Given the agent selected Prepaid RM 50 (CELCOM)
    When the agent keys in an invalid phone number format "019999999X"
    Then the app blocks the financial handshake immediately
    And displays "ERR_VAL_INVALID_PHONE_FORMAT"


  @US_CA_08
  @FR_CA_4_2
  @Phase2
  Scenario: Prepaid Top_Up — Telco API rejects number
    Given the agent selected Prepaid RM 50 (CELCOM)
    And the agent entered a correctly formatted phone number
    When the Telco API pre_check returns a rejection
    Then the app blocks the financial handshake
    And displays "ERR_EXT_BILLER_UNAVAILABLE" or "Number not found"
