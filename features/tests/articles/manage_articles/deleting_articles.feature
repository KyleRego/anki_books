Feature: Deleting an article

  Background:
    Given the test user has the test book "test book 1" with the test article "test article 1" that has "3" basic note(s)
    And I am logged in as the test user
    And I am viewing the test article
    And I click the "test book 1" link
    And I click the "test article 1" link
    And I click the "Manage article" link

  @javascript
  Scenario: Confirmation before deleting an article and confirming deletes the article
    When I click the "Delete test article 1" button and accept the confirmation
    Then I should not see "test article 1"

  @javascript
  Scenario: Confirmation before deleting an article and dismissing does not delete the article
    When I click the "Delete test article 1" button and dismiss the confirmation
    Then I should see "test article 1"
