Feature: View today I learned posts

    As a visitor I should be able to see the today I learned page

Scenario: Viewing Today I Learned page
    Given a post with title "Hello" exists
    And the post "Hello" has tag "til"
    And the post "Hello" is published
    When I visit the home page
    And I click "Today I Learned"
    Then I should see "Hello"
