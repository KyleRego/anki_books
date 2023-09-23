# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

Feature: Deleting a concept

  Background:
    Given the test user has a concept called "Test concept"
    And I am logged in as the test user
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
