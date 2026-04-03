Feature: Merchant Services (Retail, PIN, Cash_Back)
  
  Background:
    Given the agent is logged in with an active session

  @US_CA_17
  @FR_CA_9_1
  @FR_CA_9_4
  @Phase2
  Scenario: Retail Sale — agent accepts card payment as merchant
    Given the agent enters "Merchant Mode" on the POS
    And the customer pays RM 100 for groceries by inserting their card and entering PIN
    When the card authorization succeeds
    Then the backend credits the agent's float with RM 99.00 (RM 100 minus 1% MDR = RM 1.00)
    And the app shows "Float credited: RM 99.00 | MDR: RM 1.00"
    And a Sales Receipt is issued to the customer


  @US-CA-17
  @FR_CA_9_1
  @Phase2
  Scenario: Retail Sale — agent accepts DuitNow QR payment
    Given the agent is in Merchant Mode
    And the terminal generates a Dynamic QR Code for RM 50
    When the customer scans the QR code with their banking app and confirms payment
    Then PayNet notifies the backend
    And the agent's float is credited with RM 50 minus MDR
    And a Sales Receipt is issued


  @US_CA_18
  @FR_CA_9_2
  @FR_CA_9_5
  @Phase2
  Scenario: PIN Voucher Purchase — agent sells digital voucher for cash
    Given the agent selects "PIN Purchase" and chooses "DIGI RM 10"
    When the customer pays RM 10 physical cash to the agent
    And the agent confirms "Cash Received"
    Then the system debits the agent's float by RM 10
    And the terminal prints a slip with the 16_digit PIN code
    And the agent earns a commission on the sale


  @US_CA_19
  @FR_CA_9_3
  @Phase2
  Scenario: Cash_Back Hybrid — single card swipe for purchase + cash_back
    Given the customer wants to buy RM 20 of goods AND get RM 50 cash_back
    When the agent swipes the customer's card for RM 70 total
    And the customer enters their PIN
    Then the backend performs split accounting automatically:
      | "Purchase Amount" | "RM 20 credited to merchant sale" |
      | "Cash_Back Amount"| "RM 50 to be handed over by agent" |
    And the agent's float movement reflects the net position
    And a combined Sales + Cash_Back Receipt is issued
