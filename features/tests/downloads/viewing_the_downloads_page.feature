# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

Feature: Visiting the Downloads page

  Background:
    Given I visit the root path
    And I am logged in as the test user

  Scenario: Visiting the page when the user's Anki package attachment yet
    When I click the "Downloads" link
    Then I should see "Create and download Anki deck"
    And I should not see a "Downloads" link
    And I should not see a "Download Anki deck created by job" link
