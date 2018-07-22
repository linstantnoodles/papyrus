Feature: View book notes posts

    As a visitor I should be able to see the book notes

Scenario: Viewing Today I Learned page
    Given a post with title "Hello" exists
    And the post "Hello" has tag "book notes"
    And the post "Hello" is published
    When I visit the home page
    And I click "Book Notes"
    Then I should see "Hello"
