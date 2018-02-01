Feature: Admin viewing submissions for an exercise

    As an admin I can view my submissions for an exercise to get a sense of progress over time

    Scenario: Admin viewing submissions
        Given I am a logged in admin
        And an exercise with title "Wow" exists
        And a submission with content "x = 1" exists for exercise "Wow"
        And a submission with content "y = 2" exists for exercise "Wow"
        When I visit the admin exercises page
        And I click "Submissions"
        Then I should see "x = 1"
        Then I should see "y = 2"
