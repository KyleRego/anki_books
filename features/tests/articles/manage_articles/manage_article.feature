Feature: Deleting an article

  Background:
    Given the test user has a book called "test book 1"
    And the book "test book 1" has an article called "test article 1"
    And the article "test article 1" has 3 basic notes
    And I am logged in as the test user
    And I am viewing the article "test article 1"
    And I click the "test book 1" link
    And I click the "test article 1" link
    And I click the "Manage article" link

  @javascript
  Scenario: Viewing the Manage article page
    Then I should see "Manage article: test article 1"
    And I should see "Delete test article 1"
    And I should not see "Study cards"
