Feature: Deleting an article

  Background:
    Given there is a book titled "test book 1" with an article titled "test article 1" that has "3" basic note(s)
    And I am logged in
    And I am viewing the article
    And I click the "test book 1" link
    And I click the "Manage articles" link
    And I click the "Manage test article 1" link

  @javascript
  Scenario: Viewing the Manage article page
    Then I should see "Manage test article 1"
    And I should see "Delete test article 1"
    And I should not see "Study cards"
