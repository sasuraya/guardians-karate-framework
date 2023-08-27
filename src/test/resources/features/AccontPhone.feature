@Regression
Feature: Create Account and Add Phone Number

  Background: Setup Test and Create Account
    Given url "https://tek-insurance-api.azurewebsites.net"
    # we use def to define the account and here it create an account for as
    * def createAccountResult = callonce read('CreateAccount.feature')
    And print createAccountResult
    * def validToken = createAccountResult.validToken
    * def createdAccountId = createAccountResult.response.id

  Scenario: Adding Phone number to an Account
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