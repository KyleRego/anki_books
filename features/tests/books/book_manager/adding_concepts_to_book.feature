# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

Feature: Adding concepts to the book

  Scenario: Adding a concept to the book
    Given the test user has a book called "Test book 1"
    And the test user has a concept called "Test concept 1"
    And I am logged in as the test user
    And I click the "Books" link
    And I click the "Test book 1" link
    And I click the "Manage book" link
    And I check the checkbox labeled "Test concept 1"
    And I click the "Update Concepts" button
    Then I should see "Concepts successfully updated"
    When I click the "Concepts" link
    And I click the "Test concept 1" link
    Then I should see "Test book 1"

  Scenario: Removing a concept from the book
    Given the test user has a book called "Test book 2"
    And the test user has a concept called "Test concept 2"
    And the book "Test book 2" has the "Test concept 2" concept
    And I am logged in as the test user
    And I click the "Books" link
    And I click the "Test book 2" link
    And I click the "Manage book" link
    And I uncheck the checkbox labeled "Test concept 2"
    And I click the "Update Concepts" button
    Then I should see "Concepts successfully updated"
    When I click the "Concepts" link
    And I click the "Test concept 2" link
    Then I should not see "Test book 2"
