Feature: Admin viewing cards

    As an admin I should be able to view the cards that I've created

    Scenario: Viewing a list of all posts
        Given I am a logged in admin
        And a card with front "Hello" exists
        And a card with front "World" exists
        And the card with front "Hello" is due for review today
        And the card with front "World" is due for review tomorrow
        When I visit the admin home page
        And I click "Cards"
        Then I should see "Hello"
        Then I should see "World"
        Then I should see "Today"
        Then I should see "Tomorrow"
