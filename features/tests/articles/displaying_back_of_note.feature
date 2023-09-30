# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

Feature: Displaying the back of the basic note

  Background:
    Given there is a user "test_user", email "test@example.com", and password "1234asdf!!!!"
    And the user "test_user" has a book called "test book 1"
    And the book "test book 1" has the article "test article 1"
    And the article "test article 1" has 1 basic notes
    And I am logged in as the user "test_user" with password: "1234asdf!!!!"
    And I am viewing the article "test article 1"

  Scenario: Not seeing the back of the note before it's clicked
    Then I should see "What kind of note is this note?"
    And I should not see "This is a Basic note."

  @javascript
  Scenario: Clicking the note to reveal the back
    When I click on the span with text "What kind of note is this note?"
    Then I should see "This is a Basic note."
