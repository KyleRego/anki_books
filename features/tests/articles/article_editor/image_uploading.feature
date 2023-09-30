# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

@javascript
Feature: Uploading images when editing an article

  Background:
    Given there is a user "test_user", email "test@example.com", and password "1234asdf!!!!"
    And the user "test_user" has a book called "test book 0"
    And the book "test book 0" has the article "test article 0"
    And I am logged in as the user "test_user" with password: "1234asdf!!!!"
    And I am editing the article "test article 0"

  Scenario: Uploading an image
    When I drop the fixture image "test_image.png" on the article editor
    Then I should see the fixture image "test_image.png" on the page

  Scenario: Uploading and then removing an image
    When I drop the fixture image "test_image.png" on the article editor
    And I click on the image "test_image.png" on the page
    And I click the "Remove" button
    Then I should not see the image "test_image.png" on the page

  Scenario: Uploading an image should show the filename as the image caption
    When I drop the fixture image "test_image.png" on the article editor
    Then I should see "test_image.png"

  Scenario: Clicking on the default filename image caption should change it to show: Add a caption…
    When I drop the fixture image "test_image.png" on the article editor
    And I click on the span with text "test_image.png"
    Then I should see the textarea placeholder "Add a caption…"

  Scenario: Editing the caption of the uploaded image
    When I drop the fixture image "test_image.png" on the article editor
    And I click on the span with text "test_image.png"
    And I type "this is my caption" on the focused element
    And I click the "Update Article" button
    Then I should see "this is my caption"
