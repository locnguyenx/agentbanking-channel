Feature: Dual_Handshake Payment Execution
  
  Background:
    Given the agent is logged in with an active session

  @US_CA_03
  @FR_CA_3_1
  @MVP
  Scenario: Cash_Out using ATM Card (EMV chip)
    And the customer agreed to the Principal + Fee amount on their display
    When the customer inserts their EMV card into the hardware reader
    And enters their PIN on the hardware PIN pad
    Then the POS hardware encrypts the PIN block via DUKPT immediately
    And the app fires POST /api/v1/withdrawal
    And the agent NEVER sees or has access to the customer's PIN


  @US_CA_04
  @FR_CA_3_2
  @MVP
  Scenario: Cash Deposit via Agent Validation (Physical Cash)
    And the transaction is a Cash Deposit and the destination is verified via ProxyEnquiry
    When the app prompts the agent for physical confirmation
    Then the UI requires the agent to click "Confirm Cash Received"
    And upon clicking, the backend is notified to credit the destination account
    And the customer receives an SMS receipt from the backend notification gateway


  @US_CA_04
  @FR_CA_3_2
  @MVP
  Scenario: Cash Deposit > RM 3,000 requires MyKad biometric scan
    And the customer deposits physical cash of RM 3,500
    When the transaction amount exceeds the RM 3,000 STP threshold
    Then the app forces a MyKad biometric scan to unmask customer identity for AML


  @US_CA_05
  @FR_CA_3_3
  @FR_CA_3_4
  @Phase2
  Scenario: DuitNow transfer using Mobile Number proxy
    And the customer's funding source is DuitNow
    And the customer provides a Mobile Number as their DuitNow proxy
    When the agent submits the transfer request
    Then the backend fires a Push Notification to the customer's Mobile Banking App
    And the terminal enters "Waiting for Customer Approval" polling state
    When the customer approves on their smartphone
    Then the terminal receives confirmation and completes the transaction


  @US_CA_05
  @FR_CA_3_3
  @FR_CA_3_4
  @Phase2
  Scenario: DuitNow transfer using MyKad Number proxy
    And the customer's funding source is DuitNow
    And the customer provides a MyKad Number as their DuitNow proxy
    When the agent submits the transfer request
    Then the backend resolves the proxy to the registered account
    And the Push Notification is fired to the customer's Mobile Banking App
    And the terminal enters "Waiting for Customer Approval" polling state
    When the customer approves on their smartphone
    Then the terminal receives confirmation and completes the transaction


  @US_CA_05
  @FR_CA_3_3
  @FR_CA_3_4
  @Phase2
  Scenario: DuitNow transfer using Business Registration Number (BRN) proxy
    And the customer's funding source is DuitNow
    And the customer provides a BRN as their DuitNow proxy
    When the agent submits the transfer request
    Then the backend resolves the BRN proxy to the registered business account
    And the Push Notification is fired to the account holder's Mobile Banking App
    And the terminal enters "Waiting for Customer Approval" polling state
    When the customer approves on their smartphone
    Then the terminal receives confirmation and completes the transaction
