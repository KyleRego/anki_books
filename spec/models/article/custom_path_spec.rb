# frozen_string_literal: true

require "rails_helper"

RSpec.describe Article, "#custom_path" do
  it "returns the custom path for the article" do
    article = create(:article)
    expect(article.custom_path).to eq("/articles/#{article.id}/#{article.title_slug}")
  end
end
