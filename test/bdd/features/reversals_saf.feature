Feature: Store & Forward _ Reversals and Retries
  
  Background:
    Given the agent is logged in with an active session

  @US_CA_15
  @FR_CA_7_1
  @FR_CA_7_2
  @MVP
  Scenario: ZERO retries on financial authorization — immediate reversal on timeout
    Given the agent is logged in and active
    And a Cash Withdrawal authorization request is sent to the backend
    When the backend does not respond within the timeout threshold (25 seconds)
    Then the app does NOT retry the financial request
    And immediately queues an MTI 0400 Reversal payload with the original X_Idempotency_Key
    And the Agent Float is NOT manually adjusted locally


  @US_CA_15
  @FR_CA_7_3
  @MVP
  Scenario: Printer jam after HTTP 200 triggers automatic MTI 0400 Reversal
    Given the agent is logged in and active
    And the backend returned HTTP 200 OK for a Cash Withdrawal
    When the physical POS printer detects "Out Of Paper" or "Paper Jam"
    Then the app queues an MTI 0400 Reversal Payload in the encrypted SQLite queue
    And the Agent Float is NOT adjusted locally — defers to backend resolution


  @US_CA_15
  @FR_CA_7_4
  @MVP
  Scenario: Store & Forward re-transmits reversal every 60 seconds via X-Idempotency-Key
    Given an MTI 0400 Reversal is queued in the encrypted offline store
    When the POS recovers network connectivity
    Then the app continuously retries the reversal every 60 seconds
    And uses the original X-Idempotency-Key to prevent duplicate reversals
    And permanently clears the SQLite cache upon HTTP 200 Reversal confirmation


  @US_CA_15
  @FR_CA_7_5
  @MVP
  Scenario: Non_financial requests use exponential backoff
    Given the agent is logged in and active
    And a non_financial request (e.g., Balance Inquiry, ProxyEnquiry) fails
    When the app retries the request
    Then it uses exponential backoff: 1s wait, then 2s, then 4s
    And makes a maximum of 3 retry attempts before displaying an error
