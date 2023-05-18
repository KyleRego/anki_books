Feature: Deleting an article

  Background:
    Given there is an article with "3" basic note(s)
    And I am logged in
    And I am viewing the article
    And I click the "My books" link
    And I click the "Manage articles" link

  @javascript
  Scenario: Confirmation before deleting an article and confirming deletes the article
    When I click the "Delete This is the test article for Cucumber tests" button and accept the confirmation
    Then I should not see "This is the test article for Cucumber tests"

  @javascript
  Scenario: Confirmation before deleting an article and dismissing does not delete the article
    When I click the "Delete This is the test article for Cucumber tests" button and dismiss the confirmation
    Then I should see "This is the test article for Cucumber tests"
