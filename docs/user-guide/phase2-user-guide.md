# Agent Banking Channel — Phase 2 User Guide

Welcome to the Phase 2 update of the Agent Banking Channel application. This guide covers the new financial services, merchant features, and compliance mechanisms introduced in this release.

## 1. DuitNow Transfer (3-Proxy Support)
You can now facilitate DuitNow transfers using three types of Proxy IDs.

**Steps:**
1. Select **DuitNow Transfer** from the main menu.
2. Choose the **Proxy Type**: Mobile Number, MyKad (NRIC), or Business Registration Number (BRN).
3. Enter the **Proxy ID**.
4. The app will perform a **Proxy Enquiry** to display the masked recipient name for verification.
5. Confirm the amount and funding source (Cash or Card).
6. **Polling**: For DuitNow-to-DuitNow transfers, the app will enter a "Waiting for Customer Approval" state. The customer must approve the request on their banking app within 3 minutes.
7. Once approved, the receipt will be generated automatically.

## 2. Extended Financial Services (Card-Funded)
Most financial services (Bill Payment, Top-Up, Sarawak Pay, eSSP) now support **Card Funding**.

**Steps:**
1. Select the desired service (e.g., **Bill Payment**).
2. Enter the transaction details (Biller Code, Reference Number).
3. Under **Funding Source**, select **Card**.
4. The terminal will first validate the service details with the bank.
5. Once validated, you will be prompted to **Insert/Swipe Card**.
6. The customer must enter their **PIN** on the secure PIN pad.
7. The transaction will process, and a receipt will be printed upon success.

> [!IMPORTANT]
> **Large Cash AML Check**: For cash-funded transactions exceeding **RM 3,000**, the app will require a **MyKad Scan** of the customer before proceeding.

## 3. Merchant Services
Transform your terminal into a retail Point of Sale (POS) system.

### DuitNow QR (Card/Account)
- **Status**: *Planned for Future Release*
- This feature is currently in design and will be enabled once the Switch API supports QR payload generation.

### Retail Sale (Card)
- **Steps**: Enter the sale amount, select **Card**, and follow the standard Card + PIN flow. Receipts are generated instantly upon bank approval.

### Cash-Back Hybrid
Customers can now purchase items and withdraw cash in a single transaction.
1. Select **Cash-Back**.
2. Enter the **Purchase Amount** (e.g., RM 20) and the **Cash-Back Amount** (e.g., RM 50).
3. The customer swipes their card once and enters their PIN for the total amount (RM 70).
4. Hand the cash (RM 50) and the goods (RM 20) to the customer. The receipt will show the split breakdown.

### PIN Purchase (Card)
Sell prepaid vouchers (Digi, Maxis, etc.) using card funding. The 16-digit PIN will be printed directly on the receipt.

## 4. Compliance & Terminal Locking
To ensure regulatory compliance, the terminal may be remotely frozen by the bank.

- **Frozen State**: If the terminal is locked, you will see a "Compliance Locked" screen. No transactions can be performed.
- **Auto-Unlock**: The terminal polls the bank every 5 minutes. Once the compliance issue is resolved at the bank level, the terminal will **automatically unlock** without requiring an app restart.

## 5. End-of-Day (EOD) Settlement
- **23:55 Banner**: A warning banner will appear at 23:55 MYT to remind you that the day's window is closing.
- **23:59:59 Lockout**: At exactly 23:59:59 MYT, all transactions will be disabled until the backend completes the settlement process.
- **Re-enabling**: Once settlement is complete (usually within minutes), the terminal will re-enable for the new business day.

## 6. Agent Self-Onboarding
New micro-agents can now onboard themselves through the app.
1. Select **Register as Agent**.
2. Scan your **MyKad**.
3. Perform a **Liveness Check** (Face scan).
4. Enter your **SSM Number**.
5. **Instant Activation**: Most agents are activated instantly (STP). If an AML flag is triggered, your application will go into "Manual Review," and you will be notified once approved.
