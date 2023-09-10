# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

Feature: The Books page

  Scenario: The Books link should not show if I am not logged in
    When I visit the root path
    Then I should not see "Books"

  Scenario: The Books link should show if I am logged in as the test user
    Given I am logged in as the test user
    When I visit the root path
    Then I should see "Books"

  Scenario: The Books link should not show if I am on the Books page
    Given I am logged in as the test user
    When I visit the root path
    And I click the "Books" link
    Then I should see "Books"
    And I should not see a "Books" link

  Scenario: The Books page should show the Logout link
    Given I am logged in as the test user
    When I visit the root path
    And I click the "Books" link
    Then I should see "Logout"
