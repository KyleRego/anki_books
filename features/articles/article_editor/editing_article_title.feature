@javascript
Feature: Editing the article title

  Scenario: Updating an article with a title with periods
    Given there is a book titled "test book 0" with an article titled "test article 0"
    And I am logged in
    And I am editing the article
    And I fill in the article editor with "some text"
    And I click the "Update Article" button
    Then I should be redirected to the article
    And I should see "some text"
