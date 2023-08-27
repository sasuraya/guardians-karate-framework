Feature: Simple Account Creation Test

  Background:
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def accountInfo = callonce read('CreateAccount.feature')
    * def validToken = accountInfo.validToken
    * def accountId = accountInfo.response.id

  Scenario: Add address, car, and phone number to account
    * def addressPayload =
      """
      {
        "addressType": "Main 123 St",
        "city": "Sterling",
        "state": "Virginia",
        "postalCode": "20164",
        "countryCode": "+1",
        "current": true
      }
      
      """
    * call accountInfo("/api/accounts/add-account-address", accountId, validToken, addressPayload)
    * def carPayload =
      """
      {
        "make": "Honda",
        "model": "CRV",
        "year": "2018",
        "licensePlate": "Plate123"
      }
      """
    * call postAccountInfo("/api/accounts/add-account-car", createdAccountId, validToken, carPayload)

    * def phonePayload =
      """
      {
        "phoneNumber": "123-456-7890",
        "phoneTime": "Evening",
        "phoneType": "Mobile"
      }
      """
    * call postAccountInfo("/api/accounts/add-account-phone", createdAccountId, validToken, phonePayload)

    * call deleteAccount("/api/accounts/delete-account", createdAccountId, validToken)
