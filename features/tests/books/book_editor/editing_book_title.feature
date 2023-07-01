Feature: Editing a book's title

  Background:
    Given I am logged in as the test user
    And I have a book with the title "My first book"
    When I visit the root path
    And I click the "My books" link
    And I click the "My first book" link
    And I click the "Manage book" link
    And I click the "Edit book" link

  Scenario: Visiting the edit book page
    Then I should see "Editing My first book"

  Scenario: Updating the book title
    When I fill in the "Title" field with "new title"
    And I click the "Update Book" button
    And I click the "new title" link
    Then I should see "new title"

  Scenario: Trying to update the book title to be an empty string
    When I fill in the "Title" field with ""
    And I click the "Update Book" button
    Then I should see "A book must have a title."

  Scenario: The link to the book should be present if the update fails
    When I fill in the "Title" field with ""
    And I click the "Update Book" button
    Then I should see a "My first book" link
