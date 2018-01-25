Feature: Viewing exercises

    As an admin I should be able to see all of my exercises so and read a single exercise

Scenario: Viewing a list of all exercises
    Given I am a logged in admin
    And an exercise with title "Hello" exists
    And an exercise with title "World" exists
    When I visit the admin exercises page
    Then I should see "Hello"
    Then I should see "World"

Scenario: Viewing the details of a single exercise
    Given I am a logged in admin
    And an exercise with title "Hello" exists
    And the exercise "Hello" has description "What's up?"
    And the exercise "Hello" has test "a equals b"
    When I visit the admin exercises page
    And I click "Hello"
    Then I should see "Hello"
    Then I should see "What's up?"
    Then I should see "a equals b"
