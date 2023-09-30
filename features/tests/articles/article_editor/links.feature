# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

@javascript
Feature: Adding links when editing an article

  Background:
    Given there is a user "test_user", email "test@example.com", and password "1234asdf!!!!"
    And the user "test_user" has a book called "test book 0"
    And the book "test book 0" has the article "test article 0"
    And I am logged in as the user "test_user" with password: "1234asdf!!!!"
    And I am editing the article "test article 0"

  Scenario: Clicking the Link button 
    When I click the "Link" button
    Then I should see a "Enter a URL…" placeholder

  Scenario: Adding a link to the article without selecting text first
    When I click the "Link" button
    And I fill in the link URL form with "https://kylerego.github.io"
    And I click the URL form "Link" button
    And I click the "Update Article" button
    Then I should see the text "https://kylerego.github.io" linking to "https://kylerego.github.io"

  Scenario: Adding a link after selecting some text
    When I fill in the article editor with "this is my link"
    And I select the text in the article editor
    And I click the "Link" button
    And I fill in the link URL form with "https://kylerego.github.io"
    And I click the URL form "Link" button
    And I click the "Update Article" button
    Then I should see the text "this is my link" linking to "https://kylerego.github.io"

  Scenario: Selecting a link and making it not a link
    When I fill in the article editor with "this is my link to test making it not a link"
    And I select the text in the article editor
    And I click the "Link" button
    And I fill in the link URL form with "https://kylerego.github.io"
    And I click the URL form "Link" button
    And I select the text in the article editor
    And I click the "Link" button
    And I click the URL form "Unlink" button
    Then I should see "this is my link to test making it not a link"
    Then I should see "this is my link to test making it not a link"
    And I should not see a "this is my link to test making it not a link" link
