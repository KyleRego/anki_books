@javascript
Feature: Creating a basic note


  Scenario: Creating a note for the article
    Given there is a book titled "test book 0" with an article titled "test article 0"
    And I am logged in
    And I am viewing the article
    When I click the "New note" link
    And I fill in the "Front" field with "Front of my note"
    And I fill in the "Back" field with "Back of my note"
    And I click the "Create Basic note" button
    Then I should see "Front of my note" in a basic note
    And I should see "Edit" in a basic note

  Scenario: Error messages when trying to create an invalid note
    Given there is a book titled "test book 0" with an article titled "test article 0"
    And I am logged in
    And I am viewing the article
    When I click the "New note" link
    And I click the "Create Basic note" button
    Then I should see "2 validation errors"
    And I should see "Front can't be blank"
    And I should see "Back can't be blank"

  Scenario: Error messages when trying to create an invalid note for an article with a note
    Given there is a book titled "test book 1" with an article titled "test article 1" that has "3" basic note(s)
    And I am logged in
    And I am viewing the article
    When I click the last "New note" link
    And I click the "Create Basic note" button
    Then I should see "2 validation errors"
    And I should see "Front can't be blank"
    And I should see "Back can't be blank"
