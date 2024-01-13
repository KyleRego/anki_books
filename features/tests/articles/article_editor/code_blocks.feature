# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

@javascript
Feature: Adding code blocks when editing an article

  Background:
    Given there is a user "test_user", email "test@example.com", and password "1234asdf!!!!"
    And the user "test_user" has a book called "test book 0"
    And the book "test book 0" has the article "test article 0"
    And I am logged in as the user "test_user" with password: "1234asdf!!!!"
    And I am editing the article "test article 0"

  Scenario: Adding a code block with the "Code" button
    When I click the "Code" button
    And I fill in the article editor with '#include<iostream>;int main(){std::cout<<"Hello, world!";}'
    And I click the "Update Article" button
    And I refresh the page
    Then show JavaScript console
    Then I should see a code block with syntax highlighting
