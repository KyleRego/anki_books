@javascript
Feature: Studying cards of a domain

  Background:
    Given the test user has a domain called "domain 1"
    And the test user has a book called "Book 1"
    And the test user has a book called "Book 2"
    And the book "Book 1" belongs to the "domain 1" domain
    And the book "Book 2" belongs to the "domain 1" domain
    And the book "Book 1" has an article called "test article 1"
    And the article "test article 1" has 3 basic notes
    And the book "Book 2" has an article called "test article 2"
    And the article "test article 1" has 3 basic notes
    And I am logged in as the test user
    And I click the "Domains" link
    And I click the "domain 1" link
  
  Scenario: Going to the study cards page and back
    When I click the "Study cards" link
    Then I should see "First card"
    And I should see "Random order"
    When I click the "Back to domain" link
    Then I should see "domain 1"

  Scenario: Studying the cards
    When I click the "Study cards" link
    And I click on the span with text "First card"
    Then I should see "Front of note 0"
    When I click on the span with text "Next card"
    Then I should see "Front of note 1"
    And I should not see "Back of note 1"
    When I press the key " "
    Then I should see "Back of note 1"
    When I press the key " "
    Then I should not see "Back of note 1"
    And I should see "Front of note 2"
    When I press the key "1"
    Then I should see "Back of note 1"
    When I click the "Back to domain" link
    Then I should see "domain 1"
