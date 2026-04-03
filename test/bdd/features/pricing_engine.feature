Feature: Parameter Engine
  
  Background:
    Given the agent is logged in with an active session

  @US_CA_06
  @FR_CA_2_1
  @MVP
  Scenario: Transaction initiates fee engine quote API call
    Given the agent has entered all required transaction inputs
    When the agent taps "Proceed"
    Then the app automatically pauses the workflow
    And calls backend POST /api/v1/transactions/quote
    And displays a loading indicator while awaiting the fee response


  @US_CA_06
  @FR_CA_2_2
  @MVP
  Scenario: Customer explicitly consents to the transaction fee
    Given the app has retrieved the transaction quote successfully
    When the Dual_Handshake begins
    Then the customer_facing display prominently shows:
      """
      Principal: RM 500.00 | Fee: RM 1.00 | Total Deducted: RM 501.00
      """
    And blocks hardware PIN entry until the customer taps "Agree"


  @US_CA_06
  @FR_CA_2_3
  @MVP
  Scenario: Agent views commission earned — never shown on customer display
    Given the app has retrieved the transaction quote successfully
    When the Dual_Handshake begins
    Then the agent_facing display shows "Estimated Commission: RM 0.50"
    And this commission value is NEVER shown on the customer_facing display


  @US_CA_06
  @FR_CA_2_1
  @MVP
  Scenario: STP hard cap pre_check blocks over_limit transaction
    Given a customer requests a transaction of RM 4,000
    When the app performs the client_side STP hard cap pre_check
    Then the app blocks the transaction before calling /quote
    And displays "ERR_VAL_AMOUNT_EXCEEDS_LIMIT: Maximum RM 3,000 per STP transaction"
