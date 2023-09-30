# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

@javascript
Feature: Deleting basic notes of an article

  Background:
    Given there is a user "test_user", email "test@example.com", and password "1234asdf!!!!"
    And the user "test_user" has a book called "test book 1"
    And the book "test book 1" has the article "test article 1"
    And the article "test article 1" has 10 basic notes
    And I am logged in as the user "test_user" with password: "1234asdf!!!!"
    And I am viewing the article "test article 1"
    And I click the "test book 1" link
    And I click the "test article 1" link
    And I click the "Manage article" link

  Scenario: Deleting the first basic note
    Then I should see "Front of note 0"
    When I click the 1st button with text "Delete" and accept the confirmation
    Then I should not see "Front of note 0"
