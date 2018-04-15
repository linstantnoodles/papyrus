Feature: Admin viewing statistics

    As an admin I should be able to view statistics about my site

    Scenario: Viewing statistics
        Given I am a logged in admin
        And a post with title "Hello" exists
        When I visit the admin home page
        And I click "Statistics"
        Then I should see "Total posts: 1"
