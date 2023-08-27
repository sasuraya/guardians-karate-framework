@Smoke
Feature: Token Verify Feature

  Background: setup test
    #here we did not add the path because we r using 2 different paths
    Given url "https://tek-insurance-api.azurewebsites.net"

  #S 1
  #first we run it then we verify it in the same scenario by doing that
  #in the HTML result we only see the second result meaning the verifying result
  Scenario: Verify a valid token
    And path "/api/token"
    And request {"username" : "supervisor", "password": "tek_supervisor"}
    When method post
    Then status 200
    And print response
    Then path "/api/token/verify"
    And param username = "supervisor"
    And param token = response.token
    When method get
    Then status 200
    And print response
    And assert response == "true"
    
    #do scenario 5 
    Scenario: Verify token with invalid username
    And path "/api/token"
    And request {"username" : "supervisor", "password": "tek_supervisor"}
    When method post
    Then status 200
    And print response
    Then path "/api/token/verify"
    And param username = "WrongUsername"
    And param token = response.token
    When method get
    Then status 400
    And print response
    And assert response.errorMessage == "Wrong Username send along with Token"
    
    #do scenario 6
    Scenario: Verify token with invalid token
    Given path "/api/token/verify"
    And param token = "Wrong Token"
    And param username = "supervisor"
    When method get
    Then status 400
    And print response
    And assert response.errorMessage == "Token Expired or Invalid Token"
    
    