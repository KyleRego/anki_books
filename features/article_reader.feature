Feature: Reading an article

  Background:
    Given there is an article
    And I am viewing the article

  Scenario: Clicking the Edit link
    When I click the "Edit" link
    Then I should be redirected to the editor for the article
