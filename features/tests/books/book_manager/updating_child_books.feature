# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

@javascript
Feature: Updating a book's child books

  Scenario: Updating a book's child books
    Given there is a user "test_user", email "test@example.com", and password "1234asdf!!!!"
    And the user "test_user" has a book called "Test book 1"
    And the user "test_user" has a book called "Test book 2"
    And the user "test_user" has a book called "Test book 3"
    And the user "test_user" has a book called "Test book 4"
    And I am logged in as the user "test_user" with password: "1234asdf!!!!"
    And I click the "Books" link
    And I click the last "Test book 1" link
    And I click the "Manage book" link
    And I scroll to the update child books area
    And I check the child book checkbox labeled "Test book 2"
    And I check the child book checkbox labeled "Test book 3"
    And I click the "Update child books" button
    Then I should see "updated"
    When I click the last "Test book 1" link
    Then I should see "Test book 2"
    And I should see "Test book 3"
    When I click the "Books" link
    And I click the last "Test book 2" link
    Then I should see "Parent book: Test book 1"
