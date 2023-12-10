# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

@javascript
Feature: Creating a basic note

  Scenario: Creating a note for the article
    Given there is a user "test_user", email "test@example.com", and password "1234asdf!!!!"
    And the user "test_user" has a book called "test book 0"
    And the book "test book 0" has the article "test article 0"
    And I am logged in as the user "test_user" with password: "1234asdf!!!!"
    And I am viewing the article "test article 0"
    When I click the "New basic note" link
    And I fill in the "Front" field with "Front of my note"
    And I fill in the "Back" field with "Back of my note"
    And I click the "Create Basic note" button
    Then I should see "Front of my note" in a basic note
    And I should see "Edit" in a basic note
    And I should see 2 links with the text "New basic note"
