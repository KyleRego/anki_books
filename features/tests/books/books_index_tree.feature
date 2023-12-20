# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

Feature: The Books page tree index

  @javascript
  Scenario: The Books link should not show if I am not logged in
    Given there is a user "test_user", email "test@example.com", and password "1234asdf!!!!"
    And I am logged in as the user "test_user" with password: "1234asdf!!!!"
    And the user "test_user" has a book called "parent book"
    And the user "test_user" has a book called "child book 1"
    And the user "test_user" has a book called "child book 2"
    And the user "test_user" has a book called "child book 3 (1's sibling)"
    And the book "child book 1" is a child of the book "parent book"
    And the book "child book 3 (1's sibling)" is a child of the book "parent book"
    And the book "child book 2" is a child of the book "child book 1"
    When I visit the root path
    And I click the "Books" link
    Then I should see "parent book" 2 times
    And I should see "child book 1" 1 times
    And I should see "child book 3 (1's sibling)" 1 times
    And I should see "child book 2" 1 times
    When I click the "Expand tree node" button
    Then I should see "child book 1" 2 times
    Then I should see "child book 3 (1's sibling)" 2 times
    When I click the "Unexpand tree node" button
    Then I should see "child book 1" 1 times
    When I click the "Expand tree node" button
    And I click the "Expand tree node" button
    Then I should see "child book 2" 2 times
