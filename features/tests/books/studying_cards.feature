Feature: Displaying the back of the basic note

  Background:
    Given the test user has the test book "test book 1" with the test article "test article 1" that has "10" basic note(s)
    And I am logged in as the test user
    And I visit the root path
    And I click the "My books" link
    And I click the "test book 1" link

  Scenario: Visiting the book study cards page
    When I click the "Study cards" link
    Then I should not see "test book 1"
    And I click the "Back to book" link
    Then I should see "test book 1"
