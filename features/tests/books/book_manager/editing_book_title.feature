# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

Feature: Editing a book's title

  Background:
    Given there is a user "test_user", email "test@example.com", and password "1234asdf!!!!"
    And the user "test_user" has a book called "My first book"
    And I am logged in as the user "test_user" with password: "1234asdf!!!!"
    And I click the last "My first book" link
    And I click the "Manage book" link
    And I click the "Edit book" link

  Scenario: Visiting the edit book page
    Then I should see "Edit book: My first book"

  Scenario: Updating the book title
    When I fill in the "Title" field with "new title"
    And I click the "Update Book" button
    And I click the last "new title" link
    Then I should see "new title"

  Scenario: The link to the book should be present if the update fails
    When I fill in the "Title" field with ""
    And I click the "Update Book" button
    Then I should see a "My first book" link
