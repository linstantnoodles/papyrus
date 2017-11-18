Feature: Logging in

    As an admin I should be able to log in so that I can access my content

Scenario: Logging in
    Given an admin user with name "Admin" and password "Password" exists
    When I visit the login page
    And I fill in "name" with "Admin"
    And I fill in "password" with "Password"
    And I click "Login"
    Then I should see "New Post"