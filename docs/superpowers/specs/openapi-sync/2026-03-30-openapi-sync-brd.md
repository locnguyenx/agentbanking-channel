# BRD: OpenAPI Synchronization & Form Validation

## 1. Business Goal
Achieve 100% compliance with the new explicit schemas defined in the Agent Banking Platform OpenAPI (`openapi.yaml`). This ensures strict contract adherence, enforces UI-level data validation before API submission, and integrates new endpoints safely without disrupting existing functionality.

## 2. User Stories
* **US-01 (API Gen)**: As a developer, I want to replace handwritten API models and clients with automatically generated ones from `openapi.yaml` to eliminate contract drift.
* **US-02 (Reusable Validation)**: As an agent, I want the UI forms to instantly validate my inputs (e.g., minimum, maximum amounts, field lengths) against the exact limits enforced by the Backend, so I don't submit invalid transactions.
* **US-03 (Existing Feature Parity)**: As an agent processing ledger or biller transactions, I want the correct generated API formats utilized so my requests don't fail validation.
* **US-04 (New Endpoint Support)**: As a product manager, I want the channel app to fully support newly introduced backend endpoints (JomPay, MyKad Verification, Full Onboarding Submit) to unlock these features for agents.

## 3. Functional Requirements
* **FR-01**: Utilize `scripts/generate_api.sh` to construct the `agent_api` package containing explicit request/response schema models.
* **FR-02**: Implement generic OpenAPI-compliant validators for Flutter `TextFormField`s matching the spec's `minimum`, `maximum`, and `maxLength` constraints.
* **FR-03**: Refactor current Ledger, Biller, and Switch forms (Withdrawal, Deposit, Bill Pay, DuitNow, etc.) to use the newly generated clients and validation constraints.
* **FR-04**: Design and build out the UI flows, State Notifiers, and service integration for JomPay, MyKad Verification, and Application Submission.
