# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

Feature: Adding the book to domains

  Scenario: Adding a book to a domain
    Given the test user has a domain called "Test domain"
    And the test user has a book called "Test book"
    And I am logged in as the test user
    And I click the "Books" link
    And I click the "Test book" link
    And I click the "Manage book" link
    And I check the checkbox labeled "Test domain"
    And I click the "Update Domains" button
    Then I should see "Domains successfully updated"
    When I click the "Domains" link
    And I click the "Test domain" link
    And I click the "Manage domain" link
    Then the checkbox labeled "Test book" should be checked

  Scenario: Removing a book from a domain
    Given the test user has a domain called "domain"
    And the test user has a book called "Test book 1"
    And the book "Test book 1" belongs to the "domain" domain
    And I am logged in as the test user
    And I click the "Books" link
    And I click the "Test book" link
    And I click the "Manage book" link
    And I uncheck the checkbox labeled "domain"
    And I click the "Update Domains" button
    Then I should see "Domains successfully updated"
    When I click the "Domains" link
    And I click the "domain" link
    And I click the "Manage domain" link
    Then the checkbox labeled "Test book 1" should not be checked