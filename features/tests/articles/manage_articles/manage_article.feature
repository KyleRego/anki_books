Feature: Deleting an article

  Background:
    Given the test user has the test book "test book 1" with the test article "test article 1" that has "3" basic note(s)
    And I am logged in as the test user
    And I am viewing the test article
    And I click the "test book 1" link
    And I click the "test article 1" link
    And I click the "Manage article" link

  @javascript
  Scenario: Viewing the Manage article page
    Then I should see "Manage article: test article 1"
    And I should see "Delete test article 1"
    And I should not see "Study cards"
