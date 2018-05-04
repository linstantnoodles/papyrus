Feature: Admin viewing tags

    As an admin I can view the tags in my system

    Scenario: Admin viewing all tags
        Given I am a logged in admin
        And a tag with name "aloe" exists
        When I visit the admin tags page
        Then I should see "aloe"
