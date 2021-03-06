Feature: View posts

    As a visitor I should be able to see a list of all published posts and read a single post from the home page

Scenario: Viewing a list of all posts
    Given a post with title "Hello" exists
    And the post "Hello" is published
    And a post with title "World" exists
    And the post "World" is published
    When I visit the home page
    Then I should see "Hello"
    Then I should see "World"

Scenario: Viewing the details of a single post
    Given a post with title "Hello" exists
    And the post "Hello" has content "What's up?"
    And the post "Hello" is published
    When I visit the home page
    And I click "Hello"
    Then I should see "Hello"
    Then I should see "What's up?"
