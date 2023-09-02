#@Regression
Feature: verify Account

  Background: setup test
    #by adding this step in background
    #we dont need to generate token manuilly in automation
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def result = callonce read('GenerateToken.feature')
    And print result
    * def validToken = result.response.token
  #7
  Scenario: Verify and account that is exist
    Given path "/api/accounts/get-account"
    #with def step u can create a veriable and assing value for reusability
    #we use * befor define
    * def existingId = 9513
    And param primaryPersonId = existingId
    #Header must be add it in request for the respons
    #because thats how we stord our token in header
    And header Authorization = "Bearer " + validToken
    When method get
    Then status 200
    And print response
    And assert response.primaryPerson.id == existingId

  # 8
  Scenario: Verify get-account with is not exist
    Given path "/api/accounts/get-account"
    And header Authorization = "Bearer " + validToken
    * def notExistingId = 33333
    And param primaryPersonId = notExistingId
    When method get
    Then status 404
    And print response
    And assert response.errorMessage == "Account with id " + notExistingId + " not found"
