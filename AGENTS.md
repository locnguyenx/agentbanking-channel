# AGENTS.md - Guidelines for Agentic Coding Agents

This document provides instructions and guidelines for AI coding agents working in this repository.

## Project Overview

This project is an **Agent Banking Platform** facilitating financial services at third-party retail locations.
* **Regulatory Compliance:** Bank Malaysia standards.
* **Security:** Zero-trust architecture. No PII in logs. Hardware-level encryption for PINs.

## Architecture

### 5-Tier System Architecture

All agents MUST understand this architecture before making any code changes:

1. **Tier 1: Channel Layer** — POS Terminals (Android/Flutter)
2. **Tier 2: Spring Cloud Gateway** — JWT validation, rate limiting, routing
3. **Tier 3: Domain Core Services** — Rules, Ledger & Float, Onboarding, Switch Adapter, Biller
4. **Tier 4: Translation Layer** — HSM Connector, Switch Connector, Biller Connector
5. **Tier 5: Downstream Systems** — HSM, PayNet, JPN, Billers

See `docs/superpowers/specs/agent-banking-platform/*-design.md` for full architecture details.

### Hexagonal Architecture (MANDATORY per service)

Every microservice MUST follow hexagonal (Ports & Adapters) pattern:

```
service-name/
├── domain/                    # ZERO framework imports
│   ├── model/                 # Entities, value objects (Java Records)
│   ├── port/
│   │   ├── in/                # Inbound ports (use cases)
│   │   └── out/               # Outbound ports (repository, gateway, messaging)
│   └── service/               # Business rules
├── application/               # Use case orchestration
├── infrastructure/            # Adapters (implement ports)
│   ├── web/                   # REST controllers
│   ├── persistence/           # JPA repositories
│   ├── messaging/             # Kafka producers/consumers
│   └── external/              # Feign clients
└── config/                    # Spring configuration
```

**ENFORCEMENT:**
- `domain/` must have ZERO imports from Spring, JPA, Kafka, or any infrastructure framework
- `infrastructure/` implements interfaces defined in `domain/port/`
- Controllers accept DTOs, call use cases, return DTOs — NEVER expose entities
- All financial calculations and state changes in `domain/service/`

## Technology Stack


## Architectural Laws (NON-NEGOTIABLE)

## Coding Standards

## API Contract Enforcement

**OpenAPI 3.0 Specification** is the single source of truth for all REST APIs.

### Rules
- **External API:** All backend REST endpoints exposed via Gateway MUST be documented in `docs/api/openapi.yaml`
- **Internal API:** Each service's internal endpoints documented in `<service-root>/docs/openapi-internal.yaml`
- **Frontend API clients and TypeScript types** MUST be generated from `openapi.yaml`
- **No manual hand-written API mocks** — use generated mocks from OpenAPI spec
- **CI validation**: Run `openapi-generator-cli validate` and diff check

## Documentation
- `docs` - at project root
- `docs/ideas` - high level requirements (ARCHITECTURE.md, BRD_SUMMARY.md)
- `docs/superpowers/specs/agent-banking-platform/` - formal specs (BRD, BDD, Design)
- `docs/api/openapi.yaml` - external API spec

## Testing Guidelines
* Unit tests: 
* Architecture tests: 
* Integration tests: 
* BDD scenarios in `*-bdd.md` are the acceptance criteria

## Banking-Specific Guidelines

### Money Handling
* All monetary values use `BigDecimal` — NEVER use `float` or `double`.
* Rounding: `HALF_UP` to 2 decimal places.
* Currency: Always `MYR` — validate on all endpoints.

### Audit Trail

### Security
* PINs: Hardware-level encryption via HSM. DUKPT PIN blocks. Never decrypted outside HSM.
* PAN: Masked in all responses and logs (first 6, last 4 digits).
* MyKad: Encrypted at rest (AES-256). Never in plaintext logs.
* TLS 1.2+ for all external traffic.
* mTLS for internal service-to-service communication.

### Geofencing
* Transactions allowed only within 100m of registered Merchant GPS coordinate.
* If GPS unavailable: reject transaction with `ERR_GPS_UNAVAILABLE`.

### Velocity Checks
* Limit transactions per MyKad per day to prevent smurfing.
* Configurable via VelocityRule entity.

## Git Workflow

## Database Guidelines

## Test Infrastructure & Strategy
