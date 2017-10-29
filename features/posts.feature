Feature: Posts feature

Scenario: Viewing all posts
    When I visit the home page
    Then I should see the posts

Scenario: Viewing a post
    When I visit a post page
    Then I should see the post details
