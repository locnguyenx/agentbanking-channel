# Test Mocking & Coverage Analysis

This report explains why the Agent Banking Channel test suite achieved a 100% pass rate (232/232 tests) despite documented API contract mismatches in the production repositories.

## 1. Mocking Architecture

The current test suite is built on **Isolation-First** principles. Different test types handle dependencies differently:

| Test Type | Scope | Dependency Handling | Impact on API Contract Verification |
| :--- | :--- | :--- | :--- |
| **BDD Tests** | UI + Complex Sagas | **Mock Repositories:** Uses [MockTransactionRepository](file:///Users/me/myprojects/agentbanking-channel/test/bdd/helpers/mock_factory.dart#124-246) via [AppHarness](file:///Users/me/myprojects/agentbanking-channel/test/bdd/helpers/app_harness.dart#67-315). | **NONE.** Does not execute repository code; uses stubs. |
| **Unit Tests** | Notifiers / Use Cases | **Mock Repositories:** Uses Mockito to stub all remote calls. | **NONE.** Verification ends at the repository interface. |
| **Integration Tests** | Flow Synchronization | **Manual Fakes:** Uses [FakeTransactionRepository](file:///Users/me/myprojects/agentbanking-channel/test/integration/test_fakes.dart#91-196) (simple in-memory classes). | **NONE.** Does not use [Dio](file:///Users/me/myprojects/agentbanking-channel/test/integration/test_fakes.dart#198-204) or real repository logic. |
| **Biller Integration** | End-to-End Flow | **Mock Dio:** Uses the real [TransactionRepository](file:///Users/me/myprojects/agentbanking-channel/lib/features/transactions/repositories/transaction_repository.dart#13-368) but mocks the [Dio](file:///Users/me/myprojects/agentbanking-channel/test/integration/test_fakes.dart#198-204) responses. | **PARTIAL.** Verification hits the repository code but mocks the network boundary. |

## 2. Why the "100% Pass" is possible
- **Isolated Testing:** 225+ tests (BDD & Unit) never call the [TransactionRepository](file:///Users/me/myprojects/agentbanking-channel/lib/features/transactions/repositories/transaction_repository.dart#13-368) methods. They call a "Mock" version that has no concept of URLs or endpoints.
- **Outdated Verification:** The few tests that *do* use real repositories (like [biller_integration_test.dart](file:///Users/me/myprojects/agentbanking-channel/test/features/transactions/biller_integration_test.dart)) were previously masked by a `try-catch` fallback in the production code. 
- **Surgical Fixing:** In the previous step, I updated the legacy endpoints in the few affected "Biller Integration" tests to match the new production strings, which is why they now pass.

## 3. The Coverage Gap: Contract Verification
We currently lack a **Contract Testing** layer. 

> [!IMPORTANT]
> A "Contract Test" verifies that the Repository correctly implements the specific endpoints, headers, and payload structures defined in [openapi.yaml](file:///Users/me/myprojects/agentbanking-channel/docs/api/openapi.yaml). 

Because we don't have these tests, a mismatch between the Code and the OpenAPI spec can exist indefinitely as long as the Logic is sound.

## 4. Recommendations
1. **Implement Repository Contract Tests:** Create a new test suite that strictly verifies every repository method against [Dio](file:///Users/me/myprojects/agentbanking-channel/test/integration/test_fakes.dart#198-204) (mocked) to ensure endpoint strings match [openapi.yaml](file:///Users/me/myprojects/agentbanking-channel/docs/api/openapi.yaml).
2. **Remove Repository-Level Mocks in Integration Tests:** Shift integration tests to use real repositories with shared `ManualMockDio` to increase contract coverage.
3. **Automated OpenAPI Validation:** Use tools like `openapi_generator` or custom linters to ensure repository code reflects the spec.
