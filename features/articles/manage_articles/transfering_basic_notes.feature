Feature: Moving basic notes to a different article

  Background:
    Given there is a book titled "test book 1" with an article titled "test article 1" that has "7" basic note(s)
    And the book "test book 1" has an article "test article 2" that has 2 basic note(s)
    And I am logged in
    And I click the "My books" link
    And I click the "test book 1" link
    And I click the "Manage articles" link
    And I click the "Manage test article 1" link
  
  Scenario: Transferring basic notes to the other article
    When I check the checkbox for the basic note with front "Front of note 0"
    And I check the checkbox for the basic note with front "Front of note 2"
    And I check the checkbox for the basic note with front "Front of note 5"
    And I click the "Transfer selected basic notes to a different article" button
    Then I should see "Selected basic notes moved to test article 2."
    And I click the "test book 1" link
    And I click the "test article 2" link
    Then I should see "Front of note 0"
    And I should see "Front of note 2"
    And I should see "Front of note 5"
