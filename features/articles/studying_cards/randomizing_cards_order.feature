@javascript
Feature: Reading an article

  Background:
    Given there is a book titled "test book 1" with an article titled "test article 1" that has "100" basic note(s)
    And I am logged in
    And I am viewing the article
    And I click the "Study cards" link

  Scenario: Clicking the Random order span should randomize the cards order
    When I click on the span with text "Random order"
    Then I should not see "Front of note 0"
