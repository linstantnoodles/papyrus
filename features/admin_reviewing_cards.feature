Feature: Admin reviewing cards

    As an admin I should be able to review the cards that are due for review so that I can remember them longer

    Scenario: Admin reviewing cards
        Given I am a logged in admin
        And a card with front "hello" and back "wow" exists
        And a card with front "there" and back "hey" exists
        And a card with front "yo" and back "not here" exists
        And the card with front "hello" is due for review
        And the card with front "yo" is due for review
        And the card with front "there" is not due for review
        When I visit the admin home page
        And I click "Cards"
        And I click "Review All"
        Then I should see "hello"
        And I click "Show back"
        Then I should see "wow"
        And I click "Perfect!"
        Then I should see "yo"
        And I click "Show back"
        Then I should see "not here"
        And I click "Perfect!"
        Then I should see "New Card"

    Scenario: Admin reviewing cards by tag
        Given I am a logged in admin
        And a card with front "hello" and back "wow" exists
        And the card with front "hello" is due for review
        And the card with front "hello" has tags "apples"
        And a card with front "yo" and back "not here" exists
        And the card with front "yo" is due for review
        And the card with front "yo" has tags "bananas"
        When I visit the admin home page
        And I click "Cards"
        Then I should see "Review by tag"
        And I click "apples"
        Then I should see "hello"
        And I click "Show back"
        Then I should see "wow"
        And I click "Perfect!"
        Then I should see "New Card"
