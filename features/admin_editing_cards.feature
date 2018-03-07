Feature: Admin editing cards

    As an admin I should be able to edit my cards

    Scenario: Admin editing a card
        Given I am a logged in admin
        And a card with front "hello" and back "wow" exists
        When I visit the admin home page
        And I click "Cards"
        And I click "hello"
        And I fill in "front" with "bye"
        And I click "Save"
        Then I should see "bye"
