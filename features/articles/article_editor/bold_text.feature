@javascript
Feature: Adding bold text when editing an article

  Background:
    Given there is a book titled "test book 0" with an article titled "test article 0"
    And I am logged in
    And I am editing the article

  Scenario: Adding bold text to the article and saving it
    When I click the "Bold" button
    And I fill in the article editor with "some bold text"
    And I click the "Update Article" button
    Then I should be redirected to the article
    And I should see "some bold text" in bold

  Scenario: Using the keyboard shortcut to add bold text
    When I focus the article editor
    And I use the ctrl + "b" keyboard shortcut
    And I fill in the article editor with "some bold text"
    And I click the "Update Article" button
    Then I should be redirected to the article
    And I should see "some bold text" in bold
