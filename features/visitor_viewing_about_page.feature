Feature: Viewing about page

    As a visitor I should be able to view information about the author

    Scenario: Viewing the about page
        When I visit the home page
        And I click "About"
        Then I should see "About"
