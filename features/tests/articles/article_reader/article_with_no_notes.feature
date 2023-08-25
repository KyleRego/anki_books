# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

Feature: Reading an article with no notes

  Background:
    Given the test user has a book called "test book 0"
    And the book "test book 0" has an article called "test article 0"

  Scenario: Clicking the Edit link if I am logged in as the test user
    When I am logged in as the test user
    And I am viewing the article "test article 0"
    When I click the "Edit" link
    Then I should be redirected to the editor for the article "test article 0"

  @javascript
  Scenario: I should see the Create Basic note form if I am logged in as the test user
    When I am logged in as the test user
    And I am viewing the article "test article 0"
    Then I should see "New note"
    When I click the "New note" link
    Then I should see an input with value "Create Basic note"

  Scenario: I should not see the Study cards link of an article with no notes
    When I am logged in as the test user
    And I am viewing the article "test article 0"
    Then I should not see "Study cards"
