@Smoke
Feature: Security Token Tests

  # Here we r trying to automate 3 seniors and it all passed
  #we add duplicate features for the scenario and that step runs before each run
  Background: setup test
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"

  Scenario: Generate a valid token with a valid username and password
    #prepare request
    And request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    And print response

  #We add """ before and after of a long line or a line with multi options to separate them
  #2
  # The scenario outline keyword can be used to run the same scenario multiple times
  # with different combinations of values here like S1 and S2
  Scenario Outline: Validate token with invalid username
    And request
      """
      {
      "username": "Wrongusername",
      "password": "tek_supervisor"
      }
      """
    When method post
    Then status 400
    And print response
    And assert response.errorMessage == "User not found"

    Examples: 
      | username      | password      | errormessage     |
      | wrongUsername | tek_supevisor | User not found   |
      | supervisor    | wrongpassword | User Not Matched |
