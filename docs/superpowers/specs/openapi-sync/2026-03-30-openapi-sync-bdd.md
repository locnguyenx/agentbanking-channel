# BDD Scenarios: OpenAPI Sync

## Traceability
- **US-02 / FR-02**: Form Validation based on OpenAPI Specs
- **US-04 / FR-04**: New JomPay Endpoint Integration

## Scenarios

### Scenario 1: Agent enters value exceeding maximum length for text field (Edge Case)
* **Given** the agent is on the Bill Payment form
* **And** the OpenAPI schema defines a `billerCode` maximum length of 10 characters
* **When** the agent types a biller code longer than 10 characters
* **Then** the UI form field instantly displays an error "Cannot exceed 10 characters"
* **And** the "Submit" button remains disabled

### Scenario 2: Agent enters amount below the minimum allowed (Edge Case)
* **Given** the agent is on the Withdrawal form
* **And** the OpenAPI schema defines a minimum withdrawal amount of 10.00
* **When** the agent enters 5.00
* **Then** the UI form displays an error "Amount must be at least 10.00"

### Scenario 3: Agent completes a successful JomPay transaction (Happy Path)
* **Given** the agent has filled out the JomPay form with valid details (Biller Code, Ref-1)
* **When** the agent submits the form
* **Then** the app maps the input to the generated `JomPayExternalRequest` DTO
* **And** sends a POST request to `/api/v1/billpayment/jompay`
* **And** upon success, displays the generated JomPay receipt
