Feature: Creating Exercises

    As an admin I should be able to create new exercises to solve

    Scenario: Creating an exercise
        Given I am a logged in admin
        And I visit the admin exercises page
        And I click "New Exercise"
        And I fill in "title" with "Ruby Ranges"
        And I fill in "description" with "Write a function to print numbers between 1 and 10 (inclusive)."
        And I fill in "test" with "expect(x).to eq('hello world')"
        And I click "Save"
        Then I should see "Ruby Ranges"
