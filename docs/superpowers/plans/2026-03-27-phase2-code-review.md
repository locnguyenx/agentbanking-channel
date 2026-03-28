# Code Review: Channel App — Phase 2 Features

## What Was Implemented
Implemented Phase 2 features including Agent Self-Onboarding, EOD Settlement UI, Compliance Unlock Webhook simulation, Merchant Services (Retail Sale, Cashback, PIN Purchase), Extended Financial Services, and DuitNow Transfer.

## Requirements/Plan
Plan Reference: `docs/superpowers/plans/2026-03-27-channel-app-phase2.md`

## Git Range to Review
**Base:** `63c99c1 docs: finalize MVP corrections plan with actual implementation details`
**Head:** `aaa8bcd feat: Agent Self-Onboarding with STP and manual review support...` 

## Output Format

### Strengths
- Comprehensive additions of all missing service screens (`duitnow_transfer_screen.dart`, `cashback_screen.dart`, etc.) following the existing pattern.
- State machines appropriately extended with `validatingService`, `processingDuitNow`, and `waitingMyKadScan`.
- Added considerable `flutter test` coverage for all the newly implemented providers and UI workflows.

### Issues

#### Critical (Must Fix)
1. **Test Suite Compilation Errors**
   - File: `test/features/transactions/transaction_provider_test.dart:27` & `44`
   - File: `lib/features/transactions/screens/transaction_flow_screen.dart:89` & `365`
   - Issue: The `TransactionNotifier` constructor was changed to require `reversalService` but the test was not updated. The `_buildStateView` method in `transaction_flow_screen.dart` is missing a default `return` statement (causing a null safety error), and there's a type mismatch with `Map<String, dynamic>`.
   - Why it matters: The CI pipeline is completely broken and `flutter test` cannot run. Code with compilation errors cannot be merged.
   - Fix: Fix the missing parameters in tests, and return `const SizedBox.shrink()` default in `_buildStateView`. Clean up Map typing in `startTransaction`.

2. **Silently Dropped Reversals on Timeout**
   - File: `lib/features/transactions/providers/transaction_provider.dart:340-344`
   - Issue: When `_execute` catches a `DioExceptionType.receiveTimeout`, it correctly sets the provider state to `TransactionStatus.reversalQueued`, but it **forgets to actually call `await _queueReversal();`**.
   - Why it matters: If the POS connection drops during processing, the user is told a reversal is queued, but the system never actually transmits the reversal request to `ReversalService`. Float/cash will be lost forever.
   - Fix: Add `await _queueReversal();` into the `catch (e)` block immediately preceding the state change.

#### Important (Should Fix)
1. **Unauthorized Local Float Adjustment in Merchant Services**
   - File: `lib/features/merchant/providers/merchant_provider.dart:108-115`
   - Issue: `processCardSale` and `processCashbackHandshake` avoid hitting the backend `TransactionRepository` completely. They use a `Future.delayed` and generate a mock `RetailSaleResponse` by physically calculating `state.amount! - state.mdr!` locally. 
   - Why it matters: The phase 2 design strictly dictates `"Float is NOT adjusted locally — response from backend is authoritative"`. We must invoke a backend `/api/v1/...` route or `repository.executeTransaction` so the system-of-record performs the accounting. Leaving this mocked hides actual integration.
   - Fix: Add proper repository execution methods for merchant sale/cashback, and remove the local amount math.

2. **Compliance Unlock Listener Not Implemented**
   - File: `lib/features/compliance/providers/compliance_provider.dart:31-35`
   - Issue: The plan directed to create `lib/core/compliance/compliance_unlock_listener.dart` to actually execute a periodic 5 min poll to `/api/v1/compliance/status`. The implementation merely added a `simulateWebhookUnlock()` mock method.
   - Why it matters: This feature is essential for Agent backoffice orchestration. A purely simulated delay cannot connect to backend STP approval workflows.
   - Fix: Implement the background periodic loop or FCM listener as designed.

#### Minor (Nice to Have)
1. **File Path Drift**
   - Issue: `compliance_provider.dart` and `settlement_provider.dart` were created under `features/` rather than `core/` as dictated by the plan.
   - Impact: Minor architectural divergence, but makes code discovery slightly harder.

### Recommendations
- Tidy up the compiler warnings proactively rather than relying on the PR gate.
- Re-run the integration tests with a manual run of `flutter test test/features/transactions/` before pushing.

### Assessment

**Ready to merge?** No

**Reasoning:** The application currently fails compilation due to type issues and missing required parameters in tests. The critical bug where `transaction_provider` silently eats reversal triggers during real timeouts must be remediated immediately. Fix the Critical and Important issues, verify all tests pass, and re-request review.
