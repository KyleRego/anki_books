# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

@javascript
Feature: Studying the cards of the homepage

  Scenario: Visiting the homepage when it has a basic note not logged in
    When the homepage has a basic note
    And I visit the root path
    And I click the "Study cards" link
    Then I should not see "Edit"

  Scenario: Visiting the homepage when it has a basic note logged in as the homepage article's user
    Given there is a user "test_user", email "test@example.com", and password "1234asdf!!!!"
    And the user "test_user" has a book called "Book with system article"
    And the homepage belongs to the book "Book with system article"
    And I am logged in as the user "test_user" with password: "1234asdf!!!!"
    And the homepage has a basic note
    And I visit the root path
    And I click the "Study cards" link
    And I click on the span with text "First card"
    Then I should see "Edit"
