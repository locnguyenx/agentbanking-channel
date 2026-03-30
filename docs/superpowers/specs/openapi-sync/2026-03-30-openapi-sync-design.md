# Design Spec: OpenAPI Synchronization

## 1. Architecture & Generation Layer
* **Tooling**: Use `openapi-generator-cli` with the `dart-dio` generator, configured in `scripts/generate_api.sh`, outputting to `lib/api/generated`.
* **Dependency Injection**: The generated instances of `LedgerApi`, `BillerApi`, `SwitchApi`, and `OnboardingApi` will be registered as Riverpod `Provider`s.
* **Interceptors**: We will attach the existing `GpsInterceptor`, `IdempotencyInterceptor`, and `TimeoutInterceptor` from `lib/core/network/` to the single Dio instance passed to these generated clients, ensuring global headers are injected.

## 2. Reusable UI Validation Layer
* **Validator Class**: Create a new `OpenApiValidators` utility class in `lib/core/utils/`.
* **Implementation**: 
  ```dart
  class OpenApiValidators {
    static String? minMax(String? value, {num? min, num? max}) { /* ... */ }
    static String? length(String? value, {int? minLen, int? maxLen}) { /* ... */ }
    static String? regex(String? value, String pattern) { /* ... */ }
  }
  ```
* These will be wired directly into the `TextFormField.validator` parameter in the UI layer (e.g., inside `BillPaymentForm` and `JomPayForm`).

## 3. State Management & Migration Strategy
* **Data Models**: Phase out handwritten models like `WithdrawalRequest` and replace them natively with `WithdrawalExternalRequest` from `agent_api`.
* **State Notifiers**: Update repositories (e.g., `BillerRepository`) to accept domain entities, then map them directly to the generated request objects before calling `api.topup(request)`. The UI remains decoupled from DTOs, knowing only about domain-level forms.

## 4. Fallback & Error Handling
* **Error Parsing**: Define a standard catch block for `DioException` to parse the OpenAPI defined `ErrorResponse` (with `action_code` and `trace_id`), falling back gracefully if the backend returns an undocumented error structure.
