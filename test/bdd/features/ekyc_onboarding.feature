Feature: e_KYC Verification and Face AI
  
  Background:
    Given the agent is logged in with an active session

  @US_CA_12
  @FR_CA_5_1
  @MVP
  Scenario: Scan MyKad OCR/Chip
    Given an unregistered customer wants to open an account
    When the agent inserts the MyKad into the Smart Card Reader
    Then the OCR/Chip_read extracts Name, IC Number, and Address


  @US_CA_12
  @FR_CA_5_2
  @MVP
  Scenario: Happy Path — Biometric Match_on_Card succeeds
    Given an unregistered customer wants to open an account
    And the MyKad data is extracted successfully
    When the customer presses their thumb on the Biometric Peripheral
    Then a verified "MATCH" status is returned from the hardware
    And the app proceeds to send the payload to /api/v1/kyc/verify


  @US_CA_13
  @FR_CA_5_3
  @MVP
  Scenario: Failed thumbprint triggers Face AI Liveness Fallback
    Given an unregistered customer wants to open an account
    And the Match_on_Card thumbprint check returns "NO_MATCH" or "FAILED"
    When the app transitions state
    Then the POS frontal camera activates immediately
    And prompts the customer "Please Blink Twice" for Video Liveness capture


  @US_CA_13
  @FR_CA_5_4
  @MVP
  Scenario: Payload dispatched to KYC endpoint for 3rd-party & AML
    Given an unregistered customer wants to open an account
    And the Liveness video blob is captured
    When the app triggers POST /api/v1/kyc/verify with GPS coordinates
    Then the backend routes the media to the configured KYC provider (Innov8tif/Jumio)
    And concurrently runs an AML Sanctions check


  @US_CA_14
  @FR_CA_5_5
  @MVP
  Scenario: AUTO_APPROVED routes directly to initial deposit collection
    Given an unregistered customer wants to open an account
    And the KYC payload returns status "AUTO_APPROVED"
    When the app handles the HTTP 200 OK response
    Then it bypasses the main menu and forces an initial Cash Deposit collection flow
    And provisions the Core Savings Account within the same session


  @US_CA_14
  @FR_CA_5_6
  @MVP
  Scenario: MANUAL_REVIEW stops workflow and notifies customer
    Given an unregistered customer wants to open an account
    And the KYC payload returns status "MANUAL_REVIEW"
    Then the app stops the onboarding workflow
    And informs the customer "Application Queued for Analyst Review. You will be notified via SMS."
