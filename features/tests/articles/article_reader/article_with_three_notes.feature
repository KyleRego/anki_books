Feature: Reading an article with one note

  Background:
    Given the test user has the test book "test book 1" with the test article "test article 1" that has "3" basic note(s)
    And I am logged in as the test user

  Scenario: I should see all three notes
    When I am viewing the test article
    Then I should see "Front of note 0"
    And I should see "Front of note 1"
    And I should see "Front of note 2"
