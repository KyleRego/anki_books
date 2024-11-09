# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

Feature: Studying the basic notes of a book

  Background:
    Given there is a user "test_user", email "test@example.com", and password "1234asdf!!!!"
    And the user "test_user" has a book called "test book 1"
    And the book "test book 1" has the article "test article 1"
    And the article "test article 1" has 10 basic notes
    And the book "test book 1" has the article "test article 2"
    And the article "test article 2" has 10 basic notes
    And I am logged in as the user "test_user" with password: "1234asdf!!!!"
    And I visit the root path
    And I click the "Books" link
    And I click the last "test book 1" link

