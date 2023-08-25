# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

@javascript
Feature: Studying the basic notes of a book using keyboard

  Background:
    Given the test user has a book called "test book 1"
    And the book "test book 1" has an article called "test article 1"
    And the article "test article 1" has 10 basic notes
    And the book "test book 1" has an article called "test article 2"
    And the article "test article 2" has 10 basic notes
    And I am logged in as the test user
    And I visit the root path
    And I click the "Books" link
    And I click the "test book 1" link
    And I click the "Study cards" link

  Scenario: Using keyboard to move forward and backward through notes in normal order
    When I click on the span with text "First card"
    Then I should see "Front of note 0"
    And I should not see "Back of note 0"
    When I press the key " "
    Then I should see "Back of note 0"
    When I press the key "1"
    Then I should not see "Back of note 0"
    When I press the key " "
    And I press the key " "
    Then I should see "Front of note 1"
    When I should not see "Back of note 1"
    And I press the key " "
    Then I should see "Back of note 1"
    When I press the key "1"
    And I press the key "1"
    Then I should see "Back of note 0"
    When I press the key "1"
    Then I should not see "Back of note 0"
    
