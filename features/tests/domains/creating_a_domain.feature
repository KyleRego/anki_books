# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

Feature: Creating domains

  Scenario: Creating a new domain
    Given there is a user "test_user", email "test@example.com", and password "1234asdf!!!!"
    And I am logged in as the user "test_user" with password: "1234asdf!!!!"
    And I click the "Domains" link
    And I click the "New domain" link
    When I fill in the "Title" field with "A new domain title"
    And I click the "Create Domain" button
    Then I should see "A new domain title"
