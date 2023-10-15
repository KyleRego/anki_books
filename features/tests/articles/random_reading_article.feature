# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

Feature: Going to a random reading article

  Scenario: Clicking the Read link on the homepage goes to a random article
    Given there is a user "test_user", email "test@example.com", and password "1234asdf!!!!"
    And the user "test_user" has a book called "Reordering test book"
    And the book "Reordering test book" has 5 numbered articles
    And I am logged in as the user "test_user" with password: "1234asdf!!!!"
    When I visit the root path
    Then I should see "Read"
    And I should see "Write"
    When I click the "Read" link
    Then I should see "New note"
