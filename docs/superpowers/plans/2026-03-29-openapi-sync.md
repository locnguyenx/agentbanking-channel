# OpenAPI Client Generation & Sync Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Generate 100% of the channel application's API contracts from `docs/api/openapi.yaml` and refactor existing repositories to enforce zero contract drift.

**Architecture:** We will run `openapi-generator-cli` to build a `dart-dio` client into `lib/api/generated/`. We will then inject these strongly-typed APIs into the standard Flutter repositories (Ledger, Biller, Switch, Onboarding) and systematically map domain objects to the new DTOs, culminating in the complete deletion of legacy handwritten models.

**Tech Stack:** Dart, Flutter, Dio, OpenAPI Generator, Riverpod, BuiltValue.

---

### Task 1: API Code Generation Tooling

**BDD Scenarios:** Scenario 1 (Code generation succeeds)
**BRD Requirements:** FR-01 (Integrate openapi-generator-cli)
**User-Facing:** NO

**Files:**
- Create: `scripts/generate_api.sh`
- Modify: `pubspec.yaml`
- Create: `lib/api/generated/` (via script)

- [ ] **Step 1: Write `scripts/generate_api.sh`**
  ```bash
  #!/bin/bash
  npx @openapitools/openapi-generator-cli generate -i docs/api/openapi.yaml -g dart-dio -o lib/api/generated --additional-properties=pubName=agent_api
  cd lib/api/generated && flutter pub get && dart run build_runner build --delete-conflicting-outputs
  ```
- [ ] **Step 2: Update `pubspec.yaml` with required generator dependencies**
  (built_value, built_collection, dio, etc). Run `flutter pub get`.
- [ ] **Step 3: Run the generation script**
  Execute `./scripts/generate_api.sh` and ensure `lib/api/generated` populates without issue.
- [ ] **Step 4: Commit**

### Task 2: Ledger Service Refactoring

**BDD Scenarios:** Scenario 2, Scenario 3, Scenario 4, Scenario 5
**BRD Requirements:** FR-03, FR-04, FR-05, FR-06, FR-07
**User-Facing:** NO

**Files:**
- Modify: `lib/features/transactions/repositories/transaction_repository.dart`
- Modify: `test/features/transactions/transaction_repository_test.dart`

- [ ] **Step 1: Write/Update existing tests in `transaction_repository_test.dart` to expect `LedgerApi` usage.**
- [ ] **Step 2: Inject `LedgerApi` from the generated code into `TransactionRepository` via Riverpod/constructor.**
- [ ] **Step 3: Refactor `executeTransaction` logic for Withdrawals and Deposits.**
  Map internal parameters to `WithdrawalRequest` (including `geofenceLat`, `customerCardMasked`) and `DepositRequest` (`destinationAccount`).
- [ ] **Step 4: Refactor Retail Sale, PIN Purchase, Cashback.**
  Swap custom endpoints to the official ones using `LedgerApi`.
- [ ] **Step 5: Run tests**
  `flutter test test/features/transactions/transaction_repository_test.dart`
- [ ] **Step 6: Commit**

### Task 3: Biller & Switch Service Refactoring

**BDD Scenarios:** Scenario 6, Scenario 7
**BRD Requirements:** FR-08, FR-09, FR-10, FR-11, FR-12
**User-Facing:** NO

**Files:**
- Modify: `lib/features/transactions/repositories/transaction_repository.dart` (or `BillerRepository` / `SwitchRepository` if they are structurally split).
- Modify: corresponding test files.

- [ ] **Step 1: Inject `BillerApi` and `SwitchApi` into the relevant repositories.**
- [ ] **Step 2: Map Bill Pay, Prepaid Topup, eWallet Topup/Withdraw, and ESSP transactions to `BillerApi` DTOs.**
- [ ] **Step 3: Map DuitNow transfer payload to `SwitchApi` DuitNow DTO.**
- [ ] **Step 4: Execute tests**
- [ ] **Step 5: Commit**

### Task 4: Onboarding Service Refactoring

**BDD Scenarios:** Scenario 8
**BRD Requirements:** FR-13, FR-14
**User-Facing:** NO

**Files:**
- Modify: `lib/features/kyc/repositories/kyc_repository.dart` (or equivalent location).
- Modify: test files.

- [ ] **Step 1: Inject `OnboardingApi` into Onboarding/KYC repository.**
- [ ] **Step 2: Map Identity Verification and Biometrics submissions to generated Onboarding DTOs.**
- [ ] **Step 3: Execute tests**
- [ ] **Step 4: Commit**

### Task 5: Legacy Clean Up

**BDD Scenarios:** Scenario 1
**BRD Requirements:** FR-02
**User-Facing:** NO

**Files:**
- Delete: `lib/features/transactions/models/transaction_models.dart` (Remove `TransactionExecutionRequest`, keeping only UI domain models if shared, otherwise fully replace).

- [ ] **Step 1: Delete handwritten network DTO models mapping to the replaced endpoints.**
- [ ] **Step 2: Run full build and flutter tests to assert no compilation or integration errors.**
  `flutter test`
- [ ] **Step 3: Commit**
