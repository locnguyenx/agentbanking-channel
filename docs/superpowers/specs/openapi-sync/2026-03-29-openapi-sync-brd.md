# OpenAPI Client Generation & Full Contract Enforcement BRD

## 1. Business Goal
Achieve 100% compliance with the Agent Banking Platform v1.0.0 OpenAPI specifications. Eliminate all API contract drift by entirely deprecating handwritten API models and manual endpoint mappings across the channel application in favor of a universally generated API client.

## 2. User Stories & Functional Requirements

### 2.1 Complete API Generation & Deprecation
* **US-01:** As a developer, I want all frontend interactions to be exclusively driven by the `openapi.yaml` file so there are zero manual network DTOs in the codebase.
* **FR-01:** Integrate `openapi-generator-cli` (dart-dio) to generate the full suite of API clients.
* **FR-02:** Deprecate and remove all handwritten response and request models across `features/transactions`, `features/kyc`, `features/merchant`, and `features/biller`.

### 2.2 Ledger Service Synchronization
* **US-02:** As an agent processing financial movements, I want the channel app to use the officially generated schemas so that all required validations (like location routing or fees) are met.
* **FR-03:** Refactor Withdrawals, Deposits, Balance Inquiries, and Agent Balance retrieval to strictly adopt the generated models (e.g., `WithdrawalRequest` requiring `geofenceLat`, `customerCardMasked`, `idempotencyKey`).
* **FR-04:** Refactor Retail Services (Retail Sale, Pin Purchase, Cashback) to utilize the new OpenAPI-defined endpoints instead of custom paths.

### 2.3 Biller, Switch & Onboarding Service Integration
* **US-03:** As an agent providing third-party services, I want all biller and onboarding interactions to seamlessly follow the unified OpenAPI definitions.
* **FR-05:** Refactor Biller services (Bill Pay, Transferred Topups, eWallet Withdraw/Topup, ESSP purchase) using the generated client.
* **FR-06:** Refactor DuitNow (Switch) services using the generated client.
* **FR-07:** Refactor Onboarding logic (KYC verification, Biometric checks) using the generated client.
