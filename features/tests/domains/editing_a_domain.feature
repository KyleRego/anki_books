# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

Feature: Editing domains

  Scenario: Editing a new domain
    Given the test user has a domain called "domain to edit"
    And I am logged in as the test user
    And I click the "Domains" link
    And I click the "domain to edit" link
    And I click the "Manage domain" link
    And I click the "Edit domain" link
    And I fill in the "Title" field with "A new domain title"
    And I click the "Update Domain" button
    Then I should see "A new domain title"
