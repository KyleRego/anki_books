# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

Feature: The website homepage
  
  Scenario: Visiting the homepage
    When I visit the root path
    Then I should see the homepage

  Scenario: Visiting the homepage when it has a basic note
    When the homepage has a basic note
    And I visit the root path
    Then I should see "front of homepage basic note"

  Scenario: Visiting the homepage when logged in
    Given there is a user "test_user", email "test@example.com", and password "1234asdf!!!!"
    And I am logged in as the user "test_user" with password: "1234asdf!!!!"
    When I visit the root path
    Then I should see "Books"
    And I should not see a link to the homepage article's book

  Scenario: The Manage link should not be present if not logged in
    When I visit the root path
    Then I should not see "Manage"

  Scenario: The Random article link should not be present if not logged in
    When I visit the root path
    Then I should not see "Random article"
