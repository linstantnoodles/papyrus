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

Scenario: Creating a child post
    Given I am a logged in admin
    And a post with title "Parent Hello World" exists
    And the post "Parent Hello World" has content "Ready for this?"
    When I visit the admin home page
    And I click "Parent Hello World"
    And I click "New Child Post"
    And I fill in "title" with "First Post"
    And I fill in "content" with "Winning"
    And I click "Save"
    Then I should see "Parent hello world (series)"
    Then I should see "First Post"
