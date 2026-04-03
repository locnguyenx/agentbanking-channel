# Agent Banking Channel — Phase 2 User Guide (STP Release)

This guide provides step-by-step instructions for all features using the **exact labels** you see on the terminal screen.

---

## 1. Core Banking Services
### 1.1 Withdrawal (ATM Card / MyKad)
**Steps:**
1. Tap **Withdrawal** on the dashboard.
2. Select the **Funding Source** at the top:
   - **CARD**: Using Customer's ATM Card.
   - **MYKAD**: Using Customer's MyKad chip + thumbprint.
3. Enter the **Transaction Amount** and tap **GET QUOTE**.
4. Confirm details and follow the hardware prompts (Insert Card/Enter PIN or Biometric Scan).
    - **Note**: Max **RM 5,000** per transaction.
- **Verification**: [Scenario: Cash-Out using ATM Card (EMV chip)](map://US-CA-03)

### 1.2 Deposit (Cash/Card)
**Steps:**
1. Tap **Deposit** on the dashboard.
2. Select the **Funding Source**:
   - **CASH**: Customer gives you physical cash.
   - **CARD**: Amount is deducted from the customer's card.
3. Enter amount and recipient details.
4. If cash, tap **Confirm Cash Received** after collecting money.
- **Verification**: [Scenario: Cash Deposit via Agent Validation](map://US-CA-04)

### 1.3 Inquiry (Balance Check)
**Steps:**
1. Tap **Inquiry** on the dashboard.
2. Customer inserts card and enters PIN.
3. Balance is displayed on the customer-facing screen.
- **Verification**: [Scenario: Balance Inquiry using ATM Card](map://US-CA-23)

---

## 2. Merchant & Retail (Cashless Payment)
### 2.1 Cashless - Debit Card (Terminal)
**Steps:**
1. Tap **Cashless** on the dashboard.
2. Tap **CARD** at the top of the screen.
3. Enter the sale amount and tap **PROCEED**.
4. Follow the Card + PIN flow to complete the sale.
    - **Note**: Max **RM 3,000** per transaction (STP Cap).
- **Verification**: [Scenario: Retail Sale — card payment](map://US-CA-17)

### 2.2 Cashless - QR Code (Scan to Pay)
**Steps:**
1. Tap **Cashless** on the dashboard.
2. Tap **DUITNOW QR** at the top of the screen.
3. Enter the sale amount and tap **PROCEED**.
4. A dynamic QR code appears for the customer to scan.
- **Verification**: [Scenario: Retail Sale — DuitNow QR payment](map://US-CA-17)

---

## 3. Utility & Bill Payments
### 3.1 Bills (ASTRO/TM/EPF)
**Steps:**
1. Tap **Bills** on the dashboard.
2. Select the Biller and enter the account number (Ref-1).
3. Select funding (**CASH** or **CARD**) and follow the prompts.
- **Verification**: [Scenario: bill payment — card/cash funding](map://US-CA-26)

### 3.2 JomPAY
**Steps:**
1. Tap **JomPAY** on the dashboard.
2. Enter **Biller Code**, **Ref-1**, and **Ref-2**.
3. Follow the validation and payment steps.
- **Verification**: [Scenario: JomPAY OFF-US bill payment](map://US-CA-07)

---

## 4. Other Services
### 4.1 Top-up (Prepaid Mobility)
- Tap **Top-up**, select Telco, and enter the mobile number.
- Select funding (**CASH** or **CARD**).
- **Verification**: [Scenario: CELCOM prepaid top-up](map://US-CA-35)

### 4.5 PIN Purchase (Vouchers)
- Tap **eSSP** or a similar services menu.
- Select **PIN Purchase**.
- Enter the **Reference Number** and **Amount**.
- **Verification**: [Scenario: PIN Voucher Purchase](map://US-CA-18)

### 4.6 Cash-Back (Hybrid Mode)
- Tap **Deposit** -> Select **Cash-Back** (if available) or follow the Card-funded flow.
- **Verification**: [Scenario: Cash-Back Hybrid](map://US-CA-19)

### 4.2 Onboard (New Agent)
**Steps:**
1. Tap **Onboard** on the dashboard.
2. Scan Customer MyKad using the card reader.
3. Verify identity via Mobile Number + SMS OTP.
4. Perform Face AI Liveness: Follow prompt **"Please Blink Twice"**.
5. Enter SSM Registration Number and Submit.
- **Verification**: [Scenario: Face AI Liveness Fallback](map://US-CA-13)

### 4.3 E-Wallet (Sarawak Pay)
The Sarawak Pay integration allows for both funding your e-wallet and withdrawing cash from it.

**Steps for Top-up:**
1. Tap **E-Wallet** on the dashboard.
2. Select **TOP-UP** from the transaction type chips.
3. Select **Funding Source** (CASH or CARD).
4. Enter the **Mobile Number** registered with Sarawak Pay.
5. Enter the **Amount** (Min RM 1.00, Max RM 1,000.00).
6. Tap **TOP-UP NOW** and follow the confirmation flow.
- **Verification**: [Scenario: Sarawak Pay e-Wallet top-up](map://US-CA-40)

**Steps for Withdrawal:**
1. Tap **E-Wallet** on the dashboard.
2. Select **WITHDRAW** from the transaction type chips.
3. Enter the **Mobile Number**.
4. Enter the **Amount** to withdraw.
5. Tap **WITHDRAW NOW**.
6. Follow the OTP/Confirmation steps as prompted.
- **Verification**: [Scenario: Sarawak Pay e-Wallet withdrawal](map://US-CA-38)

### 4.4 eSSP Purchase
- Tap **eSSP** on the dashboard.
- Enter the **MyKad / Account Number** and **Amount**.
- Tap **PURCHASE** and confirm.
- **Verification**: [Scenario: eSSP certificate purchase](map://US-CA-42)

