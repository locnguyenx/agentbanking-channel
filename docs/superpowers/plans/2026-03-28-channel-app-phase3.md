# Channel App — Phase 3 Roadmap

**Goal:** Expand the Agent Banking Channel's capabilities beyond domestic services by implementing Cross-Border Remittance (XBR), real-time agent performance analytics, and specialized dispute management workflows.

**Architecture:** 
- **XBR:** Leverages a new `XbrRepository` communicating with the backend's international rails.
- **Analytics:** Uses a new `DashboardProvider` to aggregate daily/weekly transaction data for the agent.
- **Dispute:** Extends the existing reversal logic with a "Manual Reversal Request" flow and Support Ticket integration.
- **Sync:** Implements a shared-float mechanism for merchants with multiple POS terminals.

---

## 🏗 High-Level Roadmap

### Task 1: Cross-Border Remittance (XBR)
* **Outbound (Send):** FX Quoting + AML (MyKad) + Global Payout.
* **Inbound (Receive):** MTCN verification + Cash/Card Payout.
* **BDD Reference:** (To be drafted in `*-bdd.md`)

### Task 2: Advanced Analytics & Dashboard
* **Performance Charts:** Transaction volume & Commission trends.
* **Liquidity Forecast:** Alerts for low float based on usage patterns.

### Task 3: Dispute Management & Support UI
* **Advanced History:** Search by RRN, MTCN, or Customer IC.
* **Support Tickets:** In-app CRM integration.

### Task 4: Multi-Terminal Sync
* **Merchant-Level Settlement:** Consolidated EOD across multiple terminals.
* **Shared Float:** Real-time balance locking across a store's device fleet.

---

## 📂 New Files Structure

| File | Responsibility | 
|------|---------------|
| `lib/features/xbr/providers/xbr_provider.dart` | Outbound/Inbound XBR state engine |
| `lib/features/xbr/screens/xbr_send_screen.dart` | FX Quoting & Recipient Details UI |
| `lib/features/xbr/screens/xbr_payout_screen.dart` | MTCN-based payout UI |
| `lib/features/dashboard/providers/analytics_provider.dart` | Performance data aggregation |
| `lib/features/support/screens/dispute_resolver_screen.dart` | Transaction-level reversal & ticketing |

---

## 📝 Task 1 Implementation: Cross-Border Remittance (XBR)

- [ ] **Step 1: Define XBR Models & Repository**
  - Implement `XbrQuoteResponse` with FX rates and 60s expiry.
  - Implement `XbrRepository` with `/api/v1/xbr/quote` and `/api/v1/xbr/execute` endpoints.

- [ ] **Step 2: Create XBR Outbound Flow**
  - Select Target Country (e.g., ID, PH, VN, CN).
  - Select Currency (USD, IDR, PHP, etc.).
  - Mandatory MyKad scan for ALL remittance amounts (compliance requirement).

- [ ] **Step 3: Create XBR Inbound Flow (Payout)**
  - Enter MTCN (Western Union / MoneyGram style).
  - Verify Receiver Identity (MyKad lookup).
  - Dispense Cash & Confirm Payout.

- [ ] **Step 4: Verification**
  - Automated tests for FX rate expiry (quote invalidation).
  - Integration tests for successful XBR Saga (Reserve Float → External XBR Auth → Commit).
