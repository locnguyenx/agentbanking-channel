# Dual-Handshake Transactions Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Implement the foundational transaction flow including hardware abstraction for EMV/PIN and integration with the backend Fee & Execution APIs.

**Architecture:** Repository Pattern with abstract Hardware Hardware Abstraction Layer (HAL).

**Tech Stack:** Flutter, Riverpod, Dio.

---

### Task 1: Hardware Abstraction Layer (HAL) Mocks [DONE]

**BDD Scenarios:** S4.1 (Customer inserts card), S4.2 (Customer enters PIN)
**BRD Requirements:** Fulfills FR-CA-10.1, FR-CA-10.2
**User-Facing:** NO

**Files:**
- Create: `lib/features/hardware/hardware_interfaces.dart`
- Create: `lib/features/hardware/mock_hardware_impl.dart`
- Test: `test/features/hardware/hardware_test.dart`

- [x] **Step 1: Define Abstract Interfaces** [DONE]
- [x] **Step 2: Implement Mock Implementations** [DONE]
- [x] **Step 3: Write tests for Mock HAL** [DONE]
- [x] **Step 4: Commit** [DONE]

---

### Task 2: Transaction Repository & API Models

**BDD Scenarios:** S3.1 (Fee Pricing Engine API Call)
**BRD Requirements:** Fulfills FR-CA-2.1, FR-CA-7.1
**User-Facing:** NO

**Files:**
- Create: `lib/features/transactions/models/transaction_models.dart`
- Create: `lib/features/transactions/repositories/transaction_repository.dart`
- Test: `test/features/transactions/transaction_repository_test.dart`

- [ ] **Step 1: Define JSON Models**
  Create `TransactionQuoteRequest/Response` and `TransactionExecutionRequest/Response` models.

- [ ] **Step 2: Implement TransactionRepository**
  Implement methods for `getQuote()` and `executeTransaction()`.

- [ ] **Step 3: Write tests for Repository**
  Mock API responses using `dio_logger` or similar.

- [ ] **Step 4: Commit**

---

### Task 3: Transaction State Machine (Riverpod)

**BDD Scenarios:** S4.3 (Customer confirms amount), S4.5 (Transaction state progression)
**BRD Requirements:** Fulfills FR-CA-4.5
**User-Facing:** NO

**Files:**
- Create: `lib/features/transactions/providers/transaction_provider.dart`
- Test: `test/features/transactions/transaction_provider_test.dart`

- [ ] **Step 1: Define TransactionState Enum**
  `IDLE`, `QUOTING`, `WAITING_CONSENT`, `WAITING_CARD`, `WAITING_PIN`, `PROCESSING`, `SUCCESS`, `FAILED`.

- [ ] **Step 2: Implement TransactionNotifier**
  Manage the lifecycle: Fetch Quote -> Await Consent -> Await Hardware -> Execute -> Show Result.

- [ ] **Step 3: Write Unit Tests for the State Machine**
  Verify state transitions for both Happy Paths and Error Paths.

- [ ] **Step 4: Commit**

---

### Task 4: Dual-Handshake UI Orchestration

**BDD Scenarios:** S4.1, S4.2, S4.4 (Successful transaction triggers SMS)
**BRD Requirements:** Fulfills FR-CA-4.1, FR-CA-4.6
**User-Facing:** YES

**Files:**
- Create: `lib/features/transactions/screens/transaction_flow_screen.dart`
- Frontend Test: `test/features/transactions/transaction_flow_screen_test.dart`

- [ ] **Step 5: Write failing frontend test for dual-display**
- [ ] **Step 6: Run frontend test to verify it fails**
- [ ] **Step 7: Implement UI matching State Machine**
- [ ] **Step 8: Run frontend test to verify it passes**
- [ ] **Step 9: Commit**
