@javascript
Feature: Reading an article

  Background:
    Given the test user has the test book "test book 1" with the test article "test article 1" that has "100" basic note(s)
    And I am logged in as the test user
    And I am viewing the test article
    And I click the "Study cards" link

  Scenario: Clicking the Random order span should randomize the cards order
    When I click on the span with text "Random order"
    Then I should not see "Front of note 0"
