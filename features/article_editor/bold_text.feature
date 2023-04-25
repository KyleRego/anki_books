Feature: Editing an article

  Background:
    Given there is an article
    And I am logged in
    And I am editing the article

  Scenario: Adding bold text to the article and saving it
    When I click the "Bold" button
    And I fill in the article editor with "some bold text"
    And I click the "Update Article" button
    Then I should be redirected to the article
    And I should see "some bold text" in bold
