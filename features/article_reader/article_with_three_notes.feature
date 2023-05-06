Feature: Reading an article with one note

  Background:
    Given there is an article with "3" basic note(s)

  Scenario: I should see all three notes
    When I am viewing the article
    Then I should see "Front of note 0"
    And I should see "Front of note 1"
    And I should see "Front of note 2"
