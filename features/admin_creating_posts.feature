Feature: Creating posts

    As an admin I should be able to create new posts so that I can share my ideas with the world

Scenario: Creating a post
    Given I am a logged in admin
    When I visit the admin home page
    And I click "New Post"
    And I fill in "title" with "Goodbye"
    And I fill in "content" with "Horses"
    And I click "Save"
    Then I should see "Goodbye"
