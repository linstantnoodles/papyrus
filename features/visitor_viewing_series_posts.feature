Feature: Visitor viewing series posts

    As a visitor I want to see a individual series page and a list of available series to read on the site.

    Scenario: Visiting a list of all series
        Given a post with title "Hello" exists
        And the post "Hello" has content "World"
        And the post "Hello" has 2 child posts
        And the post "Hello" is published
        When I visit the home page
        And I click "Series"
        Then I should see "Hello"
        Then I should see "World"

    Scenario: Viewing the details of a single series
        Given a post with title "Parent Hello" exists
        And the post "Parent Hello" is published
        Given a post with title "Hello" exists
        And the post "Hello" is a child of post "Parent Hello"
        And the post "Hello" is published
        When I visit the home page
        And I click "Series"
        And I click "Parent Hello"
        Then I should see "Hello"
