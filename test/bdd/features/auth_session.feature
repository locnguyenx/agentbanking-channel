Feature: Agent Authentication and Session


  @US_CA_01

  @FR_CA_1_1

  @MVP
  Scenario: Agent logs in with valid biometric
    Given the channel app is launched on a whitelisted device
    When the agent authenticates using fingerprint biometrics
    Then a JWT session is created and stored securely
    And the agent is navigated to the home screen
    And the UI displays the agent's pre_funded Float Ledger balance


  @US_CA_01

  @FR_CA_1_1

  @MVP
  Scenario: Device not whitelisted is rejected on login
    Given the agent's device MAC Address is not whitelisted in the backend
    When the agent attempts to log in
    Then the login is rejected with error code "ERR_AUTH_DEVICE_NOT_WHITELISTED"
    And the session is not created


  @US_CA_01

  @FR_CA_1_3

  @MVP
  Scenario: Session expires during idle — non_blocking re_auth
    Given the agent is logged in with an active session
    When two hours of inactivity has elapsed
    Then the app shows a non_blocking "Session expired" dialog
    And allows the agent to re_authenticate without losing transaction context


  @US_CA_01
  @FR_CA_1_3
  @MVP
  Scenario: Session expires mid-transaction
    Given the agent is in the middle of a pricing quote workflow
    When the system detects an expired JWT token
    Then the app shows a non_blocking "Session expired — please re_authenticate" overlay
    And resumes the transaction flow after successful re_authentication


  @US_CA_01
  @FR_CA_1_3
  @MVP
  Scenario: Secure logout clears all sensitive data
    Given the agent is logged in with an active session
    When the agent logs out
    Then the JWT token is deleted from secure storage
    And all session state is cleared
    And the app returns to the login screen
