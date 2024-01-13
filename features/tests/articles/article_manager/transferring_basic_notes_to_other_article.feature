# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

Feature: Moving basic notes to a different article

  Background:
    Given there is a user "test_user", email "test@example.com", and password "1234asdf!!!!"
    And the user "test_user" has a book called "test book 1"
    And the book "test book 1" has the article "test article 1"
    And the article "test article 1" has 7 basic notes
    And the book "test book 1" has the article "test article 2"
    And the article "test article 2" has 2 basic notes
    And I am logged in as the user "test_user" with password: "1234asdf!!!!"
    And I click the last "test book 1" link
    And I click the "test article 1" link
    And I click the "Manage article" link
  
  Scenario: Transferring basic notes to the other article
    When I check the checkbox for the basic note with front "Front of note 0"
    And I check the checkbox for the basic note with front "Front of note 2"
    And I check the checkbox for the basic note with front "Front of note 5"
    And I choose "test article 2" from the "target_article_id" select
    And I click the "Move basic notes to selected article" button
    Then I should see "Selected basic notes moved to test article 2."
    And I click the "Books" link
    And I click the last "test book 1" link
    And I click the "test article 2" link
    Then I should see "Front of note 0"
    And I should see "Front of note 2"
    And I should see "Front of note 5"
