# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

@javascript
Feature: Flipping a basic note between front and back

  Scenario: Adding a new note at the top and then reordering it
    Given there is a user "test_user", email "test@example.com", and password "1234asdf!!!!"
    And the user "test_user" has a book called "test book 1"
    And the book "test book 1" has the article "test article 1"
    And the article "test article 1" has 1 basic notes
    And I am logged in as the user "test_user" with password: "1234asdf!!!!"
    And I am viewing the article "test article 1"
    When I click the 1st link with text "New basic note"
    And I fill in the "Front" field with "test insert note"
    And I fill in the "Back" field with "test insert note back"
    And I click the "Create Basic note" button
    And I drag the note at position "0" to the dropzone at position "1"
    Then the front of the note at position "1" should be "test insert note"

  Scenario: Adding a new note at the bottom and then reordering it
    Given there is a user "test_user", email "test@example.com", and password "1234asdf!!!!"
    And the user "test_user" has a book called "test book 1"
    And the book "test book 1" has the article "test article 1"
    And the article "test article 1" has 2 basic notes
    And I am logged in as the user "test_user" with password: "1234asdf!!!!"
    And I am viewing the article "test article 1"
    When I click the 3rd link with text "New basic note"
    And I fill in the "Front" field with "test insert note"
    And I fill in the "Back" field with "test insert note back"
    And I click the "Create Basic note" button
    And I drag the note at position "2" to the dropzone at position "0"
    And I drag the note at position "0" to the dropzone at position "1"
    Then the front of the note at position "1" should be "test insert note"

  Scenario: Adding a new note in the middle and then reordering it
    Given there is a user "test_user", email "test@example.com", and password "1234asdf!!!!"
    And the user "test_user" has a book called "test book 1"
    And the book "test book 1" has the article "test article 1"
    And the article "test article 1" has 2 basic notes
    And I am logged in as the user "test_user" with password: "1234asdf!!!!"
    And I am viewing the article "test article 1"
    When I click the 2nd link with text "New basic note"
    And I fill in the "Front" field with "test insert note"
    And I fill in the "Back" field with "test insert note back"
    And I click the "Create Basic note" button
    And I drag the note at position "0" to the dropzone at position "1"
    Then I should not see two adjacent New note links
    And the front of the note at position "1" should be "Front of note 0"
