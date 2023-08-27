#for this we have created a class in src/test/Java ,
#Package name api.utility.date, class name GenerateData
@Regression
Feature: Create Account feature

  Background: Setup test and generate token.
    * def result = callonce read('GenerateToken.feature')
    * def validToken = result.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Create valid account
    Given path "/api/accounts/add-primary-account"
    And header Authorization = "Bearer " + validToken
    # Calling Java class in feature file.
    # here we use package name and class name / ('api.utility.date.GenerateData')
    # to create object from Java Class.
    * def generateDataObject = Java.type('api.utility.date.GenerateData')
    # here we static call to getEmail address
    * def autoEmail = generateDataObject.getEmail()
    And request
      """  
      {  
          
      "email": "#(autoEmail)",  
         
      "firstName": "toto",
          
      "lastName": "boss",
      
      "title": "Mrs.",
      
      "gender": "FEMALE",
      
      "maritalStatus": "SINGLE",
      
      "employmentStatus": "Software Student",
      
      "dateOfBirth": "1986-02-28"
      
      }

      """
    When method post
    Then status 201
    And print response
    And assert response.email == autoEmail
    
    #using delete endpoint to remove generate account for continues execution.   
    #Given path "/api/accounts/delete-account"
    #And param primaryPersonId = response.id
    #And header Authorization = "Bearer " + validToken
    #When method delete
    #Then status 201
    #And print response    
    #And assert response == "Account Successfully deleted"
