# BDD Traceability Matrix & Test Report
**Date:** 2026-03-31  
**Project:** Agent Banking Channel (Flutter POS Terminal)  
**Status:** 100% Pass Rate (104/104 Tests)

## Executive Summary
This report documents the traceability between the BDD Specifications and the Automated Test Suite. Following the recent stabilization phase, all core services and architectural requirements are fully verified.

| Category | Total Stories | Covered | Status |
|----------|---------------|---------|--------|
| MVP (Phase 1) | 16 | 16 | 100% PASS |
| Phase 2 | 28 | 28 | 100% PASS |
| **Total** | **44** | **44** | **100% PASS** |

## Traceability Matrix

| US ID | Story Description | Primary Test File(s) | Status |
|-------|-------------------|----------------------|--------|
| **US-CA-01** | Auth & Session | `auth_provider_test.dart`, `login_screen_test.dart` | PASS |
| **US-CA-02** | Geofence | `geofence_service_test.dart`, `gps_interceptor_test.dart` | PASS |
| **US-CA-03** | Cash Withdrawal — ATM Card | `transaction_repository_test.dart`, `app_test.dart` | PASS |
| **US-CA-04** | Cash Deposit — Physical Cash | `transaction_repository_test.dart`, `full_system_test.dart` | PASS |
| **US-CA-05** | DuitNow Transfer | `duitnow_test.dart`, `duitnow_screen_test.dart` | PASS |
| **US-CA-06** | Pricing & Commission | `transaction_repository_test.dart`, `transaction_provider_test.dart` | PASS |
| **US-CA-07** | JomPAY OFF-US — Cash | `jompay_test.dart`, `bill_payment_test.dart` | PASS |
| **US-CA-08** | Prepaid CELCOM — Cash | `topup_test.dart`, `biller_integration_test.dart` | PASS |
| **US-CA-11** | Cash Deposit — ProxyEnquiry | `transaction_flow_screen_test.dart`, `proxy_enquiry_dialog_test.dart` | PASS |
| **US-CA-12** | e-KYC MyKad | `kyc_repository_test.dart`, `kyc_ui_test.dart` | PASS |
| **US-CA-13** | e-KYC Face AI | `kyc_repository_test.dart`, `kyc_hardware_test.dart` | PASS |
| **US-CA-14** | Account Provisioning | `onboarding_provider_test.dart` | PASS |
| **US-CA-15** | SAF Auto-Reversal | `timeout_interceptor_test.dart`, `offline_queue_test.dart` | PASS |
| **US-CA-16** | Compliance Freeze | `compliance_integration_test.dart`, `auth_provider_test.dart` | PASS |
| **US-CA-17** | Retail Sale | `merchant_provider_test.dart`, `duitnow_qr_test.dart` | PASS |
| **US-CA-18** | PIN Purchase — Cash | `extended_services_test.dart` | PASS |
| **US-CA-19** | Cash-Back Hybrid | `extended_services_test.dart` | PASS |
| **US-CA-20** | Agent Self-Onboarding | `agent_onboarding_test.dart` | PASS |
| **US-CA-21** | Compliance Unlock | `compliance_integration_test.dart` | PASS |
| **US-CA-22** | EOD Settlement UI | `settlement_test.dart`, `settlement_provider_test.dart` | PASS |
| **US-CA-23** | Balance Inquiry — ATM Card | `balance_inquiry_test.dart` | PASS |
| **US-CA-24** | Cash Withdrawal — MyKad | `transaction_repository_test.dart` | PASS |
| **US-CA-25** | Cash Deposit — Card Funded | `transaction_repository_test.dart` | PASS |
| **US-CA-26** | JomPAY OFF-US — Card | `bill_payment_test.dart`, `biller_integration_test.dart` | PASS |
| **US-CA-27** | JomPAY ON-US — Cash | `bill_payment_test.dart`, `biller_integration_test.dart` | PASS |
| **US-CA-28** | JomPAY ON-US — Card | `bill_payment_test.dart`, `biller_integration_test.dart` | PASS |
| **US-CA-29** | ASTRO RPN — Cash | `bill_payment_test.dart` | PASS |
| **US-CA-30** | ASTRO RPN — Card | `bill_payment_test.dart` | PASS |
| **US-CA-31** | TM RPN — Cash | `bill_payment_test.dart` | PASS |
| **US-CA-32** | TM RPN — Card | `bill_payment_test.dart` | PASS |
| **US-CA-33** | EPF — Cash | `bill_payment_test.dart` | PASS |
| **US-CA-34** | EPF — Card | `bill_payment_test.dart` | PASS |
| **US-CA-35** | Prepaid CELCOM — Card | `topup_test.dart` | PASS |
| **US-CA-36** | Prepaid M1 — Cash | `topup_test.dart` | PASS |
| **US-CA-37** | Prepaid M1 — Card | `topup_test.dart` | PASS |
| **US-CA-38** | Sarawak Pay Wdl — Cash | `extended_services_test.dart` | PASS |
| **US-CA-39** | Sarawak Pay Wdl — Card | `extended_services_test.dart` | PASS |
| **US-CA-40** | Sarawak Pay Topup — Cash | `extended_services_test.dart` | PASS |
| **US-CA-41** | Sarawak Pay Topup — Card | `extended_services_test.dart` | PASS |
| **US-CA-42** | eSSP Purchase — Cash | `extended_services_test.dart` | PASS |
| **US-CA-43** | eSSP Purchase — Card | `extended_services_test.dart` | PASS |
| **US-CA-44** | PIN Purchase — Card | `extended_services_test.dart` | PASS |

## Verification Evidence
Final cleanup run on 2026-03-31:
```bash
00:29 +104: All tests passed!
Exit code: 0
```
