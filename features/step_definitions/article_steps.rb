# frozen_string_literal: true

CUCUMBER_TEST_BASIC_NOTE_FRONT = "What kind of note is this note?"
CUCUMBER_TEST_BASIC_NOTE_BACK = "This is a Basic note."

# TODO: Remove this step definition and use only the one after it
Given "the test user has the test book {string} with the test article {string}" do |book_title, article_title|
  @test_book = create(:book, title: book_title, users: [@test_user])
  @test_article = create(:article, title: article_title, book: @test_book)
end

Given "the book {string} has an article {string} that has {int} basic note\\(s)" do |book_title, article_title, num|
  book = Book.find_by(title: book_title)
  article = create(:article, title: article_title, book:)
  create_list(:basic_note, num, article:)
end

# rubocop:disable Layout/LineLength
Given "the test user has the test book {string} with the test article {string} that has {string} basic note\\(s)" do |book_title, article_title, string|
  @test_book = create(:book, title: book_title, users: [@test_user])
  @test_article = create(:article, title: article_title, book: @test_book)
  num_notes = string.to_i
  if num_notes == 1
    create(:basic_note, article: @test_article, front: CUCUMBER_TEST_BASIC_NOTE_FRONT,
                        back: CUCUMBER_TEST_BASIC_NOTE_BACK)
  else
    num_notes.times do |i|
      create(:basic_note, article: @test_article, front: "Front of note #{i}", back: "Back of note #{i}")
    end
  end
end
# rubocop:enable Layout/LineLength

When "I am viewing the test article" do
  visit article_path(@test_article)
  sleep 1 if @test_article&.basic_notes&.any?
end

When "I am editing the test article" do
  visit edit_article_path(@test_article)
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

When "I click the Update Article button" do
  click_button "Update Article"
  sleep 0.5
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

Then "I should be redirected to the article" do
  expect(page).to have_current_path article_path(@test_article)
end

Then "I should be redirected to the editor for the article" do
  expect(page).to have_current_path edit_article_path(@test_article)
end

Then "I should see a code block with syntax highlighting" do
  expect(page).to have_selector("pre.hljs[class*=language-]")
end

Then "I should see the homepage" do
  expect(page).to have_content("This is the system article to serve as the homepage.")
end

Then "I should see the Headers button is not active" do
  expect(page).to have_css(".trix-button--icon-heading-1")
  expect(page).not_to have_css(".trix-button--icon-heading-1[data-trix-active]")
end

Then "I should see the fixture image {string} on the page" do |string|
  expect(page).to have_css("img[src$='#{string}']")
end
