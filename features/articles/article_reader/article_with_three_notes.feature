Feature: Reading an article with one note

  Background:
    Given there is a book titled "test book 1" with an article titled "test article 1" that has "3" basic note(s)
    And I am logged in

  Scenario: I should see all three notes
    When I am viewing the article
    Then I should see "Front of note 0"
    And I should see "Front of note 1"
    And I should see "Front of note 2"
