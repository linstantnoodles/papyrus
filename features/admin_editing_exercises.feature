Feature: Editing exerices

    As an admin I should be able to edit my exercises

Scenario: Editing an existing exercise
    Given I am a logged in admin
    And an exercise with title "Wow" exists
    And the exercise "Wow" has description "What is a + b?"
    And the exercise "Wow" has test "expect(ur_fn(1,2)).to eq(3)"
    When I visit the admin exercises page
    And I click "Edit"
    And I fill in "title" with "Goodbye"
    And I click "Save"
    Then I should see "Goodbye"
