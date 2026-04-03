Feature: Geofence Enforcement


  @US_CA_02
  @FR_CA_1_2
  @MVP
  Scenario: Transaction allowed within 100m geofence
    Given the agent's registered location is at (3.1390, 101.6869)
    And the device GPS shows (3.1395, 101.6872)
    When the agent attempts to initiate any STP transaction
    Then the geofence check passes (distance < 100m)
    And the transaction proceeds to the Dual_Handshake workflow


  @US_CA_02
  @FR_CA_1_2
  @MVP
  Scenario: Transaction blocked outside 100m geofence
    Given the agent's registered location is at (3.1390, 101.6869)
    And the device GPS shows (3.1500, 101.7000)
    When the agent attempts to initiate a transaction
    Then the geofence check fails
    And the app displays error "ERR_VAL_GEOFENCE_BREACH"
    And the transaction is instantly blocked


  @US_CA_02
  @FR_CA_1_2
  @MVP
  Scenario: GPS coordinates sent in all API request headers
    Given the agent is within geofence
    When any transaction request is sent to the backend
    Then the request contains headers:
       | "X_GPS_Latitude" | "Decimal(9,6)" | 
       | "X_GPS_Longitude" | "Decimal(9,6)" | 


  @US_CA_02
  @FR_CA_1_2
  @MVP
  Scenario: GPS unavailable blocks transaction
    Given the device GPS is unavailable (hardware off or denied permission)
    When the agent attempts to initiate a transaction
    Then the app displays "ERR_VAL_GPS_UNAVAILABLE"
    And all STP transactions are blocked until GPS is restored
