# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

Feature: Moving articles to a different book from the manage book page

  Background:
    Given there is a user "test_user", email "test@example.com", and password "1234asdf!!!!"
    And the user "test_user" has a book called "source book"
    And the book "source book" has the article "test article 1 - a"
    And the book "source book" has the article "test article 2 - b"
    And the book "source book" has the article "test article 3 - c"
    And the user "test_user" has a book called "target book"
    And I am logged in as the user "test_user" with password: "1234asdf!!!!"
    And I click the "Books" link
    And I click the last "source book" link
    And I click the "Manage book" link
  
  Scenario: Transferring articles to the other book
    When I check the checkbox labeled "test article 1 - a"
    And I check the checkbox labeled "test article 2 - b"
    And I choose "target book" from the "target_book_id" select
    And I click the "Move articles to selected book" button
    Then I should see "Selected articles moved to target book."
    And I click the "Books" link
    And I click the last "target book" link
    Then I should see "test article 1 - a"
    And I should see "test article 2 - b"
    And I should not see "test article 3 - c"
