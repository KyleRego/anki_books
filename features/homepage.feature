Feature: The website homepage
  
  Scenario: Visiting the homepage
    When I visit the root path
    Then I should see the homepage

  Scenario: Visiting the homepage when it has a basic note
    When the homepage has a basic note
    And I visit the root path
    Then I should see "front of homepage basic note"
  