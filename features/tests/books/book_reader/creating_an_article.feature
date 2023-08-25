# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

Feature: Creating an article

  @javascript
  Scenario: Adding an article to a book
    Given the test user has a book called "My first book"
    And I am logged in as the test user
    And I click the "Books" link
    And I click the "My first book" link
    And I click the "New article" link
    And I fill in the article editor with "content of a new article"
    And I click the "Create Article" button
    And I click the "My first book" link
    And I click the "My new article" link
    Then I should see "content of a new article"
