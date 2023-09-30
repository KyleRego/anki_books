# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

Feature: Viewing root domains

  Scenario: Setting a domain to be a child domain and then viewing the root domains
    Given there is a user "test_user", email "test@example.com", and password "1234asdf!!!!"
    And the user "test_user" has a domain called "domain 1"
    And the user "test_user" has a domain called "domain 2"
    And the user "test_user" has a domain called "domain 3"
    And I am logged in as the user "test_user" with password: "1234asdf!!!!"
    And I click the "Domains" link
    And I click the "domain 1" link
    And I click the "Manage domain" link
    And I check the child domain checkbox labeled "domain 2"
    And I click the "Update Child Domains" button
    And I click the "Root domains" link
    Then I should see "domain 1"
    And I should not see "domain 2"
    And I should see "domain 3"
