# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

Feature: Deleting an article

  Background:
    Given the test user has a book called "test book 1"
    And the book "test book 1" has an article called "test article 1"
    And the article "test article 1" has 3 basic notes
    And I am logged in as the test user
    And I am viewing the article "test article 1"
    And I click the "test book 1" link
    And I click the "test article 1" link
    And I click the "Manage article" link

  @javascript
  Scenario: Confirmation before deleting an article and confirming deletes the article
    When I click the "Delete article: test article 1" button and accept the confirmation
    Then I should not see "test article 1"

  @javascript
  Scenario: Confirmation before deleting an article and dismissing does not delete the article
    When I click the "Delete article: test article 1" button and dismiss the confirmation
    Then I should see "test article 1"
