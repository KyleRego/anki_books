Feature: Reading an article

  Background:
    Given there is an article with a basic note

  Scenario: I should see no Edit links if I am not logged in
    And I am viewing the article
    Then I should not see "Edit"

  Scenario: The note should be present
    When I am logged in
    And I am viewing the article
    Then I should see "What kind of note is this note?"
