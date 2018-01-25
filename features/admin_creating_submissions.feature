Feature: Admin creating a submission to an exercise

    As an admin I can create new submissions to an exercise to know whether or not I can do the exercise

    Scenario: Admin creating a submission
        Given I am a logged in admin
        And an exercise with title "Wow" exists
        And the exercise "Wow" has description "What is a + b?"
        And the exercise "Wow" has test "expect(ur_fn(1,2)).to eq(3)"
        When I visit the admin exercises page
        And I click "New Submission"
        And I fill in "content" with "def ur_fn(a,b):\n  a+b"
        And I click "Save"
        Then I should see "Good Work!"
