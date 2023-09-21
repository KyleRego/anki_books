# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

Feature: Setting up concepts

  Scenario: Creating a new concept and then updating its name
    Given I am logged in as the test user
    And the test user has a concept called "parent concept"
    And the test user has a concept called "child concept"
    And I click the "Concepts" link
    And I click the "child concept" link
    And I click the "Manage concept" link
    When I choose "parent concept" from the "parent_concept_id" select
    And I click the "Update parent concept" button
    Then I should see "Parent concept updated"
    When I click the "child concept" link
    Then I should see "Parent concept: parent concept"
