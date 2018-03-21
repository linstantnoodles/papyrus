Feature: Editing posts

    As an admin I should be able to edit my existing posts so that I can revise and improve my content overtime

Scenario: Editing an existing post
    Given I am a logged in admin
    And a post with title "Hello" exists
    And the post "Hello" has content "What's up?"
    When I visit the admin home page
    And I click "Hello"
    And I fill in "title" with "Goodbye"
    And I click "Save"
    Then I should see "Goodbye"

Scenario: Publishing an existing draft post
    Given I am a logged in admin
    And a post with title "Hello" exists
    And the post "Hello" is a draft
    And the post "Hello" has content "What's up?"
    When I visit the admin home page
    And I click "Publish"
    When I visit the home page
    Then I should see "Hello"

Scenario: Adding post to a series
    Given I am a logged in admin
    And a post with title "Hello Parent" exists
    And a post with title "Hello Child" exists
    When I visit the admin home page
    And I click "Hello Child" for row with text "Hello Child"
    And I select "Hello Parent" for "Parent"
    And I click "Save"
    And I click "Hello Parent"
    Then I should see "Hello Child"
