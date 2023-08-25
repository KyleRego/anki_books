# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

Feature: Going to a random article

  Scenario: Clicking the random article link on the homepage goes to a random article
    Given the test user has a book called "Reordering test book"
    And the book "Reordering test book" has 5 numbered articles
    And I am logged in as the test user
    When I visit the root path
    And I click the "Random article" link
    Then I should see "New note"
