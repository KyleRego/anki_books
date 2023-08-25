# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

Feature: Viewing domains

  Scenario: Viewing a new domain
    Given the test user has a domain called "domain 1"
    And the test user has a book called "Book 1 of group 1"
    And the test user has a book called "Book 2 of group 1"
    And the book "Book 1 of group 1" belongs to the "domain 1" domain
    And the book "Book 2 of group 1" belongs to the "domain 1" domain
    And the test user has a domain called "domain 2"
    And the test user has a book called "Book 1 of group 2"
    And the book "Book 1 of group 2" belongs to the "domain 2" domain
    And the test user has a domain called "domain 3"
    And I am logged in as the test user
    And I click the "Domains" link
    Then I should see "domain 1"
    And I should see "domain 2"
    And I should see "domain 3"
    And I click the "domain 1" link
    And I click the "Manage domain" link
    Then the checkbox labeled "Book 1 of group 1" should be checked
    And the checkbox labeled "Book 2 of group 1" should be checked
    And the checkbox labeled "Book 1 of group 2" should not be checked

  Scenario: Going back to viewing a domain from the Manage domain page
    Given the test user has a domain called "domain 1"
    And I am logged in as the test user
    And I click the "Domains" link
    And I click the "domain 1" link
    And I click the "Manage domain" link
    Then I should see "Manage domain: domain 1"
    When I click the "domain 1" link
    Then I should see "domain 1"
