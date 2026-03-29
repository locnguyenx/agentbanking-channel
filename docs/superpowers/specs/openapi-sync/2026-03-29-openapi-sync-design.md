# OpenAPI Client Generation & Full Contract Enforcement Design

## 1. Tooling & API Generation
* **Generation Script:** Create a dedicated script `scripts/generate_api.sh` that executes the OpenAPI generator: `npx @openapitools/openapi-generator-cli generate -i docs/api/openapi.yaml -g dart-dio -o lib/api/generated`.
* **Dependencies:** Update `pubspec.yaml` to include backend API validation dependencies such as `built_value`, `built_collection`, and `dio` if missing.

## 2. Adapter Layer Refactoring
* **Standard Repository Pattern:** The UI layer will continue communicating with standard domain repositories (`TransactionRepository`, `BillerRepository`, etc.).
* **Dependency Injection:** Inject generated API classes (e.g., `LedgerApi`, `BillerApi`, `SwitchApi`) into the respective domain repositories via Riverpod providers.
* **Mapping Strategy:** The repositories must dynamically map the application's internal domain state to the strongly-typed Request DTOs (like `WithdrawalRequest`, `DepositRequest`) and map the network responses back.

## 3. Legacy Model Deprecation
* **Phased Deletion:** Upon migrating each service's endpoints to the generated clients, systematically remove all handwritten DTO classes (in `features/transactions/models/`, `features/kyc/models/`, etc.) safely.
