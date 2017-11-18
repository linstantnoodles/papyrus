Feature: Editing posts

    As an admin I should be able to edit my existing posts so that I can revise and improve my content overtime

Scenario: Editing an existing post
    Given I am a logged in admin
    And a post with title "Hello" exists
    And the post "Hello" has content "What's up?"
    When I visit the admin home page
    And I click "Edit"
    And I fill in "title" with "Goodbye"
    And I click "Save"
    Then I should see "Goodbye"
