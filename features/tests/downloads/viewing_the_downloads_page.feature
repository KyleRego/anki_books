# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

Feature: Visiting the Downloads page

  Background:
    Given I visit the root path
    And I am logged in as the test user

  Scenario: Visiting the page
    When I click the "Downloads" link
    Then I should see "Download Anki deck (all books)"
    And I should not see a "Downloads" link
