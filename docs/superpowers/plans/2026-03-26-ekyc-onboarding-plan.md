# e-KYC & Onboarding Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Implement the e-KYC flow (MyKad scanning + Facial verification) and the Digital Onboarding workflow for new accounts.

**Architecture:** Repository Pattern with Hardware Abstraction (HAL) for sensors.

**Tech Stack:** Flutter, Riverpod, SQLCipher (for MyKad data encryption at rest).

---

### Task 1: MyKad Scanner HAL Mock [DONE]

**BDD Scenarios:** S5.1 (Scan MyKad), S5.2 (Extract data from chip)
**BRD Requirements:** Fulfills FR-CA-5.1, FR-CA-5.2
**User-Facing:** NO

**Files:**
- Modify: `lib/features/hardware/hardware_interfaces.dart`
- Modify: `lib/features/hardware/mock_hardware_impl.dart`
- Test: `test/features/hardware/kyc_hardware_test.dart`

- [x] **Step 1: Add IMyKadScanner interface** [DONE]
- [x] **Step 2: Implement MockMyKadScanner** [DONE]
- [x] **Step 3: Write Unit Tests** [DONE]
- [x] **Step 4: Commit** [DONE]

---

### Task 2: KYC API Service (KYC/AML Proxy) [DONE]

**BDD Scenarios:** S6.1 (Submit KYC for approval), S6.2 (AML check pass/fail)
**BRD Requirements:** Fulfills FR-CA-6.1, FR-CA-6.2
**User-Facing:** NO

**Files:**
- Create: `lib/features/kyc/models/kyc_models.dart`
- Create: `lib/features/kyc/repositories/kyc_repository.dart`
- Test: `test/features/kyc/kyc_repository_test.dart`

- [x] **Step 1: Define KYC Request/Response Models**
  Include MyKad data and Face verification scores.

- [x] **Step 2: Implement KycRepository**
  Implement `/api/v1/kyc/validate` and `/api/v1/kyc/aml-check`.

- [x] **Step 3: Write unit tests**

- [x] **Step 4: Commit**

---

### Task 3: Onboarding State Machine (Riverpod) [IN_PROGRESS]

**BDD Scenarios:** S7.1 (Account type selection), S7.2 (Submit onboarding request)
**BRD Requirements:** Fulfills FR-CA-7.1, FR-CA-7.2
**User-Facing:** NO

**Files:**
- Create: `lib/features/kyc/providers/onboarding_provider.dart`
- Test: `test/features/kyc/onboarding_provider_test.dart`

- [ ] **Step 1: Define OnboardingState Enum**
  `IDLE`, `SCANNING_MYKAD`, `VALIDATING_KYC`, `SELECTING_PRODUCT`, `PROVISIONING`, `SUCCESS`, `FAILED`.

- [ ] **Step 2: Implement OnboardingNotifier**
  Manage lifecycle: Scan -> Verify -> Select -> Provision.

- [ ] **Step 3: Write unit tests**

- [ ] **Step 4: Commit**

---

### Task 4: e-KYC UI Flow & Account Selection [DONE]

**BDD Scenarios:** S5.1, S7.1, S7.3 (Onboarding success receipt)
**BRD Requirements:** Fulfills FR-CA-7.3
**User-Facing:** YES

**Files:**
- Create: `lib/features/kyc/screens/kyc_flow_screen.dart`
- Create: `lib/features/kyc/screens/account_selection_screen.dart`
- Frontend Test: `test/features/kyc/kyc_ui_test.dart`

- [x] **Step 5: Implement UI components matching state machine**
- [x] **Step 6: Integrate with hardware mocks**
- [x] **Step 1: Add widget tests**
- [x] **Step 2: Commit** [DONE]
