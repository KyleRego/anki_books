Feature: Reading an article with one note

  Background:
    Given the test user has a book called "test book 1"
    And the book "test book 1" has an article called "test article 1"
    And the article "test article 1" has 3 basic notes
    And I am logged in as the test user

  Scenario: I should see all three notes
    When I am viewing the article "test article 1"
    Then I should see "Front of note 0"
    And I should see "Front of note 1"
    And I should see "Front of note 2"
