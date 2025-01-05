# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

@javascript
Feature: Adding italic text when editing an article

  Background:
    Given there is a user "test_user", email "test@example.com", and password "1234asdf!!!!"
    And the user "test_user" has a book called "test book 0"
    And the book "test book 0" has the article "test article 0"
    And I am logged in as the user "test_user" with password: "1234asdf!!!!"
    And I am editing the article "test article 0"

  Scenario: Adding italic text to the article and saving it
    When I click the "Italic" button
    And I fill in the article editor with "some italic text"
    And I click the "Save changes" button
    Then I should see "some italic text" in italics

  Scenario: Using the keyboard shortcut to add italic text
    When I focus the article editor
    And I use the ctrl + "i" keyboard shortcut
    And I fill in the article editor with "some italic text"
    And I click the "Save changes" button
    Then I should see "some italic text" in italics
