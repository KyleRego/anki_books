@javascript
Feature: Reading an article

  Background:
    Given the test user has a book called "test book 1"
    And the book "test book 1" has an article called "test article 1"
    And the article "test article 1" has 50 basic notes
    And I am logged in as the test user
    And I am viewing the article "test article 1"
    And I click the "Study cards" link

  @retry
  Scenario: Clicking the Random order span should randomize the cards order
    When I click on the span with text "Random order"
    Then I should not see "Front of note 0"
