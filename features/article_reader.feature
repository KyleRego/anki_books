Feature: Reading an article

  Scenario: Clicking the Edit link
    Given I am viewing an article
    When I click the "Edit" link
    Then I should be redirected to the editor for the article
