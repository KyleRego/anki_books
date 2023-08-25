# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

Feature: Creating a book

@javascript
Scenario: Creating a new book from the Books page
    Given I am logged in as the test user
    When I visit the root path
    And I click the "Books" link
    And I click the "New book" link
    When I fill in the "Title" field with "My new book!"
    And I click the "Create Book" button
    Then I should see "My new book!"
