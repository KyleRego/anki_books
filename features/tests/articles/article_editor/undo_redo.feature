# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

@javascript
Feature: Using the undo and redo when editing an article

  Background:
    Given there is a user "test_user", email "test@example.com", and password "1234asdf!!!!"
    And the user "test_user" has a book called "test book 0"
    And the book "test book 0" has the article "test article 0"
    And I am logged in as the user "test_user" with password: "1234asdf!!!!"
    And I am editing the article "test article 0"

  Scenario: Using the Undo button to un-do something
    When I fill in the article editor with "something to undo"
    And I click the "Undo" button
    Then I should not see "something to undo"

  Scenario: Using the Redo button to re-do something
    When I fill in the article editor with "something to undo"
    And I click the "Undo" button
    And I click the "Redo" button
    Then I should see "something to undo"

  Scenario: Using the keyboard shortcut to un-do something
    When I fill in the article editor with "something to undo"
    And I use the ctrl + "z" keyboard shortcut
    Then I should not see "something to undo"

  Scenario: Using the keyboard shortcut to re-do something
    When I fill in the article editor with "something to undo"
    And I click the "Undo" button
    And I use the ctrl + "y" keyboard shortcut
    Then I should see "something to undo"
