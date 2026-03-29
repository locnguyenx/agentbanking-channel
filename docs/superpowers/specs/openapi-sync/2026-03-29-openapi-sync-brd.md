# OpenAPI Client Generation & Full Contract Enforcement BRD

## 1. Business Goal
Achieve 100% compliance with the Agent Banking Platform v1.0.0 OpenAPI specifications by generating all frontend API clients and deprecating handwritten DTOs.

## 2. User Stories & Functional Requirements

### 2.1 Complete API Generation & Deprecation
* **US-01:** As a developer, I want all frontend API interactions driven by `openapi.yaml` to ensure zero contract drift.
* **FR-01:** Integrate `openapi-generator-cli` (dart-dio) to generate the API client.
* **FR-02:** Remove all handwritten request/response models.

### 2.2 Ledger Service Synchronization
* **US-02:** As an agent processing ledger transactions, I want the correct generated API formats so my requests don't fail validation.
* **FR-03:** Refactor Withdrawals and Deposits to use the generated Ledger client (with `geofenceLat`, etc).
* **FR-04:** Refactor Balance Inquiry and Agent Balance checks using the generated Ledger client.
* **FR-05:** Refactor Retail Sale.
* **FR-06:** Refactor PIN Purchase.
* **FR-07:** Refactor Cashback.

### 2.3 Biller Service Synchronization
* **US-03:** As an agent processing biller transactions, I want the official API contracts used for all prepaid/biller services.
* **FR-08:** Refactor Bill Pay using the generated Biller client.
* **FR-09:** Refactor Prepaid Topup using the generated Biller client.
* **FR-10:** Refactor eWallet Withdraw and Topup using the generated Biller client.
* **FR-11:** Refactor ESSP Purchase using the generated Biller client.

### 2.4 Switch (Transfer) Service Synchronization
* **US-04:** As an agent processing transfers, I want the official Switch API contract used.
* **FR-12:** Refactor DuitNow Transfer using the generated Switch client.

### 2.5 Onboarding Service Synchronization
* **US-05:** As an agent onboarding system, I want official Onboarding API contracts used.
* **FR-13:** Refactor KYC Verification using the generated Onboarding client.
* **FR-14:** Refactor Biometric KYC using the generated Onboarding client.
