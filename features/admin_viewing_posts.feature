Feature: Viewing posts

    As an admin I should be able to see all of my posts so and read a single post

Scenario: Viewing a list of all posts
    Given I am a logged in admin
    And a post with title "Hello" exists
    And a post with title "World" exists
    When I visit the admin home page
    Then I should see "Hello"
    Then I should see "World"

Scenario: Viewing the details of a single post
    Given I am a logged in admin
    And a post with title "Hello" exists
    And the post "Hello" has content "What's up?"
    When I visit the admin home page
    And I click "Hello"
    Then I should see "Hello"
    Then I should see "What's up?"

Scenario: When no posts exist
    Given I am a logged in admin
    When I visit the admin home page
    Then I should see "No drafts yet!"
    Then I should see "Nothing published yet!"
