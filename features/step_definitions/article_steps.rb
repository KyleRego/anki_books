# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

CUCUMBER_TEST_BASIC_NOTE_FRONT = "What kind of note is this note?"
CUCUMBER_TEST_BASIC_NOTE_BACK = "This is a Basic note."

Given "the book {string} has the article {string}" do |book_title, article_title|
  book = Book.find_by(title: book_title)
  create(:article, title: article_title, book:)
end

Given "the article {string} has {int} basic notes" do |article_title, number_of_notes|
  article = Article.find_by(title: article_title)
  if number_of_notes == 1
    create(:basic_note, article:, front: CUCUMBER_TEST_BASIC_NOTE_FRONT,
                        back: CUCUMBER_TEST_BASIC_NOTE_BACK)
  else
    number_of_notes.times do |i|
      create(:basic_note, article:, front: "Front of note #{i}", back: "Back of note #{i}")
    end
  end
end

When "I am viewing the article {string}" do |article_title|
  @current_article = Article.find_by(title: article_title)
  visit article_path(@current_article)
  sleep 1 if @current_article&.basic_notes&.any?
end

When "I am editing the article {string}" do |article_title|
  article = Article.find_by(title: article_title)
  visit article_path(article)
  click_link "Edit article"
end

When "I fill in the article editor with {string}" do |text|
  editor = find("trix-editor")
  editor.send_keys text
end

When "I press the Enter key while the article editor is focused" do
  editor = find("trix-editor")
  editor.native.send_keys(:enter)
end

When "I press the Tab key while the article editor is focused" do
  editor = find("trix-editor")
  editor.native.send_keys(:tab)
end

When "I select the text in the article editor" do
  editor = find(".trix-content")
  editor.native.send_keys(:home, :shift, :end)
end

When "I fill in the link URL form with {string}" do |url|
  within "[data-trix-dialog='href']" do
    url_input = find("input.trix-input.trix-input--dialog")
    url_input.click
    url_input.set(url)
  end
end

When "I click the URL form {string} button" do |text|
  within "[data-trix-dialog='href']" do
    click_button text
  end
end

When "I drop the fixture image {string} on the article editor" do |string|
  editor = find(".trix-content")
  editor.drop("./spec/fixtures/#{string}")
  sleep 0.5
end

When "I focus the article editor" do
  element = find(".trix-content")
  page.execute_script("arguments[0].focus();", element)
end

Then "the article {string} should have {int} basic notes" do |string, int|
  article = Article.find_by(title: string)
  expect(article.basic_notes.count).to eq int
end

Then "I should be redirected to the article {string}" do |article_title|
  article = Article.find_by(title: article_title)
  expect(page).to have_current_path article_path(article)
end

Then "I should be redirected to the editor for the article {string}" do |article_title|
  article = Article.find_by(title: article_title)
  expect(page).to have_current_path edit_article_path(article)
end

Then "I should see a code block with syntax highlighting" do
  expect(page).to have_selector("pre.hljs[class*=language-]")
end

Then "I should see the Headers button is not active" do
  expect(page).to have_css(".trix-button--icon-heading-1")
  expect(page).not_to have_css(".trix-button--icon-heading-1[data-trix-active]")
end

Then "I should see the fixture image {string} on the page" do |string|
  expect(page).to have_css("img[src$='#{string}']")
end

When "I check the checkbox for the article with title {string}" do |string|
  article = Article.find_by(title: string)
  check(article.id)
end
