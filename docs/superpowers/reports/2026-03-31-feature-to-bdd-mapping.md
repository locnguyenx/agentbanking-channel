# Feature-to-BDD Scenario Mapping (Exact UI Labels)

This document maps the **exact labels** you see in the app to their corresponding BDD Scenarios and User Stories.

## 1. Main Dashboard & Quick Actions
| App Label (UI) | Action / Sub-Label | BDD Scenario | US ID |
| :--- | :--- | :--- | :--- |
| **Withdrawal** | Funding Source: **CARD** | Cash-Out (ATM Card) - Max RM 5,000 | US-CA-03 |
| **Withdrawal** | Funding Source: **MYKAD** | Cash-Out using MyKad Biometric | US-CA-24 |
| **Deposit** | Funding Source: **CASH** | Cash Deposit via Agent Validation (Physical Cash) | US-CA-04 |
| **Deposit** | Funding Source: **CARD** | Card-Funded Deposit (Transfer from Card) | US-CA-25 |
| **Inquiry** | — | Balance Inquiry using ATM Card | US-CA-23 |
| **Logout** (Icon) | — | Secure logout clears all sensitive data | US-CA-01 |

## 2. Main Services Grid
| App Label (UI) | Action / Sub-Label | BDD Scenario | US ID |
| :--- | :--- | :--- | :--- |
| **Onboard** | — | Face AI Liveness (Blink Twice) & MyKad OTP | US-CA-13/14 |
| **Top-up** | Funding: **CASH** / **CARD** | CELCOM/M1 prepaid top-up — card/cash funding | US-CA-35/36 |
| **Bills** | Funding: **CASH** / **CARD** | ASTRO/TM/EPF bill payment — card/cash funding | US-CA-29/31/33 |
| **E-Wallet** | **TOP-UP** (Cash/Card) | Sarawak Pay e-Wallet top-up | US-CA-40 |
| **E-Wallet** | **WITHDRAW** | Sarawak Pay e-Wallet withdrawal | US-CA-38 |
| **Cashless** | Funding: **CARD** | Retail Sale (Card) - Max RM 3,000 (STP Cap) | US-CA-17 |
| **Cashless** | Funding: **DUITNOW QR** | Retail Sale (QR) - Dynamic QR Polling | US-CA-17 |
| **eSSP** | Funding: **CASH** / **CARD** | eSSP certificate purchase | US-CA-42/43 |
| **JomPAY** | — | JomPAY OFF-US bill payment — cash funding | US-CA-07 |

## 3. Sub-Features (Transaction Forms)
| App Label (UI) | Parent Feature | BDD Scenario | US ID |
| :--- | :--- | :--- | :--- |
| **PIN Purchase** | **eSSP** / **Services** | PIN Voucher Purchase — agent sells for cash | US-CA-18 |
| **Cash-Back** | **Deposit** (Hybrid) | Cash-Back Hybrid — purchase + cash-back | US-CA-19 |

## 4. Security & Compliance (System Screens)
| App Feature | UI State / Banner | BDD Scenario | US ID |
| :--- | :--- | :--- | :--- |
| Geofencing | "ERR_VAL_GEOFENCE_BREACH" | Transaction blocked outside 100m geofence | US-CA-02 |
| Compliance Lock | "LOCKED" (Red Banner) | Velocity breach immediately locks terminal | US-CA-16 |
| EOD Settlement | "End of Day Settlement initiates..." | 23:55 MYT warning displayed to agent | US-CA-22 |
| Active Reversal | "Request Timeout / Reversal queued" | Immediate reversal on timeout | US-CA-15 |
