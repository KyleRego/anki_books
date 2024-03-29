# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

@javascript
Feature: Reordering basic notes

  Background:
    Given there is a user "test_user", email "test@example.com", and password "1234asdf!!!!"
    And the user "test_user" has a book called "test book 1"
    And the book "test book 1" has the article "test article 1"
    And the article "test article 1" has 5 basic notes
    And I am logged in as the user "test_user" with password: "1234asdf!!!!"
    And I am viewing the article "test article 1"

  Scenario: Reordering one basic note with drag and drop
    When I drag the note at position "0" to the dropzone at position "3"
    Then the front of the note at position "3" should be "Front of note 0"
    When I refresh the page
    Then the front of the note at position "3" should be "Front of note 0"

  Scenario: Reordering notes several times to reverse the original order
    When I drag the note at position "4" to the dropzone at position "0"
    And I drag the note at position "1" to the dropzone at position "4"
    And I drag the note at position "3" to the dropzone at position "1"
    And I drag the note at position "3" to the dropzone at position "2"
    Then the front of the note at position "0" should be "Front of note 4"    
    And the front of the note at position "1" should be "Front of note 3"
    And the front of the note at position "2" should be "Front of note 2"
    And the front of the note at position "3" should be "Front of note 1"
    And the front of the note at position "4" should be "Front of note 0"
    When I refresh the page
    Then the front of the note at position "0" should be "Front of note 4"
    And the front of the note at position "1" should be "Front of note 3"
    And the front of the note at position "2" should be "Front of note 2"
    And the front of the note at position "3" should be "Front of note 1"
    And the front of the note at position "4" should be "Front of note 0"
