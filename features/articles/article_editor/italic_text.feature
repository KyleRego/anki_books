@javascript
Feature: Adding italic text when editing an article

  Background:
    Given the test user has the test book "test book 0" with the test article "test article 0"
    And I am logged in as the test user
    And I am editing the test article

  Scenario: Adding italic text to the article and saving it
    When I click the "Italic" button
    And I fill in the article editor with "some italic text"
    And I click the "Update Article" button
    Then I should be redirected to the article
    And I should see "some italic text" in italics

  Scenario: Using the keyboard shortcut to add italic text
    When I focus the article editor
    And I use the ctrl + "i" keyboard shortcut
    And I fill in the article editor with "some italic text"
    And I click the "Update Article" button
    Then I should be redirected to the article
    And I should see "some italic text" in italics
