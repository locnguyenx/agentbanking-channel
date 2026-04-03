Feature: Micro_Agent STP Self_Onboarding


  @US_CA_20
  @FR_CA_10_1
  @FR_CA_10_2
  @FR_CA_10_3
  @Phase2
  Scenario: Micro_Agent STP self_onboarding — all checks pass
    Given a prospective Micro_Agent opens the self_onboarding flow on the POS
    When the applicant completes MyKad OCR scan, liveness video, and enters their SSM number
    And the backend fires concurrent checks: JPN identity (PASS), SSM active (PASS), AML (CLEAN)
    Then the app shows "Agent ID Activated. Float account created."
    And no bank officer is required at any step


  @US_CA_20
  @FR_CA_10_4
  @Phase2
  Scenario: Micro_Agent self_onboarding — AML flag routes to manual review
    Given a prospective Micro_Agent completes the onboarding form
    When the backend AML check returns a potential flag
    Then the app shows "Application queued for review. A bank officer will contact you shortly."
    And the POS returns to the idle screen
