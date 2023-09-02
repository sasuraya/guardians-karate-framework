@Regression
Feature: Updateing an account car

  Background: setup test
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def createAccountResult = callonce read('CreateAccount.feature')
    * def validToken = createAccountResult.validToken
    * def generatedAccountId = createAccountResult.response.id

  Scenario: update exising car info from and accout.
    #create an account and add car first
    Given path "/api/accounts/add-account-car"
    And header Authorization = "Bearer " + validToken
    And param primaryPersonId = generatedAccountId
    And request
      """
       {
        "make": "honda",
        "model": "SRV",
        "year": "2017",
        "licensePlate": "VA-1234"
        }
      """
    When method post
    Then status 201
    And print response
    #up to this point make sure to run it to see if a car is addet
    #also we need to have atlest on assertion
    And assert response.make == "honda" 
    #now we have to defin the respos for the new ganarated car id 
    * def carId = response.id
    #here instade of hardcoding i add the defind name for the id
    #now its time to update the car
    Given path "/api/accounts/update-account-car"
    And header Authorization = "Bearer " + validToken
    And param primaryPersonId = generatedAccountId
    And request
      """
         {
          "id": "#(carId)",
          "make": "honda",
          "model": "SRV",
          "year": "2017",
          "licensePlate": "VA-1234"
         }
      """
    When method put
    Then status 202
    And print response
     #up to this point make sure to run it to see if car info is update it. 
    And assert response.model == "SRV"