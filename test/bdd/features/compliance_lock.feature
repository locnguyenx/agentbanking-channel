Feature: Anti_Smurfing Category 3 Fallbacks
  
  Background:
    Given the agent is logged in with an active session

  @US_CA_16
  @FR_CA_6_1
  @FR_CA_6_2
  @Phase2
  Scenario: Velocity breach immediately locks terminal
    Given an agent initiates their 10th Cash Deposit of RM 2,900 within an hour
    When the backend velocity engine detects deliberate structuring (smurfing)
    Then the API rejects the request with error "ERR_BIZ_COMPLIANCE_FREEZE"
    And the app enters a local "LOCKED" state immediately
    And all financial services are disabled and grayed out
    And a red banner reading "COMPLIANCE REVIEW — Dial 1-800-XXX-XXXX for Support" is permanently displayed


  @US_CA_16
  @FR_CA_6_2
  @FR_CA_6_3
  @Phase2
  Scenario: LOCKED state persists across app restarts
    Given the terminal is in the "LOCKED" compliance state
    When the agent closes and re_opens the app
    Then the LOCKED state is restored from encrypted local storage
    And financial services remain disabled


  @US_CA_21
  @FR_CA_6_4
  @Phase2
  Scenario: Compliance unlock webhook restores STP operations
    Given the terminal is in the "LOCKED" compliance state
    When the backend sends a Compliance Unlock webhook to the app
    Then the app clears the LOCKED flag from encrypted local storage
    And financial services are re_enabled automatically
    And the agent sees "Terminal Unlocked. You may resume operations."
    And no manual app restart is required
