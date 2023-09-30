# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

Feature: Deleting a domain

  Background:
    Given there is a user "test_user", email "test@example.com", and password "1234asdf!!!!"
    And the user "test_user" has a domain called "Test domain"
    And the user "test_user" has a book called "Book of the test domain that is not deleted"
    And the book "Book of the test domain that is not deleted" belongs to the "Test domain" domain
    And I am logged in as the user "test_user" with password: "1234asdf!!!!"
    And I click the "Domains" link
    And I click the "Test domain" link
    And I click the "Manage domain" link

  @javascript
  Scenario: Accepting deleting the domain
    When I click the "Delete Test domain" button and accept the confirmation
    Then I should not see "Test domain"
    And I should see "Domains"

  @javascript
  Scenario: Dismissing the confirmation for deleting the domain
    When I click the "Delete Test domain" button and dismiss the confirmation
    Then I should see "Test domain"
