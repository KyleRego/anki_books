# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

Feature: Reading an article with one note

  Background:
    Given there is a user "test_user", email "test@example.com", and password "1234asdf!!!!"
    And the user "test_user" has a book called "test book 1"
    And the book "test book 1" has the article "test article 1"
    And the article "test article 1" has 3 basic notes
    And I am logged in as the user "test_user" with password: "1234asdf!!!!"

  Scenario: I should see all three notes
    When I am viewing the article "test article 1"
    Then I should see "Front of note 0"
    And I should see "Front of note 1"
    And I should see "Front of note 2"
