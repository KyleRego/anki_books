# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

Feature: The Books page

  Scenario: The Books link should not show if I am not logged in
    When I visit the root path
    Then I should not see "Books"

  Scenario: The Books link should show if I am logged in
    Given there is a user "test_user", email "test@example.com", and password "1234asdf!!!!"
    And I am logged in as the user "test_user" with password: "1234asdf!!!!"
    When I visit the root path
    Then I should see "Books"

  Scenario: The Books link should not show if I am on the Books page
    Given there is a user "test_user", email "test@example.com", and password "1234asdf!!!!"
    And I am logged in as the user "test_user" with password: "1234asdf!!!!"
    When I visit the root path
    And I click the "Books" link
    Then I should see "Books"
    And I should not see a "Books" link

  Scenario: The Books page should show the Logout link
    Given there is a user "test_user", email "test@example.com", and password "1234asdf!!!!"
    And I am logged in as the user "test_user" with password: "1234asdf!!!!"
    When I visit the root path
    And I click the "Books" link
    Then I should see "Logout"
