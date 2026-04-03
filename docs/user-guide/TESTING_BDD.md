# BDD Testing Guidelines: Agent Banking Channel

This project uses `bdd_widget_test` to ensure 1:1 parity between business requirements (Gherkin) and technical implementation (Flutter).

## 1. Maintaining Scenarios

### Adding or Updating Features
1.  **File Location**: All BDD scenarios live in `test/bdd/features/*.feature`.
2.  **Syntax**: Use standard Gherkin (Given/When/Then).
3.  **Naming Convention**: All steps must start with a letter (e.g., use `When two hours...` instead of `When 2 hours...`) to ensure valid Dart identifiers are generated.
4.  **Tags**: Tags must be sanitized for the Dart `test` package (use underscores, no spaces or dots inside a single tag).
    *   **Good**: `@US_CA_01 @Phase2`
    *   **Bad**: `@US-CA-01 @FR-CA-1.1` (Hyphens and dots are allowed by the `test` package, but the `@` symbol inside a string often causes issues if not handled by the runner).

## 2. The Generation Cycle

After modifying a `.feature` file, you must regenerate the Dart runners.

### Step 1: Run the Generator
Run this command from the project root:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```
*   **Effect**: This generates/updates `*_test.dart` files and creates missing step stubs in `test/bdd/features/step/`.

### Step 2: Implement Step Logic
If you added new steps, a new `.dart` file will appear in `test/bdd/features/step/`.
*   **Do NOT** modify the `*_test.dart` files; they are auto-generated.
*   **DO** implement the logic in the generated step files.
*   **Helper**: Use `test/bdd/bdd_test_helper.dart` to access shared Fakes and `ProviderContainer` setup.

## 3. Execution Commands

### Running a Specific Feature
```bash
flutter test test/bdd/features/auth_session_test.dart
```

### Running a Specific Scenario by Name
```bash
flutter test test/bdd/features/auth_session_test.dart --plain-name "Agent logs in with valid biometric"
```

### Running All BDD Tests
```bash
flutter test test/bdd/features/
```

## 4. Viewing Test Reports

### Console Output
The standard output provides a concise Given/When/Then breakdown of failures.

### JSON/Machine Readable (for CI/CD)
To generate a structured report for integration with tools like SonarQube or custom dashboards:
```bash
flutter test --reporter json > test-results.json
```

### Traceability Matrix
The `walkthrough.md` in the automation artifacts serves as the current traceability matrix. For a live compliance report, check the tags in the console output:
```bash
flutter test --tags MVP
```

---

## CRITICAL RULES
1. **Never** decrypt PII in tests. Use masks like `MOHD A***D`.
2. **Always** use `BigDecimal` (via `Decimal` package) in step definitions for money validation.
3. **Fakes vs Mocks**: Prefer `Fake` implementations (documented in `bdd_test_helper.dart`) for repositories to avoid non-nullable type collisions in Dart.
