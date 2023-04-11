# Identity Verification API
Overview
The Identity Verification API allows users to verify the identity of an individual using their South African ID number. The API accepts an ID number and returns the first names, last name, date of birth, age, gender, citizenship, and date issued of the individual, if the ID number is valid.

# Endpoint
`GET /id_number`

# Parameters
id_number - a required parameter that contains the 13-digit ID number of the individual to verify.

# Returns
The API returns a JSON object with the following properties:

`Status` - a string indicating whether the ID number is valid or invalid.

`Verification` - an object containing the following properties if the ID number is valid:

`Firstnames` - the first names of the individual.

`Lastname` - the last name of the individual.

`Dob` - the date of birth of the individual.

`Age` - the age of the individual.

`Gender` - the gender of the individual.

`Citizenship` - the citizenship of the individual.

`DateIssued` - the date the ID was issued.


# Examples
**Valid ID Number Request:**

`GET /id_number?id_number=9404271234567`

**Response:**

`{
"Status": "ID Number Valid",
"Verification": {
"Firstnames": "Nick",
"Lastname": "Fury",
"Dob": "1994-04-27",
"Age": 29,
"Gender": "Male",
"Citizenship": "South African",
"DateIssued": "2012-02-04T22:00:00.000Z"
}
}`

**Invalid ID Number Request:**

`GET /id_number?id_number=1234567890123`


**Response:**

`{
"Status": "ID Number Invalid"
}`



# Services

**CheckCreditsService**

This service is responsible for checking the number of credits remaining on a VerifyID account.

**Methods**

**check_credits(api_key)**:
This method accepts an API key and returns the number of credits remaining on the account associated with that API key.

**credits_count**:
This method returns the number of credits remaining on the account associated with the API key defined in the VERIFYID_API_KEY environment variable.

**ValidateIdService**:
This service is responsible for validating South African ID numbers using the VerifyID API.

**validate_id(api_key, id_number)**:
This method accepts an API key and a South African ID number and returns the validation status and verification data for that ID number.
