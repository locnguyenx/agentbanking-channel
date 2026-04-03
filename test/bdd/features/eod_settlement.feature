Feature: EOD Cut_Off Operations


  @US_CA_22
  @FR_CA_8_2
  @Phase2
  Scenario: 23:55 MYT warning displayed to agent
    Given the POS terminal local clock reaches 23:55:00 MYT
    When the agent is logged in and active
    Then the app displays a warning banner:
      "End of Day Settlement initiates in 5 minutes. Please wrap up."


  @US_CA_22
  @FR_CA_8_3
  @Phase2
  Scenario: 23:59:59 MYT — all STP financial workflows disabled
    Given the POS terminal local clock reaches 23:59:59 MYT
    When the agent attempts to initiate any financial transaction
    Then all STP workflows are disabled
    And the UI shows "Settlement in progress... Please wait."


  @US_CA_22
  @FR_CA_8_4
  @Phase2
  Scenario: Settlement finalization notification re_enables operations
    Given the terminal is in the "Settlement in progress" state
    When the backend signals settlement finalization (expected by 02:00 AM MYT)
    Then the app displays "Settlement complete. New business day has started."
    And all STP financial workflows are re_enabled
