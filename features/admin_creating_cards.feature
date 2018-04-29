Feature: Admin creating cards

    As an admin I should be able to create cards for reviewing so that they become a part of my long term memory

    Scenario: Admin creating a card
        Given I am a logged in admin
        When I visit the admin home page
        And I click "Cards"
        And I click "New Card"
        And I fill in "front" with "are all regular languages context free?"
        And I fill in "back" with "yes"
        And I fill in "tags" with "programming languages, grammar"
        And I click "Save"
        Then I should see "are all regular languages context free?"
        Then I should see "programming languages, grammar"
