Feature: The website homepage
  
  Scenario: Visiting the homepage
    When I visit the root path
    Then screenshot
    Then I should see "This is the system article to serve as the homepage."
  