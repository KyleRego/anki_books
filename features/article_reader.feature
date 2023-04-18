Feature: Reading an article

  Background:
    Given there is an article

  Scenario: Clicking the Edit link if I am logged in
    And I am logged in
    And I am viewing the article
    When I click the "Edit" link
    Then I should be redirected to the editor for the article

  Scenario: Clicking the Edit link if I am not logged in
    And I am viewing the article
    When I click the "Edit" link
    Then I should see "You must be logged in to access this page."