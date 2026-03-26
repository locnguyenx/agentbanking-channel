# System Design Specification: Agent Banking Channel App

**Version:** 1.0  
**Date:** 2026-03-25  
**Module:** Channel App (Flutter POS/Mobile)  
**BRD Reference:** `docs/superpowers/specs/agent-banking-channel/2026-03-25-agent-banking-channel-brd.md`

## 1. Architectural Overview

The application utilizes a **Feature-Driven Clean Architecture** to ensure testability, separation of concerns, and ease of hardware integrations. 

### 1.1 Layers
*   **Presentation:** Flutter Widgets, Riverpod (State Management), routing via `go_router`. Designed for Dual-Display layouts (Agent vs Customer view).
*   **Domain:** Business logic, Use Cases (e.g., `ExecuteDualHandshakeUseCase`), and abstract Entity classes.
*   **Data:** Repositories implementing Domain interfaces. Includes REST API clients (`dio`), local database (`sqflite`), and device secure storage.
*   **Hardware Abstraction Layer (HAL):** Abstraction wrappers around physical POS peripherals (printers, EMV readers) using Android `MethodChannel`.

---

## 2. Core Technical Components

### 2.1 State Management & Dependency Injection
*   **Framework:** `Riverpod` (`hooks_riverpod`).
*   **Providers Strategy:**
    *   `authProvider`: Manages JWT lifecycle and background session expiration checks.
    *   `floatBalanceProvider`: Streams Agent Float polling every 30 seconds.
    *   `transactionProvider`: A robust `StateNotifier` governing the strict Dual-Handshake state machine: `INIT -> QUOTING -> WAITING_CONSENT -> WAITING_CARD -> WAITING_PIN -> PROCESSING -> SUCCESS/LOCKED`.

### 2.2 Hardware Abstraction Layer (HAL)
To decouple the app from specific vendor SDKs (e.g., Sunmi, Pax, Aisino), all hardware interactions occur via abstract Dart contracts.
*   **Contracts:** `ICardReader`, `IPinPad`, `IPrinter`, `IBiometricScanner`.
*   **Implementation:** `VendorAPrinterImpl` implements `IPrinter` by communicating over a `MethodChannel` (`com.banking.channel/printer`) to the native Android host which executes the proprietary `.jar/.aar` SDK.
*   **Fallback Strategy:** Features degradation is automatic. If `IPrinter.isAvailable()` is false, the app safely defaults to SMS-only receipts without crashing.

### 2.3 Store & Forward Engine (Local Database)
*   **Engine:** `sqflite` bundled with `sqlcipher` for AES-256 local database encryption.
*   **Encryption Key:** The database master key is securely generated once per device and permanently vaulted inside the **Android Keystore** via `flutter_secure_storage`.
*   **Queue Entity:** Failed reversals (MTI 0400) and offline logs are serialized as JSON and pushed to the `txn_queue` table with their original `X-Idempotency-Key`.
*   **Sync Worker:** `workmanager` schedules a background isolate to execute every 15 minutes, pushing pending queue items to the Backend API.

---

## 3. Security & Anti-Fraud Mechanisms

### 3.1 Protection Measures
1.  **TLS & Pinning:** Mandatory TLS 1.2+ for all `dio` client traffic. API Certificate SHA-256 hashes are pinned to reject Man-In-The-Middle attacks.
2.  **Display Obfuscation:** The Flutter app is restricted with `WindowManager.LayoutParams.FLAG_SECURE` on native Android, preventing OS-level screenshots or screen recordings.
3.  **Encrypted PIN Processing:** The app **never** renders a virtual keyboard for PINs. It strictly delegates PIN capture to the HSM (Hardware Security Module) built into the POS device, which returns an encrypted DUKPT PIN-Block.
4.  **Zero PII Logging:** A custom Logger intercepts all logs. Regex parsers proactively redact strings matching 16-digit PANs or 12-digit MyKads before writing to console/Crashlytics.

### 3.2 Anti-Smurfing & Compliance Locks
When the Backend Rule Engine returns an `ERR_COMPLIANCE_FREEZE` code:
*   The `authProvider` immediately flips `isComplianceLocked = true`.
*   The `go_router` instantly redirects the navigation stack to a dead-end `ComplianceLockScreen`, popping all previous routes.
*   The state persists across app reboots via encrypted local storage until the Backend proactively sends an Unlock webhook.

---

## 4. System Workflows

### 4.1 API Execution & Edge Cases Orchestration
1.  **Geofence Pre-flight:** Location package verifies GPS coordinates $\le$ 100m. Failure instantly halts workflow.
2.  **Parameter Engine (Quote):** `POST /api/v1/transactions/quote`. Customer selects "Agree" on touch display.
3.  **Authorization:** Hardware EMV Read $\rightarrow$ Hardware PIN Entry.
4.  **Execution:** `POST /api/v1/transactions/execute` (Headers: `X-GPS`, `X-Idempotency-Key`).
5.  **Success:** Commit to Float Provider $\rightarrow$ Print Receipt.
6.  **Network Drop / Hardware Failure:** 
    *   If Printer jams *after* HTTP 200 OK: App generates an automatic `MTI 0400 Reversal` request payload and places it in the `sqflite` queue. Float provider is unchanged locally; depends on backend resolution.

---

## 5. File & Folder Structure (Proposed)

```text
lib/
├── core/
│   ├── network/          # Dio client, Interceptors, TLS Pinning
│   ├── security/         # Secure Storage manager, PII Redaction Logger
│   └── errors/           # Custom exception classes
├── features/
│   ├── auth/             # Login, Biometric unlock, Session timer
│   ├── dashboard/        # Float balance polling, Geofence map indicator
│   ├── hardware/         # HAL (ICardReader, IPrinter, IPinPad)
│   ├── transactions/     # Withdrawal, Deposit, DuitNow logic & forms
│   └── ekyc/             # OCR Extractor, Face AI Liveness bridge
└── main.dart             # Riverpod ProviderScope, App Theme, GoRouter
```

---
**End of System Design Specification**
