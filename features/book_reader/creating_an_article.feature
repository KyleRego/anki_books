Feature: Creating an article

  @javascript
  Scenario: Adding an article to a book
    Given I am logged in
    And I have a book with the title "My first book"
    When I visit the root path
    And I click the "My books" link
    And I click the "My first book" link
    And I click the "New article" link
    And I fill in the article editor with "content of a new article"
    And I click the "Create Article" button
    And I click the "My first book" link
    And I click the "My new article" link
    Then I should see "content of a new article"
