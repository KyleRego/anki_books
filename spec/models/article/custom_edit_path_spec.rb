# frozen_string_literal: true

require "rails_helper"

RSpec.describe Article, "#custom_edit_path" do
  it "returns the custom edit path for the article" do
    article = create(:article)
    expect(article.custom_edit_path).to eq("/articles/#{article.id}/#{article.title_slug}/edit")
  end
end
