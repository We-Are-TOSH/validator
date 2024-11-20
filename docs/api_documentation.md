# ValidateMe API Documentation

Welcome to the ValidateMe API documentation. This API provides services for validating client identity information, handling billing operations, pricing data retrieval, and generating reports. The API is designed to be robust, secure, and easy to integrate, allowing businesses to efficiently handle identity verification, pricing, billing summaries, and reports.

## Base URL
`https://api.validateme.com/v1`

## Authentication

### API Key Authentication

All API requests require authentication via an API Key. The API key must be included in the request headers.
- Header Name: `X-API-Key`
- Type: Bearer Token

The API key should be obtained from the system administrator or through the ApiClient endpoint.

#### Example

`curl -X GET "https://api.validateme.com/v1/validate_id" -H "X-API-Key: <your-api-key>"`

## Endpoints

### 1. Identity Validation

#### Endpoint: `POST /validate_id`

Validates the provided identity number. The request must include the `id_number` parameter, and the API will return a validation result.

#### Request Body

```json
{
  "id_number": "1234567890"
}
```

#### Response

```json
{
  "status": "success",
  "message": "ID validation successful.",
  "data": {
    "is_valid": true,
    "id_number": "1234567890"
  }
}
```

#### Error Response
- 400 Bad Request: Invalid or missing parameters (e.g., missing id_number).
- 401 Unauthorized: Invalid API Key.
- 503 Service Unavailable: Service temporarily unavailable.

### 2. Billing

#### Endpoint: `GET /billing/monthly_summary`

Retrieves the monthly billing summary for the authenticated client. If no month is provided, the current month will be used.

#### Parameters
- `month` (optional): The month for which the summary is requested. Format: `YYYY-MM`

#### Response

```json
{
  "status": "success",
  "summary": {
    "total_billed": 5000,
    "total_paid": 3000,
    "outstanding_balance": 2000
  }
}
```

#### Endpoint: `GET /billing/credit_balance`

Retrieves the current credit balance and the last 10 credit balance changes for the authenticated client.

#### Response

```json
{
  "status": "success",
  "balance": {
    "current_balance": 2000,
    "balance_history": [
      { "amount": 500, "description": "Service fee payment", "date": "2024-11-01" },
      { "amount": -100, "description": "Refund", "date": "2024-10-25" },
      ...
    ]
  }
}
```

### 3. Pricing

#### Endpoint: `GET /pricing`

Retrieves all available pricing information.

#### Response

```json
{
  "status": "success",
  "pricing": [
    {
      "service_type": "identity_verification",
      "base_price": 10,
      "final_price": 12,
      "credits_required": 2,
      "description": "Identity validation for the client."
    },
    {
      "service_type": "transaction",
      "base_price": 5,
      "final_price": 6,
      "credits_required": 1,
      "description": "Transaction fee."
    }
  ]
}
```

### 4. Reports

#### Endpoint: `GET /reports/usage`

Generates a usage report for the authenticated client within a specified date range. If no dates are provided, it will default to the last 30 days.

#### Parameters
- `start_date` (optional): The start date for the report in `YYYY-MM-DD` format.
- `end_date` (optional): The end date for the report in `YYYY-MM-DD` format.

#### Response

```json
{
  "status": "success",
  "report": {
    "total_usage": 100,
    "total_cost": 500
  }
}
```

#### Endpoint: `GET /reports/trends`

Generates a report analyzing the usage trends for the authenticated client.

#### Response

```json
{
  "status": "success",
  "trends": {
    "monthly_trends": [
      { "month": "2024-10", "usage": 120, "cost": 600 },
      { "month": "2024-09", "usage": 100, "cost": 500 },
      ...
    ]
  }
}
```

## Error Handling

### Error Responses

The API uses standard HTTP status codes for error handling:
- 400 Bad Request: The request is invalid or malformed (e.g., missing required parameters).
- 401 Unauthorized: The API key is invalid or missing.
- 403 Forbidden: The client does not have permission to access the resource.
- 404 Not Found: The requested resource could not be found.
- 500 Internal Server Error: An unexpected error occurred on the server.
- 503 Service Unavailable: The service is temporarily unavailable.

### Error Response Format

```json
{
  "status": "error",
  "message": "Description of the error."
}
```

## Example Workflows

### Identity Validation Workflow

1. Client Request: A client sends a POST request to `/validate_id` with an ID number to validate.
2. API Processing: The API validates the ID and returns the result with `is_valid` set to true or false.
3. Client Response: The client receives a JSON response with the validation result.

### Billing Summary Workflow

1. Client Request: A client sends a GET request to `/billing/monthly_summary`.
2. API Processing: The API calculates the total billed, total paid, and outstanding balance.
3. Client Response: The client receives a JSON response with the billing summary.

### Pricing Overview Workflow

1. Client Request: A client sends a GET request to `/pricing`.
2. API Processing: The API retrieves the available pricing for services.
3. Client Response: The client receives a JSON response with the pricing data.

## Rate Limiting

The API implements rate limiting to ensure fair use and prevent abuse. If the client exceeds the rate limit, a 429 Too Many Requests status will be returned.

### Rate Limiting Response

```json
{
  "status": "error",
  "message": "Rate limit exceeded. Please try again later."
}
```

## Webhooks

ValidateMe supports webhooks to notify clients of certain events. Clients can subscribe to specific events (e.g., ID validation results, billing changes). When an event occurs, a notification is sent to the subscribed endpoint.

### Event Example

- Event Name: `identity_verification_completed`
- Payload Example:

```json
{
  "event": "identity_verification_completed",
  "data": {
    "client_id": 123,
    "id_number": "1234567890",
    "is_valid": true
  }
}
```

## Webhook Setup

To set up webhooks, clients must provide a valid callback URL during API key registration or through the API management interface.

## Rate Limits and Throttling

The ValidateMe API is rate-limited to protect resources and ensure service stability. The default rate limits are:
- 50 requests per minute per API key.
- 1000 requests per day per API key.

Clients who exceed the rate limits will receive a 429 Too Many Requests response with instructions to retry later.
