Feature: authenticate

Scenario: logging in
    Given I am a user
    When I submit the login form
    Then I am logged in
