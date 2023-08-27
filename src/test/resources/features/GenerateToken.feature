Feature: Generate Token for feature

  # here we r trying to autumate 3 seaniros and its all passed
  #we add duplacate features for the senairo and that step runs befor eatch run
  Scenario: Genetate valid token for yesys
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"
    And request {"username" : "supervisor", "password": "tek_supervisor"}
    When method post
    Then status 200
    And print response
   