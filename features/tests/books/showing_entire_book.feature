# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

Feature: Creating an article

  @javascript
  Scenario: Adding an article to a book
    Given there is a user "test_user", email "test@example.com", and password "1234asdf!!!!"
    And the user "test_user" has a book called "My first book"
    And the book "My first book" has the article "test article 1"
    And the article "test article 1" has 2 basic notes
    And the book "My first book" has the article "test article 2"
    And the article "test article 2" has 2 basic notes
    And I am logged in as the user "test_user" with password: "1234asdf!!!!"
    And I click the last "My first book" link
    And I click the "My first book" link
    Then I should see "Books"
    And I should see "My first book"
