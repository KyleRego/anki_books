# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

@javascript
Feature: Updating a basic note

  Background:
    Given the test user has a book called "test book 1"
    And the book "test book 1" has an article called "test article 1"
    And the article "test article 1" has 1 basic notes
    And I am logged in as the test user
    And I am viewing the article "test article 1"

  Scenario: Editing the note and updating it
    When I click "Edit" on the basic note
    And I fill in the basic note edit form with the following data:
      | Field  | Value       |
      | Front  | Front Value |
      | Back   | Basic Value |
    And I click the "Update Basic note" button
    Then I should see "Front Value"
    And I should see "Edit" in a basic note
    And I should see "New note" 2 times

  Scenario: Error messages when trying to update the note to be invalid
    When I click "Edit" on the basic note
    And I fill in the basic note edit form with the following data:
    | Field   | Value |
    | Front   |       |
    | Back    |       |
    And I click the "Update Basic note" button
    Then I should see "2 validation errors"
    And I should see "Front can't be blank"
    And I should see "Back can't be blank"
