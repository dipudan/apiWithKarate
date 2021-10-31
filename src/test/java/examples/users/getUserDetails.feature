Feature: Testing get user API in https://reqres.in/.
         Sample Endpoint : https://reqres.in/api/users/3.

  Background:
    * url 'https://reqres.in/'
    * def expected_output_jsonFile = read('../resources/user.json')
    * def expected_output_variable =
    """
    {
     "support":
            {"url":"https://reqres.in/#support-heading","text":"To keep ReqRes free, contributions towards server costs are appreciated!"}
    }
    """
    * def resource = 'api/users'

  Scenario: get user by id and validate details
    * def id = 2
    Given path resource,id
    When method get
    Then status 200
    And match response.data.id == 2
    And match response.data.email == 'janet.weaver@reqres.in'
    And match response.support.text == 'To keep ReqRes free, contributions towards server costs are appreciated!'

  Scenario Outline: get user by id and validate details from datatable
    Given path resource,<id>
    When method get
    Then status 200
    And match response.data.id == <id>
    And match response.data.email == <email>
    And match response.data.first_name == <first_name>
    And match response.data.last_name == <last_name>

    Examples:
    | id |      email             | first_name|last_name|
    |  2 |'janet.weaver@reqres.in'|  'Janet' | 'Weaver'|
    |  3 |  'emma.wong@reqres.in' |  'Emma'  | 'Wong'  |

  Scenario: get user by id and validate response with expected output defined in a variable

    * def id = 1
    Given path resource,id
    When method get
    Then status 200
    And match response contains expected_output_variable

  Scenario: get user by id and validate response with expected output defined
            in an external json file.

    Given path resource,1
    When method get
    Then status 200
    And match response == expected_output_jsonFile