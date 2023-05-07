Feature: The website homepage
  
  Scenario: Visiting the homepage
    When I visit the root path
    Then I should see the homepage

  Scenario: Visiting the homepage when it has a basic note
    When the homepage has a basic note
    And I visit the root path
    Then I should see "front of homepage basic note"

  Scenario: Going to the Study cards page and back to the article
    When the homepage has a basic note
    And I visit the root path
    And I click the "Study cards" link
    And I click the "Back to article" link
    Then I should be on the root path
  