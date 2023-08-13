Feature: Deleting an article domains

  Background:
    Given the test user has a domain called "Test domain"
    And the test user has a book called "Book of the test domain that is not deleted"
    And the book "Book of the test domain that is not deleted" belongs to the "Test domain" domain
    And I am logged in as the test user
    And I click the "Domains" link
    And I click the "Test domain" link
    And I click the "Manage domain" link

  @javascript
  Scenario: Accepting deleting the domain
    When I click the "Delete Test domain" button and accept the confirmation
    Then I should not see "Test domain"
    And I should see "Book of the test domain that is not deleted"

  @javascript
  Scenario: Dismissing the confirmation for deleting the domain
    When I click the "Delete Test domain" button and dismiss the confirmation
    Then I should see "Test domain"
