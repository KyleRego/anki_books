Feature: The top nav links on the page viewing a book

  @javascript
  Scenario: The My books link should be present
    Given I am logged in
    And I have a book with the title "My first book"
    When I visit the root path
    And I click the "My books" link
    And I click the "My first book" link
    Then I should see "My books"
    And I should not see a "My first book" link
