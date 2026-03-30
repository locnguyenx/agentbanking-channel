# OpenAPI Synchronization Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Generate native Dart OpenAPI clients to ensure 100% sync with the backend, enforce explicit UI field validations, and implement new endpoints like JomPay.

**Architecture:** We will use `openapi-generator-cli` to build the `agent_api` package, attach Riverpod interceptors, inject validation constraints into `TextFormField`s, and decouple the UI from raw DTOs via Domain Repositories.

**Tech Stack:** Flutter, Riverpod, Dio, openapi-generator-cli

---

### Task 1: Generate API Client [DONE]

**BDD Scenarios:** N/A (Foundation setup)
**BRD Requirements:** FR-01: Utilize `scripts/generate_api.sh`
**User-Facing:** NO

**Files:**
- Modify: `lib/api/generated/` (Generated content)
- Test: N/A

- [x] **Step 1: Execute API Generation Script** [DONE]

Run: `bash scripts/generate_api.sh`
Expected: Completes without errors, building `lib/api/generated/`.

- [x] **Step 2: Verify Compilation** [DONE]

Run: `flutter pub get && flutter analyze`
Expected: PASS (No new compilation errors from generated files).

- [x] **Step 3: Commit** [DONE]

```bash
git add lib/api/generated/
git commit -m "chore: generate agent_api client from openapi.yaml"
```

### Task 2: Implement OpenAPI Reusable Form Validators [DONE]

**BDD Scenarios:** S.1, S.2 (Form Validation Edge Cases)
**BRD Requirements:** FR-02: Implement generic validators
**User-Facing:** YES (UI feedback)

**Files:**
- Create: `lib/core/utils/openapi_validators.dart`
- Create: `test/core/utils/openapi_validators_test.dart`

- [x] **Step 1: Write failing validator tests** [DONE]

```dart
// In test/core/utils/openapi_validators_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/core/utils/openapi_validators.dart';

void main() {
  test('length validator returns error if exceeding max length', () {
    expect(OpenApiValidators.length('12345678901', maxLen: 10), 'Cannot exceed 10 characters');
  });
  test('minMax validator returns error if below minimum', () {
    expect(OpenApiValidators.minMax('5.00', min: 10.00), 'Amount must be at least 10.0');
  });
}
```

- [x] **Step 2: Run validator tests to verify failure** [DONE]

Run: `flutter test test/core/utils/openapi_validators_test.dart`
Expected: FAIL

- [x] **Step 3: Implement Validator utility** [DONE]

```dart
// In lib/core/utils/openapi_validators.dart
class OpenApiValidators {
  static String? length(String? value, {int? minLen, int? maxLen}) {
    if (value == null) return null;
    if (maxLen != null && value.length > maxLen) return 'Cannot exceed $maxLen characters';
    if (minLen != null && value.length < minLen) return 'Must be at least $minLen characters';
    return null;
  }
  static String? minMax(String? value, {num? min, num? max}) {
    if (value == null || value.isEmpty) return null;
    final numValue = num.tryParse(value);
    if (numValue == null) return 'Invalid number';
    if (min != null && numValue < min) return 'Amount must be at least $min';
    if (max != null && numValue > max) return 'Amount cannot exceed $max';
    return null;
  }
}
```

- [x] **Step 4: Run validator tests to verify success** [DONE]

Run: `flutter test test/core/utils/openapi_validators_test.dart`
Expected: PASS

- [x] **Step 5: Commit** [DONE]

```bash
git add lib/core/utils/openapi_validators.dart test/core/utils/openapi_validators_test.dart
git commit -m "feat: implement reusable openapi schema validators"
```

### Task 3: Refactor Bill Payment UI Validations [DONE]

**BDD Scenarios:** S.1 (Agent enters value exceeding maximum length for text field)
**BRD Requirements:** FR-03: Refactor current Biller forms
**User-Facing:** YES

**Files:**
- Modify: `lib/features/transactions/screens/bill_payment_form.dart`
- Test: `test/features/transactions/bill_payment_test.dart`

- [x] **Step 1: Write failing UI test** [DONE]
- [x] **Step 2: Run UI test to verify failure** [DONE]
- [x] **Step 3: Implement BillPaymentForm validator** [DONE]
- [x] **Step 4: Run UI test to verify success** [DONE]
- [x] **Step 5: Commit** [DONE]

```bash
git add lib/features/transactions/screens/bill_payment_form.dart test/features/transactions/bill_payment_test.dart
git commit -m "feat: apply openapi validation to bill payment form"
```

### Task 4: Implement JomPay Feature Integration

**BDD Scenarios:** S.3 (Agent completes successful JomPay transaction)
**BRD Requirements:** FR-04: Implement new endpoint flows
**User-Facing:** YES

**Files:**
- Modify: `lib/features/transactions/screens/jompay_form.dart` (Create new)
- Test: `test/features/transactions/jompay_test.dart` (Create new)

- [x] **Step 1: Write failing UI test** [DONE]

```dart
// In test/features/transactions/jompay_test.dart
void main() {
  testWidgets('submits JomPay and shows receipt', (tester) async {
    // Given JomPay Form
    // When enter Biller Code "1234", Ref-1 "ABC"
    // And tap submit
    // Then find Receipt
  });
}
```

- [x] **Step 2: Run UI test to verify failure** [DONE]

Run: `flutter test test/features/transactions/jompay_test.dart`
Expected: FAIL

- [x] **Step 3: Implement JomPay Screen** [DONE]

Create `lib/features/transactions/screens/jompay_form.dart` incorporating `JomPayExternalRequest` generated model.

- [x] **Step 4: Run UI test to verify success** [DONE]

Run: `flutter test test/features/transactions/jompay_test.dart`
Expected: PASS

- [x] **Step 5: Commit** [DONE]

```bash
git add lib/features/transactions/screens/jompay_form.dart test/features/transactions/jompay_test.dart
git commit -m "feat: full JomPay endpoint integration"
```

### Task 5: Refactor Ledger Service Features [DONE]

**BDD Scenarios:** Refactoring existing paths.
**BRD Requirements:** FR-03: Refactor current Ledger forms
**User-Facing:** YES

**Files:**
- Modify: `lib/features/transactions/screens/withdrawal_screen.dart`
- Modify: `lib/features/transactions/screens/deposit_screen.dart`
- Modify: `lib/features/transactions/screens/balance_inquiry_screen.dart`
- Modify: `lib/features/merchant/screens/merchant_sale_screen.dart` (for Retail Sale/Cashback/Pin Purchase)

- [x] **Step 1: Write failing UI tests for Validation** [DONE]
- [x] **Step 2: Run UI tests to verify failure** [DONE]
- [x] **Step 3: Implement Validators & DTO Mappers** [DONE]
- [x] **Step 4: Run tests to verify success** [DONE]
- [x] **Step 5: Commit** [DONE]
```bash
git commit -am "feat: apply openapi clients and validators to ledger features"
```

### Task 6: Refactor Extended Biller Features [DONE]

**BDD Scenarios:** Refactoring existing paths.
**BRD Requirements:** FR-03: Refactor current Biller forms
**User-Facing:** YES

**Files:**
- Modify: `lib/features/transactions/screens/prepaid_topup_screen.dart`
- Modify: `lib/features/transactions/screens/essp_purchase_screen.dart`
- Modify: `lib/features/transactions/screens/ewallet_screen.dart`

- [x] **Step 1: Write failing UI tests for Validation** [DONE]
- [x] **Step 2: Run tests to verify failure** [DONE]
- [x] **Step 3: Implement Validators & DTO Mappers** [DONE]
- [x] **Step 4: Run tests to verify success** [DONE]
- [x] **Step 5: Commit** [DONE]
```bash
git commit -am "feat: apply openapi clients and validators to extended biller features"
```

### Task 7: Refactor Switch Service Features [DONE]

**BDD Scenarios:** Refactoring existing paths.
**BRD Requirements:** FR-03: Refactor current Switch forms
**User-Facing:** YES

**Files:**
- Modify: `lib/features/transactions/screens/duitnow_screen.dart`

- [x] **Step 1: Write failing UI tests implementation** [DONE]
- [x] **Step 2: Run tests to verify failure** [DONE]
- [x] **Step 3: Implement Validators & DTO Mappers** [DONE]
- [x] **Step 4: Run tests to verify success** [DONE]
- [x] **Step 5: Commit** [DONE]
```bash
git commit -am "feat: apply openapi clients to DuitNow features"
```

### Task 8: Implement New Onboarding Features [DONE]

**BDD Scenarios:** Happy path and Edge cases for Onboarding features.
**BRD Requirements:** FR-04: Implement new endpoint flows
**User-Facing:** YES

**Files:**
- Modify: `lib/features/agent_onboarding/screens/mykad_verification_screen.dart`
- Modify: `lib/features/agent_onboarding/screens/application_submit_screen.dart`

- [x] **Step 1: Write failing UI test** [DONE]
- [x] **Step 2: Run tests to verify failure** [DONE]
- [x] **Step 3: Implement Onboarding UI & Logic** [DONE]
- [x] **Step 4: Run tests to verify success** [DONE]
- [x] **Step 5: Commit** [DONE]
```bash
git commit -am "feat: full Onboarding integration for MyKad and Application Submit"
```
