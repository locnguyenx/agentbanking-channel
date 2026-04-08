# Testing Guide: Agent Banking Channel

This guide covers all types of testing implemented in the Agent Banking Channel application, including unit, integration, and BDD tests, as well as the runtime test modes (Mock vs. Real Backend).

## 1. Test Levels

### 1.1 Unit Tests
- **Location**: `test/unit/`
- **Purpose**: Verify individual logic, models, and small utility functions in isolation.
- **Run Command**:
  ```bash
  flutter test test/unit/
  ```

### 1.2 Integration Tests
- **Location**: `test/integration/`
- **Purpose**: Verify the interaction between multiple components (e.g., Notifiers, Repositories, and UI) and validate complex state transitions.

#### Key Files and Test Cases:

1. **`app_test.dart`**: Focuses on end-to-end user journeys and high-level business flows.
    - **Case 1: "Complete e-KYC Onboarding and a Bill Payment"**: A long-running saga starting from Login, performing a full MyKad-based onboarding, and finishing with a successful bill payment.
      ```bash
      flutter test test/integration/app_test.dart --plain-name "Complete e-KYC Onboarding and a Bill Payment" --dart-define=USE_REAL_BACKEND=true --dart-define=API_BASE_URL=http://127.0.0.1:8080
      ```
    - **Case 2: "Bill Payment with CARD should require card insertion"**: Validates the Hardware Abstraction Layer (HAL) integration, ensuring the app waits for physical card events during a transaction.
      ```bash
      flutter test test/integration/app_test.dart --plain-name "Bill Payment with CARD should require card insertion" --dart-define=USE_REAL_BACKEND=true --dart-define=API_BASE_URL=http://127.0.0.1:8080
      ```
    - **Case 3: "Bill Payment with DUITNOW should NOT require card insertion"**: Verifies that digital-only funding sources correctly bypass the card reader state machine.
      ```bash
      flutter test test/integration/app_test.dart --plain-name "Bill Payment with DUITNOW should NOT require card insertion" --dart-define=USE_REAL_BACKEND=true --dart-define=API_BASE_URL=http://127.0.0.1:8080
      ```

2. **`full_system_test.dart`**: Focuses on deep contract verification and payload integrity.
    - **Case: "JomPay Full Flow - Contract Verification"**: Specifically intercepts network traffic to ensure that `Idempotency-Keys` are valid UUIDs and that the JSON payloads strictly match the OpenAPI specification.
      ```bash
      flutter test test/integration/full_system_test.dart --plain-name "JomPay Full Flow - Contract Verification" --dart-define=USE_REAL_BACKEND=true --dart-define=API_BASE_URL=http://127.0.0.1:8080
      ```

3. **Difference between `app_test.dart` and `full_system_test.dart`**: While both are integration tests, they target different levels of the application stack.

| Feature | `app_test.dart` | `full_system_test.dart` |
|---------|-----------------|-------------------------|
| **Primary Goal** | **UI/UX Flow Verification** | **API Contract Verification** |
| **Asserts On** | UI Elements, Screen Transitions | API Payloads, Status Codes, Headers |
| **Level** | Higher (Frontendcentric) | Deeper (Backend Integrationcentric) |
| **Key tool** | `find.byType`, `find.text` | `verify(mockDio.request)`, `captureAny` |

**Example: "Complete e-KYC Onboarding and a Bill Payment"**
- **In `app_test.dart`**: The test ensures that after scanning a MyKad and paying a bill, the user actually lands on the `DashboardScreen` and sees the correct "Success" payment status. It validates the **User Experience**.
- **In `full_system_test.dart`**: The test ensures that during the payment flow, the app sends a valid `quoteId` (from a previous response) in the execution request, and that the `idempotencyKey` is a properly formatted UUID. It validates the **Technical Protocol**.

**Run Command**:
```bash
# app_test
flutter test test/integration/app_test.dart --dart-define=USE_REAL_BACKEND=true --dart-define=API_BASE_URL=http://127.0.0.1:8080
# full_system_test
flutter test test/integration/full_system_test.dart --dart-define=USE_REAL_BACKEND=true --dart-define=API_BASE_URL=http://127.0.0.1:8080
# transaction_facade_test.dart
flutter test test/integration/transaction_facade_test.dart --dart-define=USE_REAL_BACKEND=true --dart-define=API_BASE_URL=http://127.0.0.1:8080
# bdd test
flutter test test/bdd/features/ --dart-define=USE_REAL_BACKEND=true --dart-define=API_BASE_URL=http://127.0.0.1:8080
# turn off debug
 --dart-define=DISABLE_DIO_LOGS=true
```

**Run Command (All Integration Tests)**:
```bash
flutter test test/integration/ --dart-define=USE_REAL_BACKEND=true --dart-define=API_BASE_URL=http://127.0.0.1:8080
```

**Run Command (All but exclude Integration Tests)**:
```bash
flutter test test/features/ test/core/ test/contract/
```

#### Troubleshooting Real Backend Mode:
- **`IS_MOCK_AUTH=true`**: Bypasses real login checks by allowing `123456` as a password. Use this if the auth backend is not whitelisted for your test environment.
- **Real Credentials**: For tests with a real backend, use the account `NEW-AGT-001` with password `12345678`.
- **`IS_MOCK_KYC=true`**: Bypasses real MyKad/eKYC validation by using a fake scanner response. (Note: Only works if enabled in `app_test.dart`).
- **`HttpOverrides`**: All integration tests now include `HttpOverrides.global = null` to allow real network requests from `testWidgets`.

### 1.3 BDD (Behavior-Driven Development) Tests
- **Location**: `test/bdd/features/`
- **Purpose**: Ensure 1:1 parity between business requirements (Gherkin) and technical implementation.
- **Run Command**:
  ```bash
  flutter test test/bdd/features/
  ```
- **Generation**: After modifying a `.feature` file, regenerate runners:
  ```bash
  flutter pub run build_runner build --delete-conflicting-outputs
  ```

---

## 2. Test Modes

The application supports two primary testing modes, toggled via environment flags (`--dart-define`).

### 2.1 Mock Mode (Default)
By default, all network and repository layers are mocked using `mockito` or `Fake` implementations. This is the fastest and most stable way to run tests in CI/CD.

### 2.2 Real Backend Mode
You can point tests to a live backend API (e.g., a local Spring Boot instance or a staging environment). This is useful for verifying actual API contract compliance and network interceptors like GPS validation.

**Requirements**:
- A running backend instance.
- The `USE_REAL_BACKEND=true` flag.
- The `API_BASE_URL` flag.

**Example Command**:
```bash
flutter test <test_path> \
  --dart-define=USE_REAL_BACKEND=true \
  --dart-define=API_BASE_URL=http://127.0.0.1:8080
```

> [!IMPORTANT]
> Physical hardware interfaces (e.g., Card Reader, PIN Pad) remain mocked even in Real Backend mode to allow tests to execute without physical POS peripherals.

---

## 3. Advanced Configuration

### GPS and Geofencing in Tests
The application enforces geofencing. In mock mode, the `MockGeolocator` provides a whitelisted coordinate. In real backend mode, the production `GpsInterceptor` is active and will fail requests if valid location data is not available or if the backend rejects the merchant's coordinates.

### Redaction and Security
- **No PII**: Tests must never use real PII (MyKad, Phone Numbers).
- **Masking**: Use `MOHD A***D` or similar for verification strings.
- **Redaction**: The custom Logger in production automatically redacts sensitive patterns; ensure your test expectations account for this masking if testing log output.

---

## 4. Troubleshooting

| Issue | Potential Cause | Fix |
|-------|-----------------|-----|
| `Confirm Details` not found | Mock matching failure | Ensure `dio.request` is stubbed instead of `dio.post` for generated APIs. |
| `ERR_VAL_GPS_UNAVAILABLE` | Real Mode active | Ensure you are providing a valid location or use Mock mode. |
| Timer leaks | Notifier not disposed | Use `pumpAndSettle` or manually dispose providers in tearDown. |

---

## CRITICAL RULES
1. **Money**: Always use `BigDecimal` (via `Decimal` package) in step definitions.
2. **Fakes**: Prefer `Fake` implementations over `Mocks` for repository interfaces to avoid null-safety issues.
3. **Redaction**: Never log card numbers (PAN) or PIN Blocks in plain text.
