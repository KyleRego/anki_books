# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

@javascript
Feature: Creating an article

  Background: Adding an article to a book
    Given there is a user "test_user", email "test@example.com", and password "1234asdf!!!!"
    And the user "test_user" has a book called "My first book"
    And the book "My first book" has the article "test article 1"
    And the article "test article 1" has 2 basic notes
    And the book "My first book" has the article "test article 2"
    And the article "test article 2" has 2 basic notes
    And I am logged in as the user "test_user" with password: "1234asdf!!!!"
    And I click the last "My first book" link
    And I click the "My first book" link

  Scenario: Dragging basic notes from the second article to the first
    When I drag the note at position "2" to the dropzone at position "1"
    And I drag the note at position "3" to the dropzone at position "2"
    Then the front of the note at position "0" should be "Front of note 0"
    And the front of the note at position "1" should be "Front of note 0"
    And the front of the note at position "2" should be "Front of note 1"
    And the front of the note at position "3" should be "Front of note 1"
    And the article "test article 1" should have 4 basic notes
    And the article "test article 2" should have 0 basic notes
    When I refresh the page
    Then the front of the note at position "0" should be "Front of note 0"
    And the front of the note at position "1" should be "Front of note 0"
    And the front of the note at position "2" should be "Front of note 1"
    And the front of the note at position "3" should be "Front of note 1"

  Scenario: Dragging basic notes from the first article to the second
    When I drag the note at position "1" to the dropzone at position "3"
    And I drag the note at position "0" to the dropzone at position "3"
    Then the front of the note at position "0" should be "Front of note 0"
    And the front of the note at position "1" should be "Front of note 1"
    And the front of the note at position "2" should be "Front of note 0"
    And the front of the note at position "3" should be "Front of note 1"
    And the article "test article 1" should have 0 basic notes
    And the article "test article 2" should have 4 basic notes
    When I refresh the page
    Then the front of the note at position "0" should be "Front of note 0"
    And the front of the note at position "1" should be "Front of note 1"
    And the front of the note at position "2" should be "Front of note 0"
    And the front of the note at position "3" should be "Front of note 1"

  Scenario: Dragging a note back and forth
    When I drag the note at position "1" to the dropzone at position "3"
    Then the article "test article 1" should have 1 basic notes
    And the article "test article 2" should have 3 basic notes
    When I drag the note at position "1" to the dropzone at position "0"
    Then the article "test article 1" should have 2 basic notes
    And the article "test article 2" should have 2 basic notes
    When I drag the note at position "3" to the dropzone at position "1"
    Then the article "test article 1" should have 3 basic notes
    And the article "test article 2" should have 1 basic notes
