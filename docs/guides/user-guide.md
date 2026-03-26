# Agent Banking Channel - User Guide

This guide provides operational instructions for Bank Agents using the Agent Banking POS Terminal.

## 🔑 1. Secure Login
1.  Launch the **Agent Banking** app.
2.  **Primary Method**: Enter your **Agent ID** and **Secure Password**.
    - *Test credentials*: Agent ID: `AGENT01`, Password: `123456`
3.  **Quick Method**: Tap **Biometric Quick Login** to use the terminal's registered biometric profile.
4.  Upon successful verification, you will see the **Main Dashboard**.
    - *Note: For security, three failed attempts will temporarily lock the terminal.*

## 💸 2. Performing Transactions (Withdrawals/Deposits)
The terminal uses a **Dual-Handshake** process to ensure security for both Agent and Customer.

1.  Select the desired service (e.g., **Cash Withdrawal**).
2.  Enter the amount and tap **Get Quote**.
3.  **Handshake 1 (Agreement)**: Show the screen to the customer to confirm the amount and fees. Tap **Confirm** once the customer agrees.
4.  **Handshake 2 (Hardware)**: 
    - Ask the Customer to insert their ATM Card.
    - Ask the Customer to enter their PIN on the pin-pad.
5.  Wait for **Transaction Successful** message and print the receipt.

## 👤 3. New Customer Onboarding (e-KYC)
Agents can open new accounts for customers without them visiting a bank branch.

1.  Select **New Account Opening** from the dashboard.
2.  **Scan MyKad**: Insert or tap the customer's MyKad when prompted. Do not remove until the "Read Complete" message appears.
3.  **Verification**: The system will automatically perform AML and identity checks.
4.  **Product Selection**: Ask the customer which account type they prefer (Savings-i or Current-i).
5.  Tap **Open Account** to finalize.

## 📶 4. Offline Mode & Sync
If the terminal loses internet connectivity, it will switch to **Offline Mode**.

- **Indicators**: A yellow "OFFLINE" badge will appear at the top.
- **Queuing**: Transactions can still be performed. They will be stored in the secure **Store & Forward** queue.
- **Syncing**: Once connectivity is restored, the terminal will automatically upload pending transactions in the background. Tap the status badge to see the sync progress.

## 🔒 5. Compliance Freeze
If the terminal detects a security anomaly or receives a remote lock command from the Bank:

- The screen will turn **RED** and display **TERMINAL LOCKED**.
- No transactions or navigation can be performed.
- Provide the **Error Code** to your Bank Manager to request a remote unlock.

---
**Security Reminder:** Never share your supervisor PIN or bypass biometric prompts. All actions are audited.
