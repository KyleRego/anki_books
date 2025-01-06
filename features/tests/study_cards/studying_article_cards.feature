# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2025 Kyle Rego

@javascript
Feature: Studying the cards of an article

  Background:
    Given there is a user "test_user", email "test@example.com", and password "1234asdf!!!!"
    And the user "test_user" has a book called "test book 1"
    And the book "test book 1" has the article "test article 1"
    And the article "test article 1" has 3 basic notes
    And I am logged in as the user "test_user" with password: "1234asdf!!!!"
    And I am viewing the article "test article 1"
    And I click the "Study cards" link

  Scenario: Studying the cards in order
    When I click the "First card" button
    Then I should see "Front of note 0"
    And I should not see "Back of note 0"
    And I should not see "First card"
    And I should not see "Random order"
    And I should see "Show answer"
    And I should not see "Next card"
    When I click the "Show answer" button
    Then I should see "Back of note 0"
    And I should see "Next card"
    When I click the "Next card" button
    Then I should see "Front of note 1"

  Scenario: Studying cards in random order
    When I click the "Random order" button
    Then I should not see "First card"
    And I should not see "Random order"
    And I should see "Show answer"
    And I should not see "Next card"
    When I click the "Show answer" button
    Then I should see "Next card"
    And I should not see "Show answer"
    When I click the "Next card" button
    Then I should see "Show answer"
