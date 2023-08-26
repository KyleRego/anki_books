# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

Feature: Creating an article

  @javascript
  Scenario: Adding an article to a book
    Given the test user has a book called "My first book"
    And the book "My first book" has an article called "test article 1"
    And the article "test article 1" has 2 basic notes
    And the book "My first book" has an article called "test article 2"
    And the article "test article 2" has 2 basic notes
    And I am logged in as the test user
    And I click the "Books" link
    And I click the "My first book" link
    And I click the "Show book" link
    And I click the "My first book" link
    Then I should see "My first book"
