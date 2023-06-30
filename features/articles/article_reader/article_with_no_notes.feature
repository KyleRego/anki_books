Feature: Reading an article with no notes

  Background:
    Given the test user has the test book "test book 0" with the test article "test article 0"

  Scenario: Clicking the Edit link if I am logged in as the test user
    When I am logged in as the test user
    And I am viewing the test article
    When I click the "Edit" link
    Then I should be redirected to the editor for the article

  @javascript
  Scenario: I should see the Create Basic note form if I am logged in as the test user
    When I am logged in as the test user
    And I am viewing the test article
    Then I should see "New note"
    When I click the "New note" link
    Then I should see an input with value "Create Basic note"

  Scenario: I should not see the Study cards link of an article with no notes
    When I am logged in as the test user
    And I am viewing the test article
    Then I should not see "Study cards"
