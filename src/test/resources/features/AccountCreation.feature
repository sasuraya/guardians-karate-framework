Feature: End-to-End Test for Account Creation

  Background:
    Given url "https://tek-insurance-api.azurewebsites.net"  
    * def createAccountAndPhone = callonce read('CreateAccount.feature')  
    * def validToken = createAccountAndPhone.validToken  
    * def createdAccountId = createAccountAndPhone.response.id  
    And print createAccountAndPhone  

  Scenario: Add address, car and phone number to account
    And path "/api/accounts/add-account-address"  
    And param primaryPersonId = createdAccountId  
    And header Authorization = "Bearer " + validToken  
    And request
      """
      {
      "addressType": "Main 123 St",
      "addressLine1": "",
      "city": "Sterling",
      "state": "Virgina",
      "postalCode": "20164",
      "countryCode": "+1",
      "current": true
      }
      """  
     
    When method post  
    Then status 201  
    And print response 
    And path "/api/accounts/add-account-car"  
    * def licenseGenerator = Java.type('api.utility.date.GenerateData')  
    * def LicensePlate = licenseGenerator.getLicensePlate()  
    And param primaryPersonId = createdAccountId  
    And header Authorization = "Bearer " + validToken  
    And request
      """
      {
      "make": "Honda",
      "model": "CRV",
      "year": "2018",
      "licensePlate": "#(LicensePlate)"
      }
      """   
    When method  post 
    And status 201 
    And print response  
    And assert response.licensePlate == licensePlate
    Given path "/api/accounts/add-account-phone"  
    And param primaryPersonId = createdAccountId  
    And header Authorization = "Bearer " + validToken  
    * def dataGenerator = Java.type('api.utility.date.GenerateData')  
    * def phoneNumber = dataGenerator.getPhoneNumber()  
    And request 
      """
      {
      "phoneNumber": "#(phoneNumber)",
      "phoneExtension": "",
      "phoneTime": "Evening",
      "phoneType": "Mobile"
      }
      """  
     
    When method post  
    Then status 201  
    And assert response.phoneNumber == phoneNumber 
    Given path "/api/accounts/delete-account"  
    And param primaryPersonId = createdAccountId  
    And header Authorization = "Bearer " + validToken  
    When method delete  
    Then status 200  
    And print response  
    And assert response == "Account Successfully deleted"  
