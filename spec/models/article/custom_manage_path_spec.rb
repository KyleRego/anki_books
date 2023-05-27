# frozen_string_literal: true

require "rails_helper"

RSpec.describe Article, "#custom_manage_path" do
  it "returns the custom manage path for the article" do
    article = create(:article)
    expect(article.custom_manage_path).to eq("/articles/#{article.id}/#{article.title_slug}/manage")
  end
end
