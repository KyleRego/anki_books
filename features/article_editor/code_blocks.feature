Feature: Editing an article

  Background:
    Given there is an article
    And I am logged in
    And I am editing the article

  Scenario: Adding a code block with the "Code" button
    When I click the "Code" button
    And I fill in the article editor with '#include<iostream>;int main(){std::cout<<"Hello, world!";}'
    And I click the "Update Article" button
    And I refresh the page
    Then I should see a code block with syntax highlighting