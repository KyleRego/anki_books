@javascript
Feature: Editing the article title

  Scenario: Updating an article with a title with periods
    Given the test user has the test book "test book 0" with the test article "test article 0"
    And I am logged in as the test user
    And I am editing the test article
    And I fill in the article editor with "some text"
    And I click the "Update Article" button
    Then I should be redirected to the article
    And I should see "some text"
