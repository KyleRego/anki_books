# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

Feature: Parent book

  Scenario: Updating the parent book of a book
    Given there is a user "test_user", email "test@example.com", and password "1234asdf!!!!"
    And the user "test_user" has a book called "Book to be parent"
    And the user "test_user" has a book called "Book to be child"
    And I am logged in as the user "test_user" with password: "1234asdf!!!!"
    And I click the last "Book to be child" link
    And I click the "Manage book" link
    When I choose "Book to be parent" from the "parent_book_id" select
    And I click the "Update parent book" button
    Then I should see "Parent book updated"
    When I click the "Book to be child" link
    Then I should see "Parent book: Book to be parent"
