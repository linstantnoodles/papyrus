Feature: View posts

    As a visitor I should be able to see a list of all posts and read a single post from the home page

Scenario: Viewing a list of all posts
    Given a post with title "Hello" exists
    And a post with title "World" exists
    When I visit the home page
    Then I should see "Hello"
    Then I should see "World"

Scenario: Viewing the details of a single post
    Given a post with title "Hello" exists
    And the post "Hello" has content "What's up?"
    When I visit the home page
    And I click "Hello"
    Then I should see "Hello"
    Then I should see "What's up?"
