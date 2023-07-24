Feature: Visiting the Downloads page

  Background:
    Given I visit the root path
    And I am logged in as the test user

  Scenario: Visiting the page
    When I click the "Downloads" link
    Then I should see "Download Anki deck (all books)"
    And I should not see a "Downloads" link
