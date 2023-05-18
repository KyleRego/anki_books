@javascript
Feature: Adding lists when editing an article

  Scenario: Updating an article with a title with periods
    Given there is an article with the title "Test . . article . . "
    And I am logged in
    And I am editing the article
    And I fill in the article editor with "some text"
    And I click the "Update Article" button
    Then I should be redirected to the article
    And I should see "some text"
