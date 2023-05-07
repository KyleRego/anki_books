@javascript
Feature: Reading an article

  Background:
    Given there is an article with "100" basic note(s)
    And I am viewing the article
    And I click the "Study cards" link

  Scenario: Clicking the Random order span should randomize the cards order
    When I click on the span with text "Random order"
    Then I should not see "Front of note 0"
