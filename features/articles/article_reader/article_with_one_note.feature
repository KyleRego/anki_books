Feature: Reading an article with one note

  Background:
    Given there is a book titled "test book 1" with an article titled "test article 1" that has "1" basic note(s)

  Scenario: The note should be present
    When I am logged in
    And I am viewing the article
    Then I should see "What kind of note is this note?"

  Scenario: I should see the Study cards link
    When I am logged in
    And I am viewing the article
    Then I should see "Study cards"
