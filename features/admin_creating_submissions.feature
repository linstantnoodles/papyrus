Feature: Admin creating a submission to an exercise

    As an admin I can create new submissions to an exercise to know whether or not I can do the exercise

    @javascript
    Scenario: Admin creating a submission
        Given I am a logged in admin
        And an exercise with title "Wow" exists
        And the exercise "Wow" has description "truth."
        And the exercise "Wow" has test "describe 'truth' do it 'gives truth' do expect(x).to eq(true) end end"
        When I visit the admin exercises page
        And I click "Practice"
        And I fill in "content" with "x = true"
        And I click "Submit"
        Then I should see "1 example, 0 failures"
