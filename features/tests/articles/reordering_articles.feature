# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

@javascript
Feature: Reordering the articles of a book

  Background:
    Given there is a user "test_user", email "test@example.com", and password "1234asdf!!!!"
    And the user "test_user" has a book called "Reordering test book"
    And the book "Reordering test book" has 4 numbered articles
    And I am logged in as the user "test_user" with password: "1234asdf!!!!"
    When I visit the root path
    And I click the "Books" link
    And I click the "Reordering test book" link
    And I click the "Manage book" link

  Scenario: Dragging an article up
    When I drag the article with title "Article 0" to below the article with title "Article 2"
    Then the title of the article at position 0 should be "Article 1"

  Scenario: Dragging an article down
    When I drag the article with title "Article 3" to below the article with title "Article 0"
    Then the title of the article at position 1 should be "Article 3"

  Scenario: A sequence of many article repositions
    When I drag the article with title "Article 0" to below the article with title "Article 1"
    When I drag the article with title "Article 2" to below the article with title "Article 3"
    When I drag the article with title "Article 0" to below the article with title "Article 2"
    When I drag the article with title "Article 1" to below the article with title "Article 2"
    Then the title of the article at position 0 should be "Article 3"
    Then the title of the article at position 1 should be "Article 2"
    Then the title of the article at position 2 should be "Article 1"
    Then the title of the article at position 3 should be "Article 0"
