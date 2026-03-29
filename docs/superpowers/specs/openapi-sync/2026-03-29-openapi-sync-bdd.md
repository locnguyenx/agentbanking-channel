# OpenAPI Client Generation & Contract Enforcement BDD

## 1. Infrastructure Settings
**Scenario 1: Code generation succeeds and legacy DTOs are removed**
* **Given** the `docs/api/openapi.yaml` (v1.0.0) spec is present
* **When** the developer runs the generator script
* **Then** the Dart codebase receives completely generated ApiClient classes for Ledger, Onboarding, Biller, and Switch services
* **And** all legacy hand-written DTOs are successfully removed from the codebase without compilation failures.

## 2. Ledger Service Endpoints
**Scenario 2: Process Cash Withdrawal with new fields**
* **Given** an Agent initiates a Cash Withdrawal
* **When** the channel application processes the request
* **Then** the application populates the generated `WithdrawalRequest` model, explicitly mapping new fields like `geofenceLat` and `customerCardMasked`
* **And** successfully calls the generated `LedgerApi` endpoint.

**Scenario 3: Process Cash Deposit with new fields**
* **Given** an Agent initiates a Cash Deposit
* **When** the channel application processes the request
* **Then** the application populates the generated `DepositRequest` model, mapping `destinationAccount`
* **And** successfully calls the generated API endpoint.

**Scenario 4: Retrieve Balances**
* **Given** an Agent checks balances
* **When** the channel app requests the data
* **Then** it strictly uses the generated API models to fetch and parse the data.

**Scenario 5: Process Retail Sale, PIN, and Cashback**
* **Given** an Agent processes retail products
* **When** the channel app triggers the transaction
* **Then** it strictly integrates with the generated `retailSale`, `pinPurchase`, and `cashback` endpoints rather than using custom paths.

## 3. Biller Service Endpoints
**Scenario 6: Process Biller and Prepaid Transactions**
* **Given** an Agent provides third party sales (Bill Pay, Prepaid Topup, eWallet, ESSP)
* **When** the channel app fires the request
* **Then** it delegates to the strictly typed generated `BillerApi` models instead of a generic transaction execution path.

## 4. Switch Service (DuitNow)
**Scenario 7: DuitNow Transfers**
* **Given** an Agent initiates a DuitNow transfer
* **When** the application calls the backend
* **Then** it strictly leverages the generated `SwitchApi` DuitNow DTOs.

## 5. Onboarding Service
**Scenario 8: KYC Checks**
* **Given** an Agent submits Identity or Biometric details
* **When** the application verifies the data
* **Then** it strictly delegates to the generated `OnboardingApi`.
