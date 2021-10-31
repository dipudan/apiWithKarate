Feature: Testing create user API in https://reqres.in/.
         Sample Endpoint : https://reqres.in/api/users.
         Sample Data : { "name": "morpheus", "job": "leader"}

  Background:
    * url 'https://reqres.in/'
    * def resource = 'api/users'
    * def user = Java.type('examples.util.Util')
    * json random_user = user.createRandomUser()

  Scenario: create a user by dynamically using data set by faker.
    Given path resource
    And header Content-Type = 'application/json; charset=utf-8'
    And request random_user
    When method post
    Then status 201
    Then match response.firstname == random_user.firstname
    Then match response.lastname == random_user.lastname
    Then match response.id == '#notnull'


  Scenario: create a user by using a data template json and setting value in it.
    * def first_name = user.createRandomName()
    * def last_name = user.createRandomName()
    * def user_data = read('../resources/templateUserCreation.json')

    Given path resource
    And header Content-Type = 'application/json; charset=utf-8'
    And request user_data
    When method post
    Then status 201
    Then match response.firstname == first_name
    Then match response.lastname == last_name
    Then match response.id == '#notnull'