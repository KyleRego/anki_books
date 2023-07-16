Feature: Editing book groups

  Scenario: Editing a new book group
    Given the test user has a book group called "Book group to edit"
    And I am logged in as the test user
    And I click the "My book groups" link
    And I click the "Book group to edit" link
    And I click the "Edit book group" link
    And I fill in the "Title" field with "A new book group title"
    And I click the "Update Book group" button
    Then I should see "A new book group title"
