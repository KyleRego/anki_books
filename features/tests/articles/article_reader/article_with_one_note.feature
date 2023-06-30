Feature: Reading an article with one note

  Background:
    Given the test user has the test book "test book 1" with the test article "test article 1" that has "1" basic note(s)

  Scenario: The note should be present
    When I am logged in as the test user
    And I am viewing the test article
    Then I should see "What kind of note is this note?"

  Scenario: I should see the Study cards link
    When I am logged in as the test user
    And I am viewing the test article
    Then I should see "Study cards"
