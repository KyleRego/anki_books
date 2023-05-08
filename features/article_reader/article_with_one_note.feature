Feature: Reading an article with one note

  Background:
    Given there is an article with "1" basic note(s)

  Scenario: I should see no Edit links if I am not logged in
    And I am viewing the article
    Then I should not see "Edit"

  Scenario: I should see no New note links if I am not logged in
    When I am viewing the article
    Then I should not see "New note"

  Scenario: The note should be present
    When I am logged in
    And I am viewing the article
    Then I should see "What kind of note is this note?"

  Scenario: I should see the Study cards link
    When I am logged in
    And I am viewing the article
    Then I should see "Study cards"