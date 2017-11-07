Feature: authenticate

Scenario: logging in
    Given I am a user
    When I submit the login form
    Then I am logged in

Scenario: logged in
    Given I am a logged in admin
    When I visit login
    Then I redirected to admin home page
