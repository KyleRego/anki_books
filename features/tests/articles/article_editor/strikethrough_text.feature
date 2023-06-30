@javascript
Feature: Adding strikethrough when editing an article

  Background:
    Given the test user has the test book "test book 0" with the test article "test article 0"
    And I am logged in as the test user
    And I am editing the test article

  Scenario: Adding strikethrough text to the article and saving it
    When I click the "Strikethrough" button
    And I fill in the article editor with "some strikethrough text"
    And I click the "Update Article" button
    Then I should be redirected to the article
    And I should see "some strikethrough text" with a strikethrough
