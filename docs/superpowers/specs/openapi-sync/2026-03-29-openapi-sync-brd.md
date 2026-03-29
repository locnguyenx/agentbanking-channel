# OpenAPI Client Generation & Contract Enforcement BRD

## 1. Business Goal
Ensure strict API contract adherence by aligning the Agent Banking Channel frontend with the new v1.0.0 Backend OpenAPI specifications, permanently eliminating integration drift.

## 2. User Stories & Functional Requirements

### 2.1 API Generation
* **US-01:** As a developer, I want the channel app build process to use an OpenAPI generator (like `openapi-generator-cli` with `dart-dio`) to automatically generate API clients and Data Models from `docs/api/openapi.yaml`.
* **FR-01:** Integrate `openapi-generator-cli` into the Flutter project (via a script or build tools).
* **FR-02:** Generate Dart data classes and Dio API client services based on `docs/api/openapi.yaml`.

### 2.2 Adapter Refactoring
* **US-02:** As a developer, I want the manually written REST calls in the application to be replaced with calls to the generated API endpoints so that we rely entirely on the generated contract.
* **FR-03:** Refactor `TransactionRepository` endpoints (e.g., `/api/v1/withdrawal`, `/api/v1/deposit`) to use the new generated API client.

### 2.3 Data Alignment
* **US-03:** As an agent, I want the channel app's transaction execution logic to capture and supply the new required fields required by the updated backend API specs so that transactions do not fail validation.
* **FR-04:** For Withdrawals (`CASH_WITHDRAWAL`), capture and pass `geofenceLat`, `geofenceLng`, and `customerCardMasked` values to the generated `WithdrawalRequest`.
* **FR-05:** For Deposits (`CASH_DEPOSIT`), capture and pass `destinationAccount` to the generated `DepositRequest`.
