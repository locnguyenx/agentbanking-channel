# Offline & Compliance Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Implement the "Compliance Freeze" terminal locking mechanism and the "Store & Forward" (S&F) queue for offline transaction resilience.

**Architecture:** Encrypted Repository (SQLCipher) with Background Sync.

**Tech Stack:** Flutter, sqflite_sqlcipher, workmanager.

---

### Task 1: Compliance Freeze Service [IN_PROGRESS]

**BDD Scenarios:** S8.1 (Terminal locked by backend), S8.2 (Local lockdown persistence)
**BRD Requirements:** Fulfills FR-CA-8.1, FR-CA-8.2
**User-Facing:** YES (Lock screen)

**Files:**
- Create: `lib/core/compliance/compliance_service.dart`
- Create: `lib/core/compliance/compliance_lock_screen.dart`
- Test: `test/core/compliance/compliance_test.dart`

- [ ] **Step 1: Implement ComplianceService**
  Service to track `isLocked` state and listen for `ERR_COMPLIANCE_FREEZE` from any API call.

- [ ] **Step 2: Create Persistent Lock State**
  Use `SecureStorageService` to persist the locked state across reboots.

- [ ] **Step 3: Build ComplianceLockScreen**
  A full-screen overlay that prevents any app interaction until an unlock code/biometric is provided (if permitted by policy).

- [ ] **Step 4: Commit**

---

### Task 2: Encrypted Store & Forward Queue [DONE]

**BDD Scenarios:** S9.1 (Transaction queued offline)
**BRD Requirements:** Fulfills FR-CA-9.1, FR-CA-9.2
**User-Facing:** NO

**Files:**
- Create: `lib/core/offline/offline_queue_service.dart`
- Test: `test/core/offline/offline_queue_test.dart`

- [x] **Step 1: Setup SQLCipher Database**
  Initialize encrypted SQLite for local storage of transaction payloads.

- [x] **Step 2: Implement S&F Queue Logic**
  Persistence methods: `enqueue()`, `dequeue()`, `getPendingCount()`.

- [x] **Step 3: Write Unit Tests**
  Verify data encryption and FIFO order.

- [x] **Step 4: Commit** [DONE]

---

### Task 3: Background Sync Worker [IN_PROGRESS]

**BDD Scenarios:** S9.2 (Automatic sync when online)
**BRD Requirements:** Fulfills FR-CA-9.3
**User-Facing:** NO

**Files:**
- Create: `lib/core/offline/sync_worker.dart`
- Modify: `lib/core/network/dio_client.dart`

- [ ] **Step 1: Implement Sync Logic**
  A loop that processes the S&F queue using `X-Idempotency-Key` for safety.

- [ ] **Step 2: Setup WorkManager (Background Task)**
  Register a periodic task to trigger sync when network is available.

- [ ] **Step 3: Commit**

---

### Task 4: Offline UI/UX Indicators

**BDD Scenarios:** S9.1 (Visual indication of offline mode)
**BRD Requirements:** Fulfills FR-CA-9.4
**User-Facing:** YES

**Files:**
- Create: `lib/core/offline/widgets/offline_indicator.dart`
- Frontend Test: `test/core/offline/offline_ui_test.dart`

- [ ] **Step 1: Build Connection Status Widget**
  Shows "Offline Mode" and "Pending: X" count in the app header.

- [ ] **Step 2: Add functional tests**

- [ ] **Step 3: Commit**
