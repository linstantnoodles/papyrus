Feature: Deleting posts

    As an admin I should be able to delete my existing posts so that visitors only see the posts I want them to see

Scenario: Deleting an existing post
    Given I am a logged in admin
    And a post with title "Hello" exists
    When I visit the admin home page
    And I click "Hello"
    And I click "Delete"
    Then I should not see "Hello"
