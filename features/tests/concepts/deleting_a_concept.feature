# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

Feature: Deleting a concept

  Background:
    Given there is a user "test_user", email "test@example.com", and password "1234asdf!!!!"
    And the user "test_user" has a concept called "Test concept"
    And I am logged in as the user "test_user" with password: "1234asdf!!!!"
    And I click the "Concepts" link
    And I click the "Test concept" link
    And I click the "Manage concept" link

  @javascript
  Scenario: Accepting deleting the concept
    When I click the "Delete Test concept" button and accept the confirmation
    Then I should not see "Test concept"
    And I should see "Concepts"

  @javascript
  Scenario: Dismissing the confirmation for deleting the concept
    When I click the "Delete Test concept" button and dismiss the confirmation
    Then I should see "Test concept"
