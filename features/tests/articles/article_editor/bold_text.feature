@javascript
Feature: Adding bold text when editing an article

  Background:
    Given the test user has a book called "test book 0"
    And the book "test book 0" has an article called "test article 0"
    And I am logged in as the test user
    And I am editing the article "test article 0"

  Scenario: Adding bold text to the article and saving it
    When I click the "Bold" button
    And I fill in the article editor with "some bold text"
    And I click the "Update Article" button
    Then I should be redirected to the article "test article 0"
    And I should see "some bold text" in bold

  Scenario: Using the keyboard shortcut to add bold text
    When I focus the article editor
    And I use the ctrl + "b" keyboard shortcut
    And I fill in the article editor with "some bold text"
    And I click the "Update Article" button
    Then I should be redirected to the article "test article 0"
    And I should see "some bold text" in bold
