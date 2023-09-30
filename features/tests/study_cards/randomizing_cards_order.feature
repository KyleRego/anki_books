# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

@javascript
Feature: Reading an article

  Background:
    Given there is a user "test_user", email "test@example.com", and password "1234asdf!!!!"
    And the user "test_user" has a book called "test book 1"
    And the book "test book 1" has the article "test article 1"
    And the article "test article 1" has 50 basic notes
    And I am logged in as the user "test_user" with password: "1234asdf!!!!"
    And I am viewing the article "test article 1"
    And I click the "Study cards" link

  @retry
  Scenario: Clicking the Random order span should randomize the cards order
    When I click on the span with text "Random order"
    Then I should not see "Front of note 0"
