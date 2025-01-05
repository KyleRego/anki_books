# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

@javascript
Feature: Adding quotes when editing an article

  Background:
    Given there is a user "test_user", email "test@example.com", and password "1234asdf!!!!"
    And the user "test_user" has a book called "test book 0"
    And the book "test book 0" has the article "test article 0"
    And I am logged in as the user "test_user" with password: "1234asdf!!!!"
    And I am editing the article "test article 0"

  Scenario: Adding a quote to the article using the Quote button
    When I click the "Quote" button
    And I fill in the article editor with "Great power comes with..."
    And I click the "Save changes" button
    Then I should see "Great power comes with..." as a quote

  Scenario: Adding a quote to the article and then removing it using the Quote button
    When I click the "Quote" button
    And I fill in the article editor with "Great power comes with..."
    And I click the "Save changes" button
    And I click the "Edit" link
    And I click the "Quote" button
    And I click the "Save changes" button
    Then I should see "Great power comes with..." but not as a quote
