# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

Feature: Updating a domain's child domains

  Scenario: Updating a domain's domains
    Given there is a user "test_user", email "test@example.com", and password "1234asdf!!!!"
    And the user "test_user" has a domain called "Test domain 1"
    And the user "test_user" has a domain called "Test domain 2"
    And the user "test_user" has a domain called "Test domain 3"
    And the user "test_user" has a domain called "Test domain 4"
    And I am logged in as the user "test_user" with password: "1234asdf!!!!"
    And I click the "Domains" link
    And I click the "Test domain 1" link
    And I click the "Manage domain" link
    And I check the child domain checkbox labeled "Test domain 2"
    And I check the child domain checkbox labeled "Test domain 3"
    And I click the "Update Child Domains" button
    Then the child domain checkbox labeled "Test domain 2" should be checked
    And the child domain checkbox labeled "Test domain 3" should be checked
    And the child domain checkbox labeled "Test domain 4" should not be checked
    And I click the "Domains" link
    And I click the "Test domain 2" link
    Then I should see "Parent domain (Test domain 1)"
    And I click the "Test domain 1" link
    Then I should see "Test domain 1"
