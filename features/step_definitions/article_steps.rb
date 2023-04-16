# frozen_string_literal: true

Given "there is an article" do
  @article = Article.create! title: "Hello world"
end

When "I am viewing the article" do
  visit article_path @article
end

When "I am editing the article" do
  visit edit_article_path @article
end

When "I fill in the article editor with {string}" do |text|
  editor = find(".trix-content")
  editor.click
  editor.set(text)
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

Then "I should be redirected to the article" do
  expect(current_path).to eq article_path @article
end

Then "I should be redirected to the editor for the article" do
  expect(current_path).to eq edit_article_path @article
end
