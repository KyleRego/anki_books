# frozen_string_literal: true

Given "there is an article" do
  @test_article = Article.create! title: "Hello world"
end

When "I am viewing the article" do
  visit article_path(@test_article, title: @test_article.title_slug)
end

When "I am editing the article" do
  visit edit_article_path(@test_article, title: @test_article.title_slug)
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

Then "I should be redirected to the article" do
  expect(page).to have_current_path article_path(@test_article, title: @test_article.title_slug)
end

Then "I should be redirected to the editor for the article" do
  expect(page).to have_current_path edit_article_path(@test_article, title: @test_article.title_slug)
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
