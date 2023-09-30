# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

Feature: Moving an article to a different book

  Background:
    Given there is a user "test_user", email "test@example.com", and password "1234asdf!!!!"
    And the user "test_user" has a book called "test book 1"
    And the book "test book 1" has the article "test article 1"
    And the article "test article 1" has 3 basic notes
    And the user "test_user" has a book called "test book 2"
    And the book "test book 2" has the article "test article 2"
    And the article "test article 1" has 2 basic notes
    And I am logged in as the user "test_user" with password: "1234asdf!!!!"
    And I click the "Books" link
    And I click the "test book 1" link
    And I click the "test article 1" link
    And I click the "Manage article" link

  @javascript
  Scenario: Moving an article from one book to a different book
    When I choose "test book 2" from the "book_id" select
    And I click the "Move article to selected book" button
    Then I should see "successfully moved to"
    When I click the "Books" link
    And I click the "test book 2" link
    Then I should see "test article 1"
