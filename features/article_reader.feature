Feature: Reading an article

Scenario: Clicking the Edit link
  Given I visit the root path
  Given there is an article
  Then show me the page
  Given I am viewing an article
  Then show me the page
  When I click the "Edit" link
  Then show me the page
  Then I should be redirected to the editor for the article
  Then show me the page
