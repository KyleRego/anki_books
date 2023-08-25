# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

Feature: Moving an article to a different book

  Background:
    Given the test user has a book called "test book 1"
    And the book "test book 1" has an article called "test article 1"
    And the article "test article 1" has 3 basic notes
    And the test user has a book called "test book 2"
    And the book "test book 2" has an article called "test article 2"
    And the article "test article 1" has 2 basic notes
    And I am logged in as the test user
    And I click the "Books" link
    And I click the "test book 1" link
    And I click the "test article 1" link
    And I click the "Manage article" link

  @javascript
  Scenario: Moving an article from one book to a different book
    When I choose "test book 2" from the "book_id" select
    And I click the "Move this article to a different book" button
    Then I should see "successfully moved to"
    When I click the "Books" link
    And I click the "test book 2" link
    Then I should see "test article 1"
