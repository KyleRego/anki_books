# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

Feature: Setting up concepts

  Scenario: Creating a new concept and then updating its name
    Given I am logged in as the test user
    And I click the "Concepts" link
    And I click the "New concept" link
    When I fill in the "Name" field with "A new concept name"
    And I click the "Create Concept" button
    Then I should see "A new concept name"
    And I click the "A new concept name" link
    And I click the "Manage concept" link
    And I click the "Edit concept" link
    And I fill in the "Name" field with "Updated new concept name"
    And I click the "Update Concept" button
    Then I should see "Updated new concept name"
