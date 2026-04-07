# API Contract Mismatch Report

This document identifies discrepancies between the current Agent Banking Channel implementation and the formal [openapi.yaml](file:///Users/me/myprojects/agentbanking-channel/docs/api/openapi.yaml) specification.

## Summary of Mismatches

| Endpoint | Repository Method | Status in OpenAPI | Purpose |
| :--- | :--- | :--- | :--- |
| `POST /api/v1/transactions/quote` | `TransactionRepository.getQuote` | **MISSING** | Calculate fees/commission before execution. |
| `GET /api/v1/transfer/proxy/enquiry` | `TransactionRepository.performProxyEnquiry` | **MISSING** | Resolve DuitNow proxy (e.g. Phone) to Name. |
| `GET /api/v1/compliance/status` | `TransactionRepository.getComplianceStatus` | **MISSING** | Check for agent compliance freezes. |
| `GET /api/v1/agent/balance` | `FloatRepository.getFloatStatus` | **ALIGNED** | Fetch current agent float balance. |
| `POST /api/v1/auth/token` | *AuthRepository (Pending)* | **ALIGNED** | Authenticate and retrieve JWT. |

---

## Detailed Endpoint Specifications (Missing from OpenAPI)

### 1. Transaction Quote
**Endpoint:** `POST /api/v1/transactions/quote`  
**Purpose:** Retrieves a mandatory quote before executing any financial transaction. This ensures the user is aware of fees and that the platform calculates the correct commission.  
**Request Body:**
```json
{
  "amount": "100.00",
  "serviceCode": "CASH_WITHDRAWAL",
  "fundingSource": "CARD_EMV"
}
```
**Expected Response:**
```json
{
  "quoteId": "QT-12345",
  "amount": "100.00",
  "fee": "1.00",
  "total": "101.00",
  "commission": "0.50"
}
```

### 2. DuitNow Proxy Enquiry
**Endpoint:** `GET /api/v1/transfer/proxy/enquiry`  
**Purpose:** Resolves a proxy ID (Phone, NRIC, Passport) to the account holder's registered name on the DuitNow network.  
**Parameters:**
- `proxyId` (string): The identifier to look up.
- `proxyType` (string): MOBILE, NRIC, PASSPORT, BIZ_REG_NO.
**Expected Response:**
```text
"AHMAD BIN ABDULLAH" (Plain string or JSON depending on Gateway version)
```

### 3. Compliance Status
**Endpoint:** `GET /api/v1/compliance/status`  
**Purpose:** Periodically polled or checked on login to determine if the agent is allowed to perform transactions.  
**Auth:** Bearer Token required.  
**Expected Response:**
```text
"UNLOCKED" or "LOCKED"
```

---

## Documentation Corrections
> [!NOTE]
> The [FloatRepository](file:///Users/me/myprojects/agentbanking-channel/lib/features/settlement/repositories/float_repository.dart#5-24) was previously documented as using `/api/v1/ledger/balance/{agentId}`. This was an error in the implementation plan summary. The actual implementation (via generated [LedgerControllerLedgerServiceApi](file:///Users/me/myprojects/agentbanking-channel/lib/api/generated/lib/src/api/ledger_controller_ledger_service_api.dart#21-636)) correctly calls `GET /api/v1/agent/balance?agentId={id}` which is aligned with the current OpenAPI spec.

## Recommendations
1. **Update OpenAPI:** Incorporate the three missing endpoints into [openapi.yaml](file:///Users/me/myprojects/agentbanking-channel/docs/api/openapi.yaml) to ensure they can be formally tested and generated.
2. **Auth Refactor:** The [AuthRepository](file:///Users/me/myprojects/agentbanking-channel/lib/features/auth/repositories/auth_repository.dart#5-57) currently uses a mock model. It should be refactored to use the `/api/v1/auth/token` endpoint as specified in the OpenAPI.
