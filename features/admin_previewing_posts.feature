Feature: Previewing posts

    As an admin I should be able to see a preview of a post as if I'm a visitor so I know what it looks like

Scenario: Previewing a single post
    Given I am a logged in admin
    And a post with title "Hello" exists
    And the post "Hello" has content "What's up?"
    When I visit the admin home page
    And I click "Hello"
    And I click "Preview"
    Then I should see "Preview"
    Then I should see "Draft"
    Then I should see "Hello"
    Then I should see "What's up?"

Scenario: Previewing a child post
    Given I am a logged in admin
    And a post with title "Hello Parent" exists
    And a post with title "Hello Child" exists
    And the post "Hello Child" is a child of post "Hello Parent"
    When I visit the admin home page
    And I click "Hello Parent"
    And I click "Preview"
    And I click "Hello Child"
    Then I should see "Hello child"
    Then I should see "Preview"

Scenario: Returning to edit after preview
    Given I am a logged in admin
    And a post with title "Hello" exists
    And the post "Hello" has content "What's up?"
    When I visit the admin home page
    And I click "Hello"
    And I click "Preview"
    Then I should see "Preview"
    And I click "Edit"
    Then I should see button "Save"
