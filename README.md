ValidateMe - API Documentation
================================

Overview
--------

ValidateMe is a robust API service designed to help businesses verify various forms of identity and perform related billing, pricing, and reporting functionalities. With an easy-to-use set of API endpoints, ValidateMe ensures secure and accurate processing of sensitive information, such as client identification, monthly billing summaries, and usage reports. The system integrates authentication, billing management, and trend analytics into a single platform for seamless business operations.

This project utilizes Ruby on Rails and integrates with various services to provide identity validation, manage billing, and offer insights into usage trends.

Features
--------

### Identity Validation

* **Validate ID**: Validate client identity numbers for authenticity using the IdentityValidationController. This feature is powered by a custom validation service to ensure quick and accurate responses.

### Billing and Credit Management

* **Monthly Summary**: Retrieve a summary of monthly billing details for each client, including credits and debits.
* **Credit Balance**: Access the client’s current credit balance and recent balance history.

### Pricing Information

* **Pricing**: Get all the available pricing details and updates from the PricingController, which delivers current service costs and adjustments.

### Reports and Analytics

* **Usage Report**: Analyze and generate detailed reports on client usage over a selected date range.
* **Trends**: Visualize trends in client behavior and system usage over time.

API Endpoints
-------------

### Identity Validation

* **POST /api/v1/validate_id**: Validates an ID number. This endpoint expects a JSON body containing the ID number to be validated.
Response Example:

```json
{
  "status": "success",
  "validation_result": {
    "valid": true,
    "message": "ID is valid."
  }
}
```

### Billing

* **GET /api/v1/billing/monthly_summary**: Retrieves the monthly billing summary for the current client.
Response Example:

```json
{
  "status": "success",
  "summary": {
    "total_billed": 500,
    "credits_used": 100,
    "balance_due": 400
  }
}

* **GET /api/v1/billing/credit_balance**: Fetches the client’s current credit balance and history.
Response Example:

```json
{
  "status": "success",
  "balance": {
    "current_balance": 1500,
    "balance_history": [
      { "date": "2024-10-01", "amount": 500 },
      { "date": "2024-09-01", "amount": 1000 }
    ]
  }
}

### Pricing

* **GET /api/v1/pricing**: Retrieves all the pricing information for services available through the API.
Response Example:

```json
{
  "status": "success",
  "pricing": [
    {
      "service_type": "identity_verification",
      "base_price": 50,
      "final_price": 55,
      "credits_required": 5
    },
    {
      "service_type": "usage_report",
      "base_price": 100,
      "final_price": 120,
      "credits_required": 10
    }
  ]
}

### Reports

* **GET /api/v1/reports/usage**: Generates a usage report for the current client within the provided date range.
Response Example:

```json
{
  "status": "success",
  "report": {
    "total_usage": 2000,
    "total_credits": 150,
    "usage_details": [
      { "service_type": "identity_verification", "usage": 1000 },
      { "service_type": "usage_report", "usage": 1000 }
    ]
  }
}

* **GET /api/v1/reports/trends**: Retrieves usage trends and client data trends over time.
Response Example:

```json
{
  "status": "success",
  "trends": {
    "monthly_usage": {
      "2024-09": 500,
      "2024-10": 800
    },
    "service_usage": {
      "identity_verification": 1000,
      "usage_report": 1200
    }
  }
}

Authentication
-------------

All requests to the API require authentication using an API key. Clients must provide their API key in the request header as follows:

`X-API-Key: YOUR_API_KEY`

If the API key is invalid or missing, the system will return an unauthorized error.

Setup and Installation
----------------------

### Prerequisites

* Ruby 3.2.0 or higher
* Rails 7.x
* PostgreSQL (for database)
* Redis (for caching and Sidekiq job queue)

### Steps to Set Up

1. **Clone the Repository**

```bash
git clone https://github.com/yourusername/validateme.git
cd validateme
```

2. **Install Dependencies**

```bash
bundle install
```

3. **Set Up the Database**

```bash
rails db:create db:migrate
```

4. **Setup Environment Variables**

Create a `.env` file in the root directory and add your required environment variables:

```bash
DATABASE_URL=postgres://localhost/validateme
REDIS_URL=redis://localhost:6379
```

5. **Start the Server**

```bash
rails server
```

Running Tests
-------------

* **To run the test suite with RSpec**:

```bash
rspec
```

Description of Core Components
-----------------------------

ValidateMe is a comprehensive system that offers validation, billing, and reporting functionality for businesses that need to verify identity numbers, manage client credit balances, and access pricing information. It seamlessly integrates with backend services and ensures real-time processing of sensitive data with top-notch security.

Key Services:

* **Identity Validation**: A dedicated service that validates identity numbers using custom logic.
* **Billing Management**: A service that calculates and manages client billing, providing monthly summaries and credit balance tracking.
* **Pricing Information**: A service that fetches the latest pricing data and applies custom client pricing overrides.
* **Reports & Analytics**: Services that generate usage reports and analyze client trends to improve business decision-making.

License
-------

This project is licensed under the MIT License - see the LICENSE file for details.
