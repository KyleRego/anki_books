# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

@javascript
Feature: Creating a basic note

  Scenario: Creating a note for the article
    Given the test user has a book called "test book 0"
    And the book "test book 0" has an article called "test article 0"
    And I am logged in as the test user
    And I am viewing the article "test article 0"
    When I click the "New note" link
    And I fill in the "Front" field with "Front of my note"
    And I fill in the "Back" field with "Back of my note"
    And I click the "Create Basic note" button
    Then I should see "Front of my note" in a basic note
    And I should see "Edit" in a basic note
    And I should see 2 links with the text "New note"

  Scenario: Error messages when trying to create an invalid note
    Given the test user has a book called "test book 0"
    And the book "test book 0" has an article called "test article 0"
    And I am logged in as the test user
    And I am viewing the article "test article 0"
    When I click the "New note" link
    And I click the "Create Basic note" button
    Then I should see "2 validation errors"
    And I should see "Front can't be blank"
    And I should see "Back can't be blank"

  Scenario: Error messages when trying to create an invalid note for an article with a note
    Given the test user has a book called "test book 1"
    And the book "test book 1" has an article called "test article 1"
    And the article "test article 1" has 3 basic notes
    And I am logged in as the test user
    And I am viewing the article "test article 1"
    When I click the last "New note" link
    And I click the "Create Basic note" button
    Then I should see "2 validation errors"
    And I should see "Front can't be blank"
    And I should see "Back can't be blank"
