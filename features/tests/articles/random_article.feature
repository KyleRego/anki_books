Feature: Going to a random article
  @javascript
  Scenario: Clicking the random article link on the homepage
    Given I have a book with the title "Reordering test book" and 5 numbered articles
    And I am logged in as the test user
    When I visit the root path
    And I click the "Random article" link
    Then I should see "New note"
