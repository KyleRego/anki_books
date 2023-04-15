Feature: Reading an article

  Scenario: Clicking the Edit link
    Given there is an article
    Given I am viewing the article
    When I click the "Edit" link
    Then I should be redirected to the editor for the article
