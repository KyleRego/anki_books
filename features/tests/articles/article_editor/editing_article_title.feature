# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

@javascript
Feature: Editing the article title

  Scenario: Updating an article with a title with periods
    Given the test user has a book called "test book 0"
    And the book "test book 0" has an article called "test article 0"
    And I am logged in as the test user
    And I am editing the article "test article 0"
    And I fill in the article editor with "some text"
    And I click the "Update Article" button
    Then I should be redirected to the article "test article 0"
    And I should see "some text"
