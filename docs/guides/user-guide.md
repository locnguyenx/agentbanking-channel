# Agent Banking Channel - User Guide

This guide provides operational instructions for Bank Agents using the Agent Banking POS Terminal.

## 🔑 1. Secure Login
1.  Launch the **Agent Banking** app.
2.  **Primary Method**: Enter your **Agent ID** and **Secure Password**.
    - *Test credentials*: Agent ID: `AGENT01`, Password: `123456`
3.  **Quick Method**: Tap **Biometric Quick Login** to use the terminal's registered biometric profile.
4.  Upon successful verification, you will see the **Main Dashboard**.
    - *Note: For security, three failed attempts will temporarily lock the terminal.*

## 💸 2. Performing Transactions
All financial services follow a standardized confirmation and funding process:

1.  **Select Service**: Choose a service (e.g., **Withdrawal**, **Bill Pay**, **Top-up**).
2.  **📌 Select Funding Source**:
    - **CASH**: Customer pays with physical currency. (Debits Agent Float).
    - **CARD**: Customer pays using their ATM card. (Credits Agent Float).
    - **DUITNOW**: Digital payment via QR/Proxy. Requires **Proxy ID** (Mobile/IC). (Credits Agent Float).
3.  **Enter Details**: Provide service-specific info (Amount, Biller Code, Mobile Number, or DuitNow Proxy).
4.  **Handshake 1 (Agreement)**: Show the quote (including sub-fees) to the customer. Tap **Confirm**.
5.  **Handshake 2 (Execution)**:
    - **If CARD**: Prompt customer to insert card and enter PIN.
    - **If DUITNOW**: Wait for digital polling to confirm Request-for-Payment (RTP) success.
    - **If CASH**: Collect physical cash from the customer.
6.  **Navigation**: Wait for **Success!** and tap **DONE**.

### 2.1 Balance Inquiry (New)
To check a customer's account balance securely:
1.  Tap **Inquiry** from the dashboard.
2.  No amount entry is required. Tap **PROCEED**.
3.  Confirm the inquiry request.
4.  **Security Masking**: The balance is initially hidden as `******` to protect customer privacy in public retail spaces.
5.  **Reveal**: Tap the **Eye Icon** next to the masked balance to display the actual amount.
6.  Tap **DONE** to return to the dashboard.

### 2.2 Services & Integrated Partners
- **Utilities (Bills)**: Pay electricity, water, or telecommunications fees.
- **Mobile (Top-up)**: Instant reloads for Maxis, Digi, and Celcom.
- **e-Wallets**: Full integration with **Sarawak Pay** for top-ups.
- **Special Services**: 
    - **eSSP Purchase**: Premium savings certificate issuance.
    - **PIN Purchase**: Secure vouchers for government services.
- **Banking**: Deposits, Withdrawals, and Balance Inquiries.

## 👤 3. New Customer Onboarding (e-KYC)
1.  Select **New Account Opening** from the dashboard.
2.  **Scan MyKad**: Insert or tap the customer's MyKad when prompted. Do not remove until the "Read Complete" message appears.
3.  **Verification**: The system will automatically perform AML and identity checks.
4.  **Product Selection**: Ask the customer which account type they prefer (e.g., **Savings Account-i**).
5.  **Finalization**: Wait for the "Welcome Aboard!" message.
6.  Tap **BACK TO DASHBOARD** to finalize and reset the onboarding state.

## 📶 4. Offline Mode & Resilience
If the terminal loses internet connectivity, it will switch to **Offline Mode**.

- **Indicators**: A yellow "OFFLINE" badge will appear at the top.
- **Queuing**: Transactions can still be performed. They will be stored in the secure **Store & Forward** queue.
- **Syncing**: Once connectivity is restored, the terminal will automatically upload pending transactions in the background. Tap the status badge to see the sync progress.

## 💰 5. Float & Settlement
Agents must manage their float balance to remain operational:
- **CASH Funding**: Collecting cash from customers **deducts** from your digital float.
- **CARD/DIGITAL Funding**: Processing card/digital payments **adds** to your digital float (Settlement).
- **Commissions**: Earned per-transaction and visible on the main dashboard.

---
**Security Reminder:** Never share your supervisor PIN or bypass biometric prompts. All actions are audited.
