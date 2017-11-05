Feature: Create post

Scenario: Viewing all posts
    Given I am a logged in admin
    When I visit the posts page
    Then I should see all of my posts

Scenario: Creating a new post
    Given I am a logged in admin
    When I create a new post
    Then it should be visible

Scenario: Editing a post
    Given I am a logged in admin
    When I edit an existing post
    Then I should see the edited post

Scenario: Deleting a post
    Given I am a logged in admin
    When I delete a post
    Then I should not see the post
